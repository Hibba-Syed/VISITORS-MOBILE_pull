import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:progress_dialog2/progress_dialog2.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../repo/encrption/encryption_helper.dart';
import '../../resource/constants/api_url.dart';
import '../../resource/globals.dart';
import '../../view/widgets/Alert_dialog_box/custom_alert_dialog_box.dart';


class FileDownloader {
  static String getBundleId() {
    if (Platform.isAndroid) {
      return 'com.iskaan.visitors';
    } else if (Platform.isIOS) {
      return 'com.iskaan.visitors';
    }
    return 'com.iskaan.visitors';
  }

  static final _platform = MethodChannel('${getBundleId()}/openFile');

  /// Main entry point for downloading PDF
  static Future<void> downloadFile({
    required BuildContext context,
    required String dateRage,
  }) async {


    // Determine download URL based on the type
    final downloadUrl = _getDownloadUrl(
        dateRange: dateRage
    );

    final token = _getAuthToken(context);
    final progressDialog = _createProgressDialog(context);

    try {
      final response =
      await http.get(downloadUrl, headers: {"Authorization": token, "User-Agent": "Windows"});
      // print("Status Code ${response.statusCode}");
      if (response.statusCode == 200 && context.mounted) {
        await _handleFileDownload(
            context, progressDialog, response);
      } else if(response.statusCode== 404){
        progressDialog.hide();
        if(context.mounted){
          _showErrorDialog(context, jsonDecode(response.body)['message']);
        }
      } else if (response.statusCode == 500) {
        progressDialog.hide();
        if(context.mounted){
          _showErrorDialog(context,
              "An error occurred while downloading the document. Please try again. If the issue persists, contact our support team for assistance.");
        }
      } else {
        if(context.mounted){
          _handleDownloadError(context, progressDialog, response);
        }
      }
    } catch (e) {
      if(context.mounted){
        _showErrorDialog(context, "An unexpected error occurred: $e");
        progressDialog.hide();
      }
    }
  }
  /// Get the download URL based on the file type
  static Uri _getDownloadUrl({String? dateRange}) {
   // final dateRange = getDateRangeStringFromLabel('Last 30 Days');
    final filter = {
      "date_range": dateRange,
      "export": true,
      "timezone": "Asia/Karachi"
    };
    // print("FILTER:::: ${vendors.toString()}");
    // print(EncryptionHelper.encryptPayload(vendors));

    final encryptedPayload = Uri.encodeComponent(EncryptionHelper.encryptPayload(filter));
    final url = Uri.parse('${ApiUrl.checkOuts}?xyz=$encryptedPayload');

    return url;
  }


  /// Get authentication token
  static String _getAuthToken(BuildContext context) {
    return "Bearer ${Globals().token ?? ""}";
  }

  /// Create and show progress dialog
  static ProgressDialog _createProgressDialog(BuildContext context) {
    final progressDialog = ProgressDialog(context,
        type: ProgressDialogType.Normal, showLogs: true, isDismissible: false);
    progressDialog.style(message: 'Downloading File...');
    progressDialog.show();
    return progressDialog;
  }

  /// Handle file download process
  static Future<void> _handleFileDownload(
      BuildContext context,
      ProgressDialog progressDialog,
      http.Response response) async {
    String? filename = _extractFileName(
        response.headers['content-disposition']);
    // print("RESPONSE HEADERS:::: ${response.headers}");
    // print("RESPONSE HEADERS SPLITTED:::: ${response.headers}");
    String? filePath = await _saveFileInIsolate(SaveFileParams(
      data: response.bodyBytes,
      filename: filename,
      rootIsolateToken: RootIsolateToken.instance!,
    ));

    progressDialog.hide();

    if (filePath != null && context.mounted) {
      _onDownloadSuccess(
          context, filePath, response.headers['content-disposition']);
    } else {
      if (context.mounted){
        _showErrorDialog(context, "Error saving the file.");
      }
    }
  }

  /// Extract file name from response headers or construct default name
  static String _extractFileName(
      String? contentDisposition) {
    if (contentDisposition != null) {
      final regExp = RegExp(r'filename="?(.*\.(\w+))"?');
      final match = regExp.firstMatch(contentDisposition);
      if (match != null) {
        return match.group(1) ?? "checkout.";
      }
    }
    return "checkout.pdf";
  }

  /// Handle download error based on the response status code
  static void _handleDownloadError(BuildContext context,
      ProgressDialog progressDialog, http.Response response) {
    progressDialog.hide();
    final errorMsg = response.body.isNotEmpty
        ? response.body
        : "Error downloading the file.";
    _showErrorDialog(context, errorMsg);
  }

  /// Show success dialog after file is downloaded
  static void _onDownloadSuccess(
      BuildContext context, String filePath, String? contentDisposition) {
    // print("FILE PATH IS:::: $filePath");
    // print("FILE TYPE IS:::: $contentDisposition");
    if (contentDisposition?.contains("zip") ?? false) {
      _openFileBasedOnPlatform(filePath);
      Fluttertoast.showToast(msg: "File has been downloaded successfully!");
    } else {
      _showSuccessDialog(
          context, "File has been downloaded successfully!", filePath);
    }
  }

  /// Open the file based on the platform
  static Future<void> _openFileBasedOnPlatform(String filePath) async {
    if (Platform.isAndroid) {
      await openAndroidFile(filePath);
    } else {
      await openIosFile(filePath);
    }
  }

  /// Open the file on Android
  static Future<void> openAndroidFile(String filePath) async {
    try {
      await _platform.invokeMethod('openFile', {'filePath': filePath});
    } on PlatformException catch (e) {
      // print("Failed to open file: ${e.message}");
    }
  }

  /// Open the file on iOS
  static Future<void> openIosFile(String filePath) async {
    try {
      await _platform.invokeMethod('openFile', {'filePath': filePath});
    } on PlatformException catch (e) {
      // print(e.code);
      // print(e.details);
      // print(e.stacktrace);
      // print("Failed to open file: ${e.message}");
    }
  }

  /// Save the file using isolates
  static Future<String?> _saveFileInIsolate(SaveFileParams params) async {
    BackgroundIsolateBinaryMessenger.ensureInitialized(params.rootIsolateToken);

    if ((Platform.isAndroid)) {
      try {
        final result = await _platform.invokeMethod('saveFile', {
          'fileName': params.filename,
          'fileContent': params.data,
        });
        return result as String?;
      } on PlatformException catch (e) {
        // print("Failed to save file: ${e.message}");
        return null;
      }
    } else {
      return _saveFileForNonAndroid(params);
    }
  }

  /// Save the file for non-Android platforms
  static Future<String?> _saveFileForNonAndroid(SaveFileParams params) async {
    try {
      final directory = Platform.isAndroid
          ? Directory('/storage/emulated/0/Download')
          : await getApplicationDocumentsDirectory();
      final filePath = "${directory.path}/${params.filename}";

      await Directory(directory.path).create(recursive: true);

      final file = File(filePath);
      await file.writeAsBytes(params.data);

      // print("File saved at: $filePath");
      return filePath;
    } catch (e) {
      // print("Error while saving file: $e");
      return null;
    }
  }

  /// Show success dialog
  static void _showSuccessDialog(
      BuildContext context, String message, String filePath) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => CustomAlertDialogBox(
        insetPadding: EdgeInsets.all(10),
        title: "Download Complete",
        confirmButtonText: "Open File",
        cancelButtonText: "No",
        onConfirm: () async {
          // print(filePath);
          // bool isGranted = true;
          // if(Platform.isAndroid){
          //   isGranted = await requestStoragePermission();
          // }
          // if(isGranted){
          openFile(filePath);
          //   OpenFile.open(filePath).then((value){
          //   print("TYPE:::: ${value.type}");
          //   print("MESSAGE::::: ${value.message}");
          // });
          // }
          return true;
        },
        contentBuilder: (p0, p1) {
          return const Text(
            "File downloaded successfully",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          );
        },
      ),
    );
  }

  static Future<void> openFile(String filePath) async {
    // bool isGranted = true;

    // if (Platform.isAndroid) {
    //   // isGranted = await requestStoragePermission();
    // }
    // print("Path Starts $isGranted");

    // if (isGranted) {
    try {
      // print("Path Starts::::::::  $filePath");
      if (Platform.isAndroid && filePath.startsWith("/storage/emulated/")) {
        if (await File(filePath).exists()) {
          OpenFile.open(filePath);
        } else {
          // print("File does not exist: $filePath");
        }
      } else if (Platform.isAndroid && filePath.startsWith("content://")) {
        // print("CONTENT");
        await launchUrl(Uri.parse(filePath));
      } else {
        OpenFile.open(filePath);
      }
    } catch (e) {
      // print("Error opening file: $e");
    }
    // }
  }

  /// Show error dialog
  static void _showErrorDialog(BuildContext context, String message) {
    if(context.mounted){
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }

  }
}

/// Parameters passed to the isolate
class SaveFileParams {
  final List<int> data;
  final String filename;
  final RootIsolateToken rootIsolateToken;

  SaveFileParams({
    required this.data,
    required this.filename,
    required this.rootIsolateToken,
  });
}

