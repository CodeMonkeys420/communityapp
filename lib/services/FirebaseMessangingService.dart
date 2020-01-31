import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class MyFirebaseMessagingService extends FirebaseMessagingService {
  final String TAG = "FCM Service";
 @Override
    public void onMessageReceived(RemoteMessage remoteMessage) {
        // TODO: Handle FCM messages here.
        // If the application is in the foreground handle both data and notification messages here.
        // Also if you intend on generating your own notifications as a result of a received FCM
        // message, here is where that should be initiated.
        Log.d(TAG, "From: " + remoteMessage.getFrom());
        Log.d(TAG, "Notification Message Body: " + remoteMessage.getNotification().getBody());
    }
}