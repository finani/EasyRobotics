#import "NativeCppPlugin.h"
#if __has_include(<native_cpp/native_cpp-Swift.h>)
#import <native_cpp/native_cpp-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "native_cpp-Swift.h"
#endif

@implementation NativeCppPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftNativeCppPlugin registerWithRegistrar:registrar];
}
@end
