package com.example.flutterbbs;

import android.content.Context;
import android.util.Log;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class AppHash {

    private static final String ChannelName = "com.bbs.apphash";

    public static void register(Context context, BinaryMessenger messenger) {
        final MethodChannel channel = new MethodChannel(messenger, ChannelName);
        channel.setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
                String r = null;
                switch (methodCall.method) {
                    case "getAppHash":
                        try {
                            r = getAppHashValue();
                        } catch (NoSuchAlgorithmException e) {
                            e.printStackTrace();
                        }
                        break;
                }
                result.success(r);
            }
        });
    }
    public static String getAppHashValue() throws NoSuchAlgorithmException {
        String timeString = String.valueOf(System.currentTimeMillis());
        String authkey = "appbyme_key";
        String authString = timeString.substring(0, 5) + authkey;
        MessageDigest md = MessageDigest.getInstance("MD5");
        byte[] hashkey = md.digest(authString.getBytes());
        return new BigInteger(1, hashkey).toString(16).substring(8, 16);//16进制转换字符串
    }
}
