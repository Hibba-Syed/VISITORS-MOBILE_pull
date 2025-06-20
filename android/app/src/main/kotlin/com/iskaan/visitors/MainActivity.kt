package com.iskaan.visitors

import android.content.ContentValues
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.os.Environment
import android.provider.MediaStore
import android.webkit.MimeTypeMap
import androidx.core.content.FileProvider
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import android.database.Cursor
import java.io.File
import io.flutter.embedding.android.FlutterFragmentActivity

// FlutterFragmentActivity added for biomatric
class MainActivity: FlutterFragmentActivity() {
    // adding CHANNEL for file download
    private val CHANNEL = "com.iskaan.visitors/openFile"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "saveFile" -> {
                    val fileName = call.argument<String>("fileName")
                    val fileContent = call.argument<ByteArray>("fileContent")
                    if (fileName != null && fileContent != null) {
                        saveFile(fileName, fileContent, result)
                    } else {
                        result.error("INVALID_ARGUMENT", "File name or content is null", null)
                    }
                }
                "openFile" -> {
                    val filePath = call.argument<String>("filePath")
                    if (filePath != null) {
                        openFile(filePath, result)
                    } else {
                        result.error("INVALID_ARGUMENT", "File path is null", null)
                    }
                }

                else -> result.notImplemented()
            }
        }
    }

    private fun saveFile(fileName: String, fileContent: ByteArray, result: MethodChannel.Result) {
        try {
            val fileExtension = fileName.substringAfterLast('.', "").lowercase()
            val mimeType = MimeTypeMap.getSingleton().getMimeTypeFromExtension(fileExtension) ?: "application/octet-stream"

            var savedFilePath: String? = null
            var savedFileUri: Uri? = null

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                val contentValues = ContentValues().apply {
                    put(MediaStore.MediaColumns.DISPLAY_NAME, fileName)
                    put(MediaStore.MediaColumns.MIME_TYPE, mimeType)
                    put(MediaStore.MediaColumns.RELATIVE_PATH, Environment.DIRECTORY_DOWNLOADS + "/VMS")
                }

                val contentUri: Uri? = contentResolver.insert(MediaStore.Downloads.EXTERNAL_CONTENT_URI, contentValues)
                if (contentUri != null) {
                    contentResolver.openOutputStream(contentUri)?.use { outputStream ->
                        outputStream.write(fileContent)
                        outputStream.flush()
                    }
                    savedFileUri = contentUri
                    savedFilePath = getRealPathFromURI(contentUri) // Convert content URI to actual file path
                } else {
                    result.error("SAVE_ERROR", "Failed to create file URI.", null)
                    return
                }
            } else {
                val downloadDir = File(Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS), "VMS")
                if (!downloadDir.exists()) {
                    downloadDir.mkdirs()
                }
                val file = File(downloadDir, fileName)
                file.writeBytes(fileContent)
                savedFilePath = file.absolutePath
                savedFileUri = Uri.fromFile(file)
            }

            // Return the correct file path
            if (savedFilePath != null) {
                result.success(savedFilePath) // Return actual file path instead of URI
            } else if (savedFileUri != null) {
                result.success(savedFileUri.toString()) // Return the URI as a fallback
            } else {
                result.error("SAVE_ERROR", "File save failed", null)
            }
        } catch (e: Exception) {
            result.error("SAVE_ERROR", "Failed to save file: ${e.message}", null)
        }
    }

    private fun getRealPathFromURI(contentUri: Uri): String? {
        var result: String? = null
        val cursor: Cursor? = contentResolver.query(contentUri, arrayOf(MediaStore.MediaColumns.DATA), null, null, null)
        cursor?.use {
            if (it.moveToFirst()) {
                val columnIndex = it.getColumnIndex(MediaStore.MediaColumns.DATA)
                if (columnIndex != -1) {
                    result = it.getString(columnIndex)
                }
            }
        }
        return result
    }

    private fun openFile(filePathOrUri: String, result: MethodChannel.Result) {
        try {
            val fileUri: Uri = if (filePathOrUri.startsWith("content://")) {
                Uri.parse(filePathOrUri) // Use provided URI
            } else {
                val file = File(filePathOrUri)
                if (!file.exists()) {
                    result.error("FILE_NOT_FOUND", "File not found: $filePathOrUri", null)
                    return
                }
                FileProvider.getUriForFile(this, "$packageName.fileprovider", file)
            }

            val mimeType = "application/zip" // Force ZIP type

            val intent = Intent(Intent.ACTION_VIEW).apply {
                setDataAndType(fileUri, mimeType)
                addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
                addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            }

            if (intent.resolveActivity(packageManager) != null) {
                startActivity(intent)
                result.success(null)
            } else {
                // No app found, try to open a specific ZIP extractor app
                val zipExtractorIntent = packageManager.getLaunchIntentForPackage("com.rarlab.rar") // Example: WinRAR
                    ?: packageManager.getLaunchIntentForPackage("com.kunkunsoft.zipviewer") // Another ZIP viewer
                    ?: packageManager.getLaunchIntentForPackage("ru.zdevs.zarchiver") // ZArchiver

                if (zipExtractorIntent != null) {
                    startActivity(zipExtractorIntent)
                } else {
                    // Redirect user to Play Store to install a ZIP extractor
                    val playStoreIntent = Intent(Intent.ACTION_VIEW, Uri.parse("market://details?id=com.rarlab.rar"))
                    if (playStoreIntent.resolveActivity(packageManager) != null) {
                        startActivity(playStoreIntent)
                    }
                    result.error("NO_APP", "No ZIP extractor found. Redirecting to Play Store.", null)
                }
            }
        } catch (e: Exception) {
            result.error("ERROR", "Failed to open file: ${e.message}", null)
        }
    }

    private fun getMimeType(filePath: String): String? {
        val extension = filePath.substringAfterLast('.', "").lowercase()
        return MimeTypeMap.getSingleton().getMimeTypeFromExtension(extension)
    }
}
