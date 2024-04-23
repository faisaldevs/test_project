import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  firebaseInit(){
    FirebaseMessaging.onMessage.listen((message) {
      print(message.notification?.title.toString());
      print(message.notification?.body.toString());
    });
  }

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      announcement: true,
      alert: true,
      badge: true,
      sound: true,
      provisional: true,
      criticalAlert: true,
      carPlay: true,
    );

    if(settings.authorizationStatus == AuthorizationStatus.authorized){
      print("user permission granted");

    }else if(settings.authorizationStatus == AuthorizationStatus.provisional){
      print("user provisional permission granted");
    }else{
      print("user permission declined");
    }
  }

  Future<String> getDeviceToken() async{
    String? token = await messaging.getToken();
    return token!;
  }

 isTokenRefresh() async{
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      print("refresh");
    });
  }



}
