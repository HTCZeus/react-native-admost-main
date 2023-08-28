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

public class AdmostInterstitial extends ReactContextBaseJavaModule {

    private final ReactApplicationContext reactContext;
    private static final String TAG = "ADMOST";
    private String zoneID;
    private AdMostInterstitial interstitial;
    private Boolean autoShow = false;



    AdmostInterstitial(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
    }
    @Override
    public String getName() {
        return "AdmostInterstitial";
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
        Log.i(TAG, "Starting interstitial with " + this.zoneID);
        this.interstitial = new AdMostInterstitial(getCurrentActivity(), this.zoneID, new AdMostFullScreenCallBack() {

            @Override
            public void onDismiss(String message) {
                WritableMap params = Arguments.createMap();
                params.putString("message", message);
                AdmostModule.sendEvent(reactContext,"didDismissInterstitial",params);
            }
            @Override
            public void onFail(int errorCode) {
                WritableMap params = Arguments.createMap();
                params.putInt("errorCode", errorCode);
                AdmostModule.sendEvent(reactContext,"didFailToReceiveInterstitial", params);
            }
            @Override
            public void onReady(String network, int ecpm) {
                WritableMap params = Arguments.createMap();
                params.putString("network", network);
                params.putInt("ecpm", ecpm);
                AdmostModule.sendEvent(reactContext,"didReceiveInterstitial", params);
            }
            @Override
            public void onShown(String network) {
                WritableMap params = Arguments.createMap();
                params.putString("network", network);
                AdmostModule.sendEvent(reactContext,"didShowInterstitial", params);
            }
            @Override
            public void onClicked(String s) {
                WritableMap params = Arguments.createMap();
                params.putString("s", s);
                AdmostModule.sendEvent(reactContext,"didClickInterstitial", params);
            }

            @Override
            public void onComplete(String s) {
                // If you are using interstitial, this callback will not be triggered.
            }

        });
        promise.resolve(true);
    }

    @ReactMethod
    public void loadAd(Promise promise) {
        this.interstitial.refreshAd(this.autoShow);
        promise.resolve(true);
    }

    @ReactMethod
    public void showAd(Promise promise) {
        this.interstitial.show();
        promise.resolve(null);
    }

    @ReactMethod
    public void destroyAd(Promise promise) { //
        this.interstitial.destroy();
        promise.resolve(null);
    }

}