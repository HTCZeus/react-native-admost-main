import Foundation
import AMRSDK
import AppTrackingTransparency
import AdSupport

@objc(AdmostInterstitial)
class AdmostInterstitial: NSObject, AMRInterstitialDelegate {

   @objc
   static func requiresMainQueueSetup() -> Bool {
     return true
   }
  var interstitial: AMRInterstitial? 
      var zoneID: String?
      
  
  
      @objc
      func initWithZoneID(_ zoneID: String, resolver resolve: RCTPromiseResolveBlock, rejecter reject: RCTPromiseRejectBlock) {
          self.zoneID = zoneID
          self.interstitial = AMRInterstitial(forZoneId: zoneID)
          self.interstitial?.delegate = self
          resolve(true)
      }
      
      @objc
      func loadAd(_ resolve: RCTPromiseResolveBlock, rejecter reject: RCTPromiseRejectBlock) {
          self.interstitial?.load()
        print("Interstitial load")
          resolve(true)
      }
        
      @objc
      func showAd(_ resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
        DispatchQueue.main.async {
          guard let rootViewController = UIApplication.shared.delegate?.window??.rootViewController else {
            reject("ERROR_ROOT_VIEW_CONTROLLER", "Failed to retrieve root view controller", nil)
            return
          }
          self.interstitial?.show(from: rootViewController)
          resolve(nil)
        }
      }
      
    func didFail(toReceive interstitial: AMRInterstitial!, error: AMRError) {
      AdmostModule.instance.sendEvent(
          eventName: "didFailToReceiveInterstitial",
          body: ["errorDescription": error.errorDescription!]
      )}
      
    func didReceive(_ interstitial: AMRInterstitial!) {
      AdmostModule.instance.sendEvent(
      eventName: "didReceiveInterstitial",
      body: ["network": interstitial.networkName!, "ecpm": interstitial.ecpm!] as [String : Any]
      )}
      
    func didShow(_ interstitial: AMRInterstitial!) {
      AdmostModule.instance.sendEvent(
      eventName: "didShowInterstitial",
      body: ["network": interstitial.networkName!]
      )}
      
      
    func didClick(_ interstitial: AMRInterstitial!) {
      AdmostModule.instance.sendEvent(
      eventName: "didClickInterstitial",
      body: ["network": interstitial.networkName!]
      )}
      
    func didDismiss(_ interstitial: AMRInterstitial!) {
      AdmostModule.instance.sendEvent(
      eventName: "didDismissInterstitial",
      body: ["zoneId": interstitial.zoneId!]
      )}
}
