package com.admost.reactnative;
import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.modules.core.DeviceEventManagerModule;

import android.util.Log;



import admost.sdk.base.AdMostConfiguration;
import admost.sdk.base.AdMost;
import admost.sdk.listener.AdMostInitListener;


public class AdmostModule extends ReactContextBaseJavaModule {
    private static ReactApplicationContext reactContext;
    private static final String TAG = "ADMOST";
    private String appID;
    private Boolean userContents;
    private Boolean subjectToGDPR;
    private Boolean subjectToCCPA;
    private Boolean userChild;
    private String appUserID;
    private AdMostConfiguration.Builder admostConfiguration;

    public static void sendEvent(ReactContext reactContext, String eventName, WritableMap params) {
        reactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                .emit(eventName, params);
    }
    AdmostModule(ReactApplicationContext context) {
        super(context);
    }

    @Override
    public String getName() {

        return "AdmostModule";
    }

    @ReactMethod
    public void start(Promise promise) {
        if(getCurrentActivity() == null){
            Log.e(TAG, "Current activity is null!");
            promise.reject("Current activity is null! ");
            return;
        }
        Log.i(TAG, this.appID);
        this.admostConfiguration = new AdMostConfiguration.Builder(getCurrentActivity(), this.appID);
        AdMost.getInstance().init(this.admostConfiguration.build(), new AdMostInitListener() {
            @Override
            public void onInitCompleted() {
                Log.i(TAG, "Admost INIT COMPLETED.");
                    promise.resolve("ADMOST INIT SUCCESSFUL...");
            }

            @Override
            public void onInitFailed(int err) {
                Log.e(TAG, "Admost init failed!");
                promise.reject("Admost INIT Failed Error Code :" +err);
            }
        });
    }
    @ReactMethod
    public void setAppID(String appID) {
        this.appID = appID;

        this.admostConfiguration = new AdMostConfiguration.Builder(getCurrentActivity(), appID);
    }

    @ReactMethod
    public void setUserConsents(Boolean userConsents) {
        this.userContents = userConsents;
        this.admostConfiguration.setUserConsent(userConsents);
    }

    @ReactMethod
    public void setSubjectToGDPR(Boolean subjectToGDPR) {
        this.subjectToGDPR = subjectToGDPR;
        this.admostConfiguration.setSubjectToGDPR(subjectToGDPR);
    }
    @ReactMethod
    public void setSubjectToCCPA(Boolean subjectToCCPA) {
        this.subjectToCCPA = subjectToCCPA;
        this.admostConfiguration.setSubjectToGDPR(subjectToCCPA);
    }

    @ReactMethod
    public void setUserChild(Boolean userChild) {
        this.userChild = userChild;
        this.admostConfiguration.setUserChild(userChild);
    }

    @ReactMethod
    public void setUserId(String userId) {
        this.appUserID = userId;
        AdMost.getInstance().setUserId(userId);
    }
    @ReactMethod
    public void addListener(String eventName) {

    }

    @ReactMethod
    public void removeListeners(Integer count) {

    }
}

