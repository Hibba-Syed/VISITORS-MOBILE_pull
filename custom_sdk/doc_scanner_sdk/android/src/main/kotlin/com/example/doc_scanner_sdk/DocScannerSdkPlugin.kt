package com.example.doc_scanner_sdk

import android.app.Activity
import android.app.Application
import android.content.Intent
import android.content.IntentSender
import androidx.activity.result.IntentSenderRequest
import androidx.core.app.ActivityCompat.startIntentSenderForResult
import com.google.android.gms.tasks.Task
import com.google.mlkit.vision.documentscanner.GmsDocumentScannerOptions
import com.google.mlkit.vision.documentscanner.GmsDocumentScanning
import com.google.mlkit.vision.documentscanner.GmsDocumentScanningResult
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.ActivityResultListener

class DocScannerSdkPlugin : MethodCallHandler, ActivityResultListener, FlutterPlugin, ActivityAware {
    private var channel: MethodChannel? = null
    private var pluginBinding: FlutterPluginBinding? = null
    private var activityBinding: ActivityPluginBinding? = null
    private var applicationContext: Application? = null
    private val CHANNEL = "doc_scanner_sdk"
    private var activity: Activity? = null

    private val REQUEST_CODE_SCAN = 100001
    private val REQUEST_CODE_SCAN_IMAGES = 100002
    private val REQUEST_CODE_SCAN_PDF = 100003
    private val REQUEST_CODE_SCAN_URI = 100004
    
    private lateinit var resultChannel: Result

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "getPlatformVersion" -> {
                result.success("Android ${android.os.Build.VERSION.RELEASE}")
            }
            "scanDocuments" -> {
                val arguments = call.arguments as? Map<*, *>
                val page = (arguments?.get("page") as? Int)?.coerceAtLeast(1) ?: 4
                resultChannel = result
                startDocumentScan(page, REQUEST_CODE_SCAN)
            }
            "scanDocumentsAsImages" -> {
                val arguments = call.arguments as? Map<*, *>
                val page = (arguments?.get("page") as? Int)?.coerceAtLeast(1) ?: 4
                resultChannel = result
                startDocumentScan(page, REQUEST_CODE_SCAN_IMAGES)
            }
            "scanDocumentsAsPdf" -> {
                val arguments = call.arguments as? Map<*, *>
                val page = (arguments?.get("page") as? Int)?.coerceAtLeast(1) ?: 4
                resultChannel = result
                startDocumentScan(page, REQUEST_CODE_SCAN_PDF)
            }
            "scanDocumentsUri" -> {
                val arguments = call.arguments as? Map<*, *>
                val page = (arguments?.get("page") as? Int)?.coerceAtLeast(1) ?: 4
                resultChannel = result
                startDocumentScan(page, REQUEST_CODE_SCAN_URI)
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    private fun startDocumentScan(page: Int, requestCode: Int) {
        val options = GmsDocumentScannerOptions.Builder()
            .setGalleryImportAllowed(true)
            .setPageLimit(page)
            .setResultFormats(
                GmsDocumentScannerOptions.RESULT_FORMAT_JPEG,
                GmsDocumentScannerOptions.RESULT_FORMAT_PDF
            )
            .setScannerMode(GmsDocumentScannerOptions.SCANNER_MODE_BASE)
            .build()

        val scanner = GmsDocumentScanning.getClient(options)
        val task: Task<IntentSender>? = activity?.let { scanner.getStartScanIntent(it) }
        
        task?.addOnSuccessListener { intentSender ->
            val intent = IntentSenderRequest.Builder(intentSender).build().intentSender
            try {
                startIntentSenderForResult(
                    activity!!,
                    intent,
                    requestCode,
                    null,
                    0,
                    0,
                    0,
                    null
                )
            } catch (e: Exception) {
                resultChannel.error("SCAN_ERROR", e.message, null)
            }
        }?.addOnFailureListener { e ->
            resultChannel.error("SCAN_ERROR", e.message, null)
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        when (requestCode) {
            REQUEST_CODE_SCAN -> handleScanResult(resultCode, data, returnBoth = true)
            REQUEST_CODE_SCAN_IMAGES -> handleScanResult(resultCode, data, returnImages = true)
            REQUEST_CODE_SCAN_PDF -> handleScanResult(resultCode, data, returnPdf = true)
            REQUEST_CODE_SCAN_URI -> handleScanResult(resultCode, data, returnUri = true)
        }
        return false
    }

    private fun handleScanResult(
        resultCode: Int, 
        data: Intent?, 
        returnBoth: Boolean = false,
        returnImages: Boolean = false, 
        returnPdf: Boolean = false,
        returnUri: Boolean = false
    ) {
        if (resultCode == Activity.RESULT_OK) {
            val scanningResult = GmsDocumentScanningResult.fromActivityResultIntent(data)
            
            when {
                returnBoth -> {
                    val images = scanningResult?.getPages()?.map { it.imageUri.toString() } ?: emptyList()
                    val pdfUri = scanningResult?.getPdf()?.getUri()?.toString()
                    val pageCount = scanningResult?.getPdf()?.getPageCount() ?: 0
                    resultChannel.success(mapOf(
                        "images" to images,
                        "pdfUri" to pdfUri,
                        "pageCount" to pageCount
                    ))
                }
                returnImages -> {
                    val images = scanningResult?.getPages()?.map { it.imageUri.toString() } ?: emptyList()
                    resultChannel.success(images)
                }
                returnPdf -> {
                    scanningResult?.getPdf()?.let { pdf ->
                        resultChannel.success(mapOf(
                            "pdfUri" to pdf.getUri().toString(),
                            "pageCount" to pdf.getPageCount()
                        ))
                    } ?: resultChannel.error("SCAN_FAILED", "No PDF result", null)
                }
                returnUri -> {
                    scanningResult?.getPages()?.let { pages ->
                        resultChannel.success(mapOf(
                            "uris" to pages.map { it.imageUri.toString() },
                            "count" to pages.size
                        ))
                    } ?: resultChannel.error("SCAN_FAILED", "No URI result", null)
                }
            }
        } else if (resultCode == Activity.RESULT_CANCELED) {
            resultChannel.success(null)
        } else {
            resultChannel.error("SCAN_FAILED", "Scanning failed", null)
        }
    }

    override fun onAttachedToEngine(binding: FlutterPluginBinding) {
        pluginBinding = binding
    }

    override fun onDetachedFromEngine(binding: FlutterPluginBinding) {
        pluginBinding = null
    }

    override fun onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity()
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        onAttachedToActivity(binding)
    }

    private fun createPluginSetup(
        messenger: BinaryMessenger,
        applicationContext: Application?,
        activity: Activity,
        activityBinding: ActivityPluginBinding?
    ) {
        this.activity = activity
        this.applicationContext = applicationContext
        channel = MethodChannel(messenger, CHANNEL)
        channel!!.setMethodCallHandler(this)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activityBinding = binding
        activityBinding?.addActivityResultListener(this)
        createPluginSetup(
            pluginBinding!!.binaryMessenger,
            pluginBinding!!.applicationContext as Application,
            activityBinding!!.activity,
            activityBinding
        )
    }

    override fun onDetachedFromActivity() {
        activityBinding?.removeActivityResultListener(this)
        activityBinding = null
    }
}
