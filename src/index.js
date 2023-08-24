import { NativeModules, NativeEventEmitter } from "react-native";
export { default as AdMostAdView } from "./AdMostAdView";

export const { AdmostModule, AdmostInterstitial, AdmostRewarded } = NativeModules;
export const AdmostEventEmitter = new NativeEventEmitter(AdmostModule);

export const AIEvents = {
    DID_RECEIVE: 'didReceiveInterstitial',
    DID_FAIL_TO_RECEIVE: 'didFailToReceiveInterstitial',
    DID_SHOW: 'didShowInterstitial',
    DID_FAIL_TO_SHOW: 'didFailToShowInterstitial',
    DID_CLICK: 'didClickInterstitial',
    DID_DISMISS: 'didDismissInterstitial',
  };
  export const AREvents = {
    DID_RECEIVE: 'didReceiveRewardedVideo',
    DID_FAIL_TO_RECEIVE: 'didFailToReceiveRewardedVideo',
    DID_SHOW: 'didShowRewardedVideo',
    DID_CLICK: 'didClickRewardedVideo',
    DID_DISMISS: 'didDismissRewardedVideo',
    DID_COMPLETE: 'didCompleteRewardedVideo',
  };
  export const ABEvents = {
     DID_RECEIVE: 'didReceiveBanner',
     DID_FAIL_TO_RECEIVE: 'didFailToReceiveBanner',
     DID_CLICK: 'didClickBanner',
   };



export default AdmostModule;
