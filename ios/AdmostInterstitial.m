
#import <Foundation/Foundation.h>
#import "React/RCTBridgeModule.h"

@interface RCT_EXTERN_MODULE(AdmostInterstitial, NSObject)
RCT_EXTERN_METHOD(initWithZoneID: (NSString *)zoneID resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
RCT_EXTERN_METHOD(loadAd: (RCTPromiseResolveBlock) resolve rejecter:(RCTPromiseRejectBlock)reject)
RCT_EXTERN_METHOD(showAd: (RCTPromiseResolveBlock) resolve rejecter:(RCTPromiseRejectBlock)reject)

@end

  
  
