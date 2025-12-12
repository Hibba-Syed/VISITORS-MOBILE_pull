import Flutter
import UIKit
import Vision
import VisionKit
import PDFKit

@available(iOS 13.0, *)
public class DocScannerSdkPlugin: NSObject, FlutterPlugin, VNDocumentCameraViewControllerDelegate {
    var resultChannel: FlutterResult?
    var presentingController: VNDocumentCameraViewController?
    var currentMethod: String?

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "doc_scanner_sdk", binaryMessenger: registrar.messenger())
        let instance = DocScannerSdkPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getPlatformVersion":
            result("iOS " + UIDevice.current.systemVersion)
            
        case "scanDocuments", "scanDocumentsAsImages", "scanDocumentsAsPdf":
            startScanning(method: call.method, result: result)
            
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func startScanning(method: String, result: @escaping FlutterResult) {
        guard VNDocumentCameraViewController.isSupported else {
            result(FlutterError(code: "NOT_SUPPORTED", message: "Document scanning not supported", details: nil))
            return
        }
        
        let presentedVC: UIViewController? = UIApplication.shared.keyWindow?.rootViewController
        self.resultChannel = result
        self.currentMethod = method
        self.presentingController = VNDocumentCameraViewController()
        self.presentingController!.delegate = self
        presentedVC?.present(self.presentingController!, animated: true)
    }

    func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    func getTimestamp() -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyyMMdd-HHmmss"
        return df.string(from: Date())
    }

    public func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        switch currentMethod {
        case "scanDocuments":
            let images = saveScannedImages(scan: scan)
            let pdfPath = saveScannedPdf(scan: scan)
            resultChannel?(["images": images, "pdfPath": pdfPath ?? "", "pageCount": scan.pageCount])
            
        case "scanDocumentsAsImages":
            resultChannel?(saveScannedImages(scan: scan))
            
        case "scanDocumentsAsPdf":
            if let pdfPath = saveScannedPdf(scan: scan) {
                resultChannel?(["pdfPath": pdfPath, "pageCount": scan.pageCount])
            } else {
                resultChannel?(FlutterError(code: "PDF_ERROR", message: "Failed to create PDF", details: nil))
            }
            
        default:
            resultChannel?(saveScannedImages(scan: scan))
        }
        presentingController?.dismiss(animated: true)
    }

    private func saveScannedImages(scan: VNDocumentCameraScan) -> [String] {
        let tempDirPath = getDocumentsDirectory()
        let timestamp = getTimestamp()
        var filenames: [String] = []
        for i in 0 ..< scan.pageCount {
            let page = scan.imageOfPage(at: i)
            let url = tempDirPath.appendingPathComponent("\(timestamp)-\(i).png")
            try? page.pngData()?.write(to: url)
            filenames.append(url.path)
        }
        return filenames
    }

    private func saveScannedPdf(scan: VNDocumentCameraScan) -> String? {
        let tempDirPath = getDocumentsDirectory()
        let timestamp = getTimestamp()
        let pdfFilePath = tempDirPath.appendingPathComponent("\(timestamp).pdf")
        let pdfDocument = PDFDocument()
        for i in 0 ..< scan.pageCount {
            if let pdfPage = PDFPage(image: scan.imageOfPage(at: i)) {
                pdfDocument.insert(pdfPage, at: pdfDocument.pageCount)
            }
        }
        do {
            try pdfDocument.write(to: pdfFilePath)
            return pdfFilePath.path
        } catch { return nil }
    }

    public func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
        resultChannel?(nil)
        presentingController?.dismiss(animated: true)
    }

    public func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
        resultChannel?(FlutterError(code: "SCAN_ERROR", message: error.localizedDescription, details: nil))
        presentingController?.dismiss(animated: true)
    }
}
