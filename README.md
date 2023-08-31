# react-native-admost-main

## Getting started

```shell script
$ npm install react-native-admost-main
```

### Android
- You should follow the "Edit Files" section on [AdMost](https://admost.github.io/amrandroid/#edit-files)
- These dependencies already exist in gradle
```
  implementation 'com.admost.sdk:amr:2.8.1'
  implementation 'com.google.android.gms:play-services-base:17.1.0'
```

#### Update Project `build.grandle`
```
allprojects {
    repositories {
        google()
        mavenCentral()
        maven { url 'https://mvn-repo.admost.com/artifactory/amr' } // <- ADD THIS
    }
}
```


### IOS
- You should follow the "Create your podfile and install" section on [AdMost](https://admost.github.io/amrios/#create-your-podfile-and-install)
- These dependencies already exist in pod
```
  s.dependency "AMRSDK", "~> 1.5"
```

## Usage

### AdmostModule Initialization
- First you must initilaze AdmostModule.
```javascript
import React from "react";
import { Button, View } from "react-native";
import AdmostModule, { AdMostAdView, AIEvents,ABEvents,AREvents, AdmostEventEmitter,AdmostInterstitial,AdmostRewarded } from "react-native-admost-main";

const App = () => {
   useEffect(() => {
  const admostInit = async () => {
    AdmostModule.setAppID(Your AppID);
    AdmostModule.setUserConsents(true); 
    AdmostModule.setSubjectToGDPR(false);
    AdmostModule.setUserChild(false);
    await AdmostModule.start()
    .then((result)=>{
      console.log(result)
    })
    .catch((error)=>{
      console.log(error)
    })
  };
     admostInit();
     return () => { 

     };
   }, []);

  return (

  );
};
```
#### Methods
| Name             | Params             | Return  | Description                                                                                                     |
|------------------|--------------------|---------|-----------------------------------------------------------------------------------------------------------------|
| setAppId         | (String)AppID      | -       | Your Application ID                                                                                             |
| setUserConsents  | Boolean            | -       | If you have the user’s consent, set it true. If you do not have the user's consent, set it false.               |
| setSubjectToGDPR | Boolean            | -       | If you know the user is subject to GDPR, set it true. If you know the user is not subject to GDPR, set it false.|
| setUserChild     | Boolean            | -       | If your app's target age group include children under the age of 18, set it true.                               |
| setUserId        | Boolean            | -       | (Optional) To set application specific user id in Admost Analytics for enhanced tracking of your users.         |
| start            | -                  | Promise | Error code (Android), Error (IOS)                                                                               |
  
### AdmostAdView

```javascript
import React from "react";
import { Button, View } from "react-native";
import AdmostModule, { AdMostAdView,ABEvents, AdmostEventEmitter } from "react-native-admost-main";

const App = () => {
   useEffect(() => {
  const admostInit = async () => {
    AdmostModule.setAppID(Your AppID);
    AdmostModule.setUserConsents(true); 
    AdmostModule.setSubjectToGDPR(false);
    AdmostModule.setUserChild(false);
    await AdmostModule.start()
    .then((result)=>{
      console.log(result)
    })
    .catch((error)=>{
      console.log(error)
    })
    ABEventlisteners();
  };
     admostInit();
     return () => { 
      ABEventlistenersCleanUp();
     };
   }, []);
     const ABEventlisteners = () => {
      bClick = AdmostEventEmitter.addListener(ABEvents.DID_CLICK,  (network) => {
          console.log('Banner ad did clicked',network);
        });
      bFail = AdmostEventEmitter.addListener(ABEvents.DID_FAIL_TO_RECEIVE,  (errorCode) => {
          console.log('Banner ad did fail to receive',errorCode);
        });
      bReceive = AdmostEventEmitter.addListener(ABEvents.DID_RECEIVE,  (network) => {
          console.log('Banner ad did receive',network);
        });
      };
    const ABEventlistenersCleanUp = () => {
      bReceive.remove();
      bFail.remove();
      bClick.remove();
    };

  return (
    <SafeAreaView style={styles.container}>
      <View>
       <AdMostAdView
        ref={(ref) => (this.admostAdViewRef = ref)}
        style={styles.banner}
        zoneId={your bannerZoneID}      
        //layoutName={layoutName}
        />
      </View>
    </SafeAreaView>
  );
};
```

#### Android Custom Layout
- Create android layout from android studio
- Set layoutName prop to view

#### IOS Custom Layout
- `cp -r CustomXibs ${project_rootdir}/node_modules/react-native-admost-main/`
- `pod install in ios folder`
- Set layoutName prop to view

#### Props
| Prop                 | Required | Type     | Default value | Description                                                              |
|----------------------|----------|----------|---------------|--------------------------------------------------------------------------|
| zoneId               | true     | string   |               | AdMost zoneId                                                            |
| layoutName           | false    | string   | DEFAULT       | Custom layout name(layout_admost_native_250, CustomNative200x200)        |                                                             |
| autoLoadDelayMs      | false    | number   | 100           | Auto load delay (min 100 ms)                                             | 
| autoLoad             | false    | bool     | true          | Load ad when AdmostAdView is mount                                       | 

#### Methods
| Name             | Params             | Return  | Description                                  |
|------------------|--------------------|---------|----------------------------------------------|
| loadAd           |                    | void    | Load ad manually                             |

### AdmostInterstitial
- First you must initilaze AdmostModule.
- You need to loadAd before shodAd.
```javascript
import React from "react";
import { Button, View } from "react-native";
import AdmostModule, { AIEvents,AdmostEventEmitter,AdmostInterstitial } from "react-native-admost-main";
const App = () => {
   useEffect(() => {
  const admostInit = async () => {
    AdmostModule.setAppID(AppID);
    AdmostModule.setUserConsents(true); 
    AdmostModule.setSubjectToGDPR(false);
    AdmostModule.setUserChild(false);
    await AdmostModule.start()
    .then((result)=>{
      console.log(result)
    })
    .catch((error)=>{
      console.log(error)
    })
    await AdmostInterstitial.initWithZoneID(your intersititialZoneID);
    AdmostInterstitial.loadAd();   
  };
    AIEventListeners();
    admostInit();
     return () => { 
      AIEventListenersCleanUp();
     };
   }, []);
     const AIEventListeners = () => {
       iFail = AdmostEventEmitter.addListener(AIEvents.DID_FAIL_TO_RECEIVE, (errorCode) => {
         console.log('Interstitial ad did fail to receive. Error Code:', errorCode);
       });
       iReceive = AdmostEventEmitter.addListener(AIEvents.DID_RECEIVE, (network) => {
         console.log('Interstitial ad did receive. Network:', network);
       });
       iShow = AdmostEventEmitter.addListener(AIEvents.DID_SHOW, (network) => {
         console.log('Interstitial ad did show. Network:', network);
       });
       iClick = AdmostEventEmitter.addListener(AIEvents.DID_CLICK, (s) => {
         console.log('Interstitial ad did click. Value:', s);
       });
       iDismiss = AdmostEventEmitter.addListener(AIEvents.DID_DISMISS, (message) => {
         console.log('Interstitial ad dismissed. Message:', message);
       });
   };
    const AIEventListenersCleanUp = () => {
      iFail.remove();
      iReceive.remove();
      iShow.remove();
      iClick.remove();
      iDismiss.remove();
    };

   const haddleButtonInterstitialButtonPress = () => {
     AdmostInterstitial.showAd();     
   };
  return (
    <SafeAreaView style={styles.container}>
      <View>
        <Button style={styles.button} title="ADMOST INTERSITITIAL SHOW" onPress={haddleButtonInterstitialButtonPress} />
        <Button style={styles.button}title="ADMOST INTERSITITIAL LOAD" color={'green'} onPress={()=>AdmostInterstitial.loadAd()} />
      </View>
    </SafeAreaView>
  );
};
```

#### Methods
| Name             |  Params                     | Return  | Description                                                           |
|------------------|-----------------------------|---------|----------------------------------------|
| initWithZoneID   | Interstitial zoneID (string)| promise | To initialize intersititial ad         |
| loadAd           |  -                          | promise | Load ad                                |
| showAd           |  -                          | promise | Shows ad if loaded                     |



#### Events
| Name                 | Params                                            |
|----------------------|---------------------------------------------------|
| DID_RECEIVE          | network, ecpm                                     |
| DID_FAIL_TO_RECEIVE  | errorCode(Android), errorDescription(IOS)         |
| DID_DISMISS          | message                                           |
| DID_SHOW             | network                                           |
| DID_CLICK            | network                                           |

### AdmostRewarded
- First you must initilaze AdmostModule to show ads.
- You need to loadAd before shodAd.
```javascript
import React from "react";
import { Button, View } from "react-native";
const App = () => {
   useEffect(() => {
  const admostInit = async () => {
    AdmostModule.setAppID(AppID);
    AdmostModule.setUserConsents(true); 
    AdmostModule.setSubjectToGDPR(false);
    AdmostModule.setUserChild(false);
    await AdmostModule.start()
    .then((result)=>{
      console.log(result)
    })
    .catch((error)=>{
      console.log(error)
    })
    await AdmostRewarded.initWithZoneID(rewardedZoneID);
    AdmostRewarded.loadAd();    
  };
    AREventlisteners();
     admostInit();
     return () => { 
      AREventlistenersCleanUp();
     };
   }, []);
   const AREventlisteners = () => {
     rFail = AdmostEventEmitter.addListener(AREvents.DID_FAIL_TO_RECEIVE, (errorCode) => {
       console.log('Rewarded ad did fail to receive', errorCode);
     });
     rReceive = AdmostEventEmitter.addListener(AREvents.DID_RECEIVE, (network) => {
       console.log('Rewarded ad did receive', network);
     });
     rShow = AdmostEventEmitter.addListener(AREvents.DID_SHOW, (network) => {
       console.log('Rewarded ad did show', network);
     });
     rComplete = AdmostEventEmitter.addListener(AREvents.DID_COMPLETE,  (network) => {
       console.log('Rewarded ad did complete you can reward the user', network);
     });
     rClick = AdmostEventEmitter.addListener(AREvents.DID_CLICK, (s) => {
       console.log('Rewarded ad did clicked', s);
     });
     rDismiss = AdmostEventEmitter.addListener(AREvents.DID_DISMISS, (message) => {
       console.log('Rewarded ad did dissmissed', message);
       AdmostRewarded.loadAd();
     });
   };
   const AREventlistenersCleanUp = () =>{
    rFail.remove();
    rReceive.remove();
    rShow.remove();
    rComplete.remove();
    rClick.remove();
    rDismiss.remove();
   };
  return (

  );
};

```

#### Methods
| Name             | Params                     | Return  | Description                            |
|------------------|----------------------------|---------|----------------------------------------|
| initWithZoneID   | Rewarded zoneID (string)   | promise | To initialize rewarded ad              |
| loadAd           | -                          | promise | Load rewarded ad                       |
| showAd           | -                          | promise | Shows rewarded ad if loaded            |

#### Events
| Name                 | Params                                            |
|----------------------|---------------------------------------------------|
| DID_RECEIVE          | network, ecpm                                     |
| DID_FAIL_TO_RECEIVE  | errorCode(Android), errorDescription(IOS)         |
| DID_DISMISS          | message (Android)                                 |
| DID_SHOW             | network                                           |
| DID_CLICK            | network                                           |
| DID_COMPLETE         | network                                           |
