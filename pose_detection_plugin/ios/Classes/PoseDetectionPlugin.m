#import "PoseDetectionPlugin.h"
#if __has_include(<pose_detection_plugin/pose_detection_plugin-Swift.h>)
#import <pose_detection_plugin/pose_detection_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "pose_detection_plugin-Swift.h"
#endif

@implementation PoseDetectionPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftPoseDetectionPlugin registerWithRegistrar:registrar];
}
@end
