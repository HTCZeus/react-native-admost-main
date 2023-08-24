//
//  AdmostRewarded.swift
//  admostrn

import Foundation
import AMRSDK
import AppTrackingTransparency
import AdSupport

@objc(AdmostRewarded)
class AdmotRewewarded : NSObject, AMRRewardedVideoDelegate {
  
  var rewardedVideo : AMRRewardedVideo!
  var zoneID : String?
  
  @objc
  static func requiresMainQueueSetup() -> Bool {
    return true
  }
  
  @objc
  func initWithZoneID(_ zoneID: String, resolver resolve: RCTPromiseResolveBlock, rejecter reject: RCTPromiseRejectBlock){
    
    self.zoneID = zoneID
    self.rewardedVideo = AMRRewardedVideo(forZoneId: zoneID)
    self.rewardedVideo?.delegate = self
    resolve(true)
    
  }
  
  @objc
  func loadAd (_ resolve : RCTPromiseResolveBlock, rejecter reject: RCTPromiseRejectBlock){
    self.rewardedVideo?.load()
    print("Rewarded Load")
    resolve(true)
  }
  
  @objc
  func showAd(_ resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
    DispatchQueue.main.async {
      guard let rootViewController = UIApplication.shared.delegate?.window??.rootViewController else {
        reject("ERROR_ROOT_VIEW_CONTROLLER", "Failed to retrieve root view controller", nil)
        return
      }
      self.rewardedVideo?.show(from: rootViewController)
      resolve(nil)
    }
  }
  

  
  func didFail(toReceive rewardedVideo: AMRRewardedVideo!, error: AMRError) {
    AdmostModule.instance.sendEvent(
        eventName: "didFailToReceiveRewardedVideo",
        body: ["errorDescription": error.errorDescription!]
    )}
    
  func didReceive(_ rewardedVideo: AMRRewardedVideo!) {
    AdmostModule.instance.sendEvent(
    eventName: "didReceiveRewardedVideo",
    body: ["network": rewardedVideo.networkName!, "ecpm": rewardedVideo.ecpm!] as [String : Any]
    )}
    
  func didShow(_ rewardedVideo: AMRRewardedVideo!) {
    AdmostModule.instance.sendEvent(
    eventName: "didShowRewardedVideo",
    body: ["network": rewardedVideo.networkName!]
    )}
    
    
  func didClick(_ rewardedVideo: AMRRewardedVideo!) {
    AdmostModule.instance.sendEvent(
    eventName: "didClickRewardedVideo",
    body: ["network": rewardedVideo.networkName!]
    )}
    
  func didDismiss(_ rewardedVideo: AMRRewardedVideo!) {
    AdmostModule.instance.sendEvent(
    eventName: "didDismissRewardedVideo",
    body: ["zoneId": rewardedVideo.zoneId!]
    )}
  
  func didComplete(_ rewardedVideo: AMRRewardedVideo!) {
    AdmostModule.instance.sendEvent(eventName: "didCompleteRewardedVideo",  body: ["network": rewardedVideo.networkName!]
  )}
  
}
