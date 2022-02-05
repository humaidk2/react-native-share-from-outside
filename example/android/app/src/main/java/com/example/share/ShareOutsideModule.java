package com.example.share;
import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.util.Log;


import androidx.annotation.Nullable;

import com.example.MainActivity;
import com.example.MainApplication;
import com.example.ShareActivity;
import com.facebook.react.ReactInstanceManager;
import com.facebook.react.ReactNativeHost;
import com.facebook.react.bridge.ActivityEventListener;
import com.facebook.react.bridge.NativeModule;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableArray;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.modules.core.DeviceEventManagerModule;
import com.facebook.react.bridge.Arguments;


import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;

public class ShareOutsideModule extends ReactContextBaseJavaModule implements ActivityEventListener {

    // Events
    final String NEW_SHARE_EVENT = "NewShareEvent";
    private static final String TAG = "SHARE_ACTIVITY";

    ReactApplicationContext mReactContext;
    ShareOutsideModule(ReactApplicationContext context) {
        super(context);
        mReactContext = context;
        mReactContext.addActivityEventListener(this);
    }
    // add to CalendarModule.java
    @Override
    public String getName() {
        return "ShareOutsideModule";
    }


    @Override
    public void onActivityResult(Activity activity, int requestCode, int resultCode, Intent data) {

        Log.d(TAG, "onActivity result");
    }

    @Override
    public void onNewIntent(Intent intent) {
        Log.d(TAG, "gOTINTENT");
//        if(intent!=null) {
            bigEvent(intent);
//        }
    }

    public void bigEvent(Intent intent) {



        String type = intent.getType();
        String action = intent.getAction();
        WritableArray testList = Arguments.createArray();
        if(Intent.ACTION_SEND.equals(action)) {

            WritableMap test = Arguments.createMap();
            String data = intent.getStringExtra(Intent.EXTRA_TEXT);

            test.putString("type", type);

            test.putString("data", data);
            testList.pushMap(test);
        } else if(Intent.ACTION_SEND_MULTIPLE.equals(action)){
            ArrayList<Uri> files = intent.getParcelableArrayListExtra(Intent.EXTRA_STREAM);
            for(Uri uri : files) {
                WritableMap test = Arguments.createMap();
                String data = intent.getStringExtra(Intent.EXTRA_TEXT);

                test.putString("type", type);

                test.putString("data", uri.toString());

                testList.pushMap(test);
            }
        }
        WritableMap dataMap = Arguments.createMap();
        dataMap.putArray("data", testList);
//        sendEvent( reactContext,"ShareEvent",testList);

        mReactContext
                .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                .emit("ShareEvent", dataMap);
        Log.d(TAG, "TYPE = " + type);
        Log.d(TAG, "ACTION = " + action);
    }

    public static void sendEvent(ReactContext reactContext,
                           String eventName,
                           @Nullable WritableArray params) {
        reactContext
                .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                .emit(eventName, params);
    }
    @ReactMethod
    public void addListener(String eventName) {
        Log.d(TAG, eventName);
        // Set up any upstream listeners or background tasks as necessary
    }

    @ReactMethod
    public void removeListeners(Integer count) {
        Log.d(TAG, "count = " + count);
        // Remove upstream listeners, stop unnecessary background tasks
    }

    @ReactMethod
    public void startApp () {
        Activity currentActivty = getCurrentActivity();

        Intent newIntent = new Intent(currentActivty.getIntent());
        newIntent.setClass(currentActivty, MainActivity.class);
        newIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        currentActivty.startActivity(newIntent);
        currentActivty.finish();
    }
}