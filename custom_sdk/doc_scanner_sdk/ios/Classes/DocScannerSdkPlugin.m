#import "DocScannerSdkPlugin.h"
#if __has_include(<doc_scanner_sdk/doc_scanner_sdk-Swift.h>)
#import <doc_scanner_sdk/doc_scanner_sdk-Swift.h>
#else
#import "doc_scanner_sdk-Swift.h"
#endif

@implementation DocScannerSdkPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [DocScannerSdkPlugin registerWithRegistrar:registrar];
}
@end
