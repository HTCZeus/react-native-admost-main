//
//  AdMostAdView.swift

import Foundation
import UIKit
import AMRSDK

class AdMostAdView: UIView, AMRBannerDelegate {

    var mpuBanner: AMRBanner!
    var adZoneId: NSString!
    var adLayoutName: NSString!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func loadAd() {
        if mpuBanner == nil {
            mpuBanner = AMRBanner.init(forZoneId: adZoneId as String)
            mpuBanner.delegate = self
            mpuBanner.bannerWidth = self.bounds.size.width

            if adLayoutName != "DEFAULT" {
                mpuBanner.customNativeSize = CGSize(width: self.bounds.size.width, height: self.bounds.size.height)
                mpuBanner.customeNativeXibName = adLayoutName as String?
            }
        }
        mpuBanner.load()
    }

    func destroyAd() {

    }

    func didReceive(_ banner: AMRBanner!) {
        self.addSubview(banner.bannerView)
        AdmostModule.instance.sendEvent(eventName: "didReceiveBanner", body: ["zoneId": adZoneId])
    }

    func didFail(toReceive banner: AMRBanner!, error: AMRError!) {
        AdmostModule.instance.sendEvent(
            eventName: "didFailToReceiveBanner",
            body: ["zoneId": adZoneId!, "errorCode": error.errorCode, "errorDescription": error.errorDescription!] as [String : Any]
        )
    }

    func didClick(_ banner: AMRBanner!) {
        AdmostModule.instance.sendEvent(eventName: "didClickBanner", body: ["zoneId": adZoneId])
    }

    @objc var zoneId: NSString = "" {
        didSet {
            adZoneId = zoneId;
        }
    }

    @objc var layoutName: NSString = "DEFAULT" {
        didSet {
            adLayoutName = layoutName;
        }
    }
}
