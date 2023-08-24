#import <Foundation/Foundation.h>
#import "React/RCTBridgeModule.h"
#import "React/RCTEventEmitter.h"

@interface RCT_EXTERN_MODULE(AdmostModule, RCTEventEmitter)
RCT_EXTERN_METHOD(setAppID: (NSString *)appID)
RCT_EXTERN_METHOD(setUserConsents: (BOOL)userConsents)
RCT_EXTERN_METHOD(setSubjectToGDPR: (BOOL)subjectToGDPR)
RCT_EXTERN_METHOD(setUserChild: (BOOL)userChild)
RCT_EXTERN_METHOD(setUserId: (NSString *)userId)
RCT_EXTERN_METHOD(start: (RCTPromiseResolveBlock)resolve reject: (RCTPromiseRejectBlock)reject)
@end

