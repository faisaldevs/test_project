import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



import 'app_notification/push_notification.dart';
import 'notification.dart';
// import 'package:local_notification_app_demo/Services/notifi_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: ElevatedButton(
            child: const Text('Show notifications'),
            onPressed: () {
              // showDialog(
              //   context: context,
              //   builder: (ctx) => CupertinoAlertDialog(
              //     title: const Text("Alert Dialog Box"),
              //     content: const Text("You have raised a Alert Dialog Box"),
              //     actions: <Widget>[
              //       TextButton(
              //         onPressed: () {
              //           Navigator.of(ctx).pop();
              //         },
              //         child: const Text("cancel"),
              //       ),
              //       TextButton(
              //         onPressed: () {
              //           print("sure");
              //         },
              //         child: const Text("sure"),
              //       ),
              //     ],
              //   ),
              // );


              // LocalNotification()
              //     .showNotification(title: 'Sample title', body: 'It works!');

              NotificationServices().getDeviceToken().then((value) async{
                print("Device Token: $value");


                var body = {
                  "to":"fNvl_fbkTRu6yOIUJGxJD0:APA91bGq91uCptr1XFE2_r5Z4_fNVVVmTwG_Jqvv64JEOMNT6ElW9ejlTzg-4ckYAr5R2kN8kDUasyvE2vgGXHkPlgxMEpIv4cMmBYcQ4NSVJ1NeFA5a5Xy0UrjUbxEP7rloB7EN1xEq",
                  "notification": {
                    "body": "test body",
                    "title": "test title"
                  },
                  "data" : {
                    "routeId": 6
                  }
                };
                var serverKey = "key=AAAA7XPIygM:APA91bHjk7K5YCkFfXXkS4X2AFnxR9SQGVJbYxdt8MhnzqsaXyPMyu7Rc-JUSHAksG1xgXfQ-NPP-Zv3HUA9nU_rYXo_Abu-3chPJlnJfIzJZ578TEgll6L8BtJ6vM222RjIdhhkko8S";
                var api = "https://fcm.googleapis.com/fcm/send";

                try{
                  print("object");
                  var res = await http.post(Uri.parse(api),
                      headers: {
                        "Content-Type" : "application/json",
                        "Authorization" : serverKey,
                      },
                      body: jsonEncode(body),
                  );
                  print(res.statusCode);
                  print(res.body);
                  // if(res == 201){
                  //   print("Device token was sent..!!");
                  //   print(res.statusCode);
                  //   print(res.body);
                  // }
                }catch(e){
                  print("Error : $e");
                }



              });

            },
          )),
    );
  }
}