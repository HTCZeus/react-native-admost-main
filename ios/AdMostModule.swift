//
//  AdmostModule.swift
import Foundation
import AMRSDK
import AppTrackingTransparency
import AdSupport

@objc(AdmostModule)
class AdmostModule: RCTEventEmitter {
  
    public static var instance: AdmostModule!

    override init() {
        super.init()
        AdmostModule.instance = self
      }

    var appID: String? 
    var userConsents: Bool?
    var subjectToGDPR: Bool?
    var userChild: Bool?
    var setUserId: Bool?
  
    @objc
    func setAppID(_ appID: String) {
        self.appID = appID
    }
    
    @objc
    func setUserConsents(_ userConsents: Bool) {
        self.userConsents = userConsents
        AMRSDK.setUserConsent(userConsents)
    }
    
    @objc
    func setSubjectToGDPR(_ subjectToGDPR: Bool) {
        self.subjectToGDPR = subjectToGDPR
        AMRSDK.subject(toGDPR: subjectToGDPR)
    }
    @objc
    func setSubjectToCCPA(_ subjectToCCPA: Bool) {
        self.subjectToCCPA = subjectToCCPA
        AMRSDK.subject(toCCPA: subjectToCCPA)
    }
    
    @objc
    func setUserChild(_ userChild: Bool) {
        self.userChild = userChild
        AMRSDK.setUserChild(userChild)
    }
        
    @objc
    func setUserId(_ userId: String) {
        AMRSDK.setUserId(userId)
    }
  
  
    
  @objc
  func start(_ resolve: @escaping RCTPromiseResolveBlock, reject:  @escaping RCTPromiseRejectBlock) {
      guard let appID = self.appID else {
          reject("ERROR_APPID", "appID is nil", nil)
          return
      }
    
    if #available(iOS 14.5, *) {
        ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
            AMRSDK.updateATTStatus()
            // Tracking authorization completed.
        })
    }
    AMRSDK.start(withAppId: appID) { error in
      
      if let error = error {
        reject("INIT_FAILED", "Admost SDK initialization failed", error as? Error)
      }
      else {
        resolve("Admost Inıt Success, Inıt with  AppID: \(appID)")

      }
    }
  }
  
   
   public func sendEvent(eventName: String, body: Any?) -> Void {
          sendEvent(withName: eventName, body: body)
      }
  override  func supportedEvents() -> [String]! {
          return [
              "didReceiveBanner",
              "didFailToReceiveBanner",
              "didClickBanner",
              "didFailToReceiveInterstitial",
              "didReceiveInterstitial",
              "didShowInterstitial",
              "didFailToShowInterstitial",
              "didClickInterstitial",
              "didDismissInterstitial",
              "didReceiveRewardedVideo",
              "didFailToReceiveRewardedVideo",
              "didDismissRewardedVideo",
              "didCompleteRewardedVideo",
              "didShowRewardedVideo",
              "didClickRewardedVideo",
          ]

      }
    
    @objc
    override static func requiresMainQueueSetup() -> Bool {
      return false
    }
}
