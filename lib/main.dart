import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test_projects/app_notification/push_notification.dart';
import 'firebase_options.dart';
import 'home.dart';
import 'package:http/http.dart' as http;
import 'notification.dart';

class PostHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async{
  HttpOverrides.global = PostHttpOverrides();

  WidgetsFlutterBinding.ensureInitialized();
  // LocalNotification().initNotification();
  AwesomeNotifications().initialize(null, [
    NotificationChannel(channelKey: "channelKey", channelName: "channelName", channelDescription: "channelDescription"),

  ],debug: true,);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp());

}

@pragma("vm:entry-point")
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message)async{
  await Firebase.initializeApp();
  print(message.notification?.title);

}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationServices.firebaseInit();
    notificationServices.isTokenRefresh();
    notificationServices.requestNotificationPermission();
    notificationServices.getDeviceToken().then((value) async{
      print("Device Token: $value");

      var api = "https://starsoftjpn.xyz/api/auth/store-token";

      try{
        print("object");
        var res = await http.post(Uri.parse(api),
            headers: {
              "Accept" : "application/json",
              "Authorization" : "bearereyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3N0YXJzb2Z0anBuLnh5ei9hcGkvYXV0aC9sb2dpbiIsImlhdCI6MTcxNDAzOTcwMywiZXhwIjoxNzE0MDQzMzAzLCJuYmYiOjE3MTQwMzk3MDMsImp0aSI6IkVQV2pKanA1bk5UaFI3TWwiLCJzdWIiOiI2OSIsInBydiI6Ijg3ZTBhZjFlZjlmZDE1ODEyZmRlYzk3MTUzYTE0ZTBiMDQ3NTQ2YWEifQ.Keu6U_NuItF6Butix14cvdLWoqPB3JHT5PvV2wVP0oY",
            },
            body: {
              "token" : value.toString(),
            }
        );
        print(res.statusCode);
        print(res.body);
        if(res == 201){
          print("Device token was sent..!!");
          print(res.statusCode);
          print(res.body);
        }
      }catch(e){
        print("Error : $e");
      }



    });

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Button Project',
      home: MyHomePage(title: '',),
      // Scaffold(
      //   appBar: AppBar(
      //     title: Text('Button Example'),
      //   ),
      //   body: Center(
      //     child: ElevatedButton(
      //       onPressed: () {
      //
      //
      //         // Add functionality for when the button is pressed
      //         print('Button Pressed!');
      //       },
      //       child: Text('Press Me'),
      //     ),
      //   ),
      // ),
    );
  }
}
// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Switch Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: SwitchScreen(),
//     );
//   }
// }
//
// class SwitchScreen extends StatefulWidget {
//   @override
//   _SwitchScreenState createState() => _SwitchScreenState();
// }
//
// class _SwitchScreenState extends State<SwitchScreen> {
//   int _selectedValue = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Switch Demo'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             // DropdownButton<int>(
//             //   value: _selectedValue,
//             //   items: [
//             //     DropdownMenuItem(
//             //       child: Text('0'),
//             //       value: 0,
//             //     ),
//             //     DropdownMenuItem(
//             //       child: Text('1'),
//             //       value: 1,
//             //     ),
//             //   ],
//             //   onChanged: (value) {
//             //     setState(() {
//             //       _selectedValue = value!;
//             //     });
//             //   },
//             // ),
//             SizedBox(height: 20),
//             Switch(
//               value: _selectedValue == 1,
//               onChanged: (value) {
//                 setState(() {
//                   _selectedValue = value ? 1 : 0;
//                 });
//               },
//             ),
//             SizedBox(height: 20),
//             Text(
//               _selectedValue == 1 ? 'On' : 'Off',
//               style: TextStyle(fontSize: 24),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// void main() {
//   runApp(DateTimeConverterApp());
// }
//
// class DateTimeConverterApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'DateTime Format Converter',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: DateTimeConverterScreen(),
//     );
//   }
// }
//
// class DateTimeConverterScreen extends StatefulWidget {
//   @override
//   _DateTimeConverterScreenState createState() =>
//       _DateTimeConverterScreenState();
// }
//
// class _DateTimeConverterScreenState extends State<DateTimeConverterScreen> {
//   TextEditingController _inputDateController = TextEditingController();
//   TextEditingController _outputDateController = TextEditingController();
//
//   TextEditingController _inputTimeController = TextEditingController();
//   TextEditingController _outputTimeController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('DateTime Format Converter'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextField(
//               controller: _inputDateController,
//               decoration: InputDecoration(
//                 labelText: 'Enter Date (YYYY-MM-DD)',
//               ),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () {
//                 convertDate();
//               },
//               child: Text('Convert Date'),
//             ),
//             SizedBox(height: 16.0),
//             TextField(
//               controller: _outputDateController,
//               readOnly: true,
//               decoration: InputDecoration(
//                 labelText: 'Converted Date',
//               ),
//             ),
//             SizedBox(height: 32.0),
//             TextField(
//               controller: _inputTimeController,
//               decoration: InputDecoration(
//                 labelText: 'Enter Time (HH:MM AM/PM)',
//               ),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () {
//                 convertTime();
//               },
//               child: Text('Convert Time'),
//             ),
//             SizedBox(height: 16.0),
//             TextField(
//               controller: _outputTimeController,
//               readOnly: true,
//               decoration: InputDecoration(
//                 labelText: 'Converted Time',
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void convertDate() {
//     String inputDateText = _inputDateController.text.trim();
//     print(inputDateText);
//
//     if (inputDateText.isNotEmpty) {
//       try {
//         DateTime inputDate = DateFormat('yyyy-MM-dd').parse(inputDateText);
//         String outputDateText = DateFormat('MMMM dd, yyyy').format(inputDate);
//         setState(() {
//           _outputDateController.text = outputDateText;
//         });
//       } catch (e) {
//         setState(() {
//           _outputDateController.text = 'Invalid Date Format';
//         });
//       }
//     } else {
//       setState(() {
//         _outputDateController.text = 'Please enter a date';
//       });
//     }
//   }
//
//   void convertTime() {
//     String inputTimeText = _inputTimeController.text.trim();
//     if (inputTimeText.isNotEmpty) {
//       try {
//         DateTime inputTime = DateFormat('hh:mm a').parse(inputTimeText);
//         String outputTimeText = DateFormat('HH:mm').format(inputTime);
//         setState(() {
//           _outputTimeController.text = outputTimeText;
//         });
//       } catch (e) {
//         setState(() {
//           _outputTimeController.text = 'Invalid Time Format';
//         });
//       }
//     } else {
//       setState(() {
//         _outputTimeController.text = 'Please enter a time';
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     _inputDateController.dispose();
//     _outputDateController.dispose();
//     _inputTimeController.dispose();
//     _outputTimeController.dispose();
//     super.dispose();
//   }
// }
