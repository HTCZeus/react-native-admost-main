package com.admost.reactnative;
import android.util.Log;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import admost.sdk.AdMostInterstitial;
import admost.sdk.listener.AdMostFullScreenCallBack;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.modules.core.DeviceEventManagerModule;
import com.facebook.react.bridge.Arguments;

public class AdmostRewarded extends ReactContextBaseJavaModule {

    private final ReactApplicationContext reactContext;
    private static final String TAG = "ADMOST";
    private String zoneID;
    private AdMostInterstitial rewarded;
    private Boolean autoShow = false;



    AdmostRewarded(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
    }

    @Override
    public String getName() {
        return "AdmostRewarded";
    }

    @ReactMethod
    public void setAutoShow(Boolean autoShow) {
        this.autoShow = autoShow;
    }

    @ReactMethod
    public void initWithZoneID(String zoneID, Promise promise) {
        this.zoneID = zoneID;
        if(getCurrentActivity() == null){
            Log.e(TAG, "Current activity is null!");
            return;
        }
        Log.i(TAG, "Starting Rewarded with " + this.zoneID);
        this.rewarded = new AdMostInterstitial(getCurrentActivity(), this.zoneID, new AdMostFullScreenCallBack() {

            @Override
            public void onDismiss(String message) {
                WritableMap params = Arguments.createMap();
                params.putString("message", message);
                AdmostModule.sendEvent(reactContext,"didDismissRewardedVideo",params);
            }
            @Override
            public void onFail(int errorCode) {
                WritableMap params = Arguments.createMap();
                params.putInt("errorCode", errorCode);
                AdmostModule.sendEvent(reactContext,"didFailToReceiveRewardedVideo", params);
            }
            @Override
            public void onReady(String network, int ecpm) {
                WritableMap params = Arguments.createMap();
                params.putString("network", network);
                params.putInt("ecpm", ecpm);
                AdmostModule.sendEvent(reactContext,"didReceiveRewardedVideo", params);
            }
            @Override
            public void onShown(String network) {
                WritableMap params = Arguments.createMap();
                params.putString("network", network);
                AdmostModule.sendEvent(reactContext,"didShowRewardedVideo", params);
            }
            @Override
            public void onClicked(String s) {
                WritableMap params = Arguments.createMap();
                params.putString("s", s);
                AdmostModule.sendEvent(reactContext,"didClickRewardedVideo", params);
            }

            @Override
            public void onComplete(String network) {
                WritableMap params = Arguments.createMap();
                params.putString("network", network);
                AdmostModule.sendEvent(reactContext,"didCompleteRewardedVideo", params);
            }


        });
        promise.resolve(true);
    }

    @ReactMethod
    public void loadAd(Promise promise) {
        this.rewarded.refreshAd(this.autoShow);
        promise.resolve(true);
    }

    @ReactMethod
    public void showAd(Promise promise) {
        this.rewarded.show();
        promise.resolve(null);
    }

    @ReactMethod
    public void destroyAd(Promise promise) {
        this.rewarded.destroy();
        promise.resolve(null);
    }


}