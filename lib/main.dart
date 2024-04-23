// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:test_projects/app_notification/push_notification.dart';
// import 'firebase_options.dart';
//
// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(MyApp());
//
// }
//
// class MyApp extends StatefulWidget {
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//
//   NotificationServices notificationServices = NotificationServices();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     notificationServices.firebaseInit();
//     notificationServices.isTokenRefresh();
//     notificationServices.requestNotificationPermission();
//     notificationServices.getDeviceToken().then((value) {
//       print("Device Token: $value");
//     });
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Button Project',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Button Example'),
//         ),
//         body: Center(
//           child: ElevatedButton(
//             onPressed: () {
//               // Add functionality for when the button is pressed
//               print('Button Pressed!');
//             },
//             child: Text('Press Me'),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Switch Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SwitchScreen(),
    );
  }
}

class SwitchScreen extends StatefulWidget {
  @override
  _SwitchScreenState createState() => _SwitchScreenState();
}

class _SwitchScreenState extends State<SwitchScreen> {
  int _selectedValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Switch Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // DropdownButton<int>(
            //   value: _selectedValue,
            //   items: [
            //     DropdownMenuItem(
            //       child: Text('0'),
            //       value: 0,
            //     ),
            //     DropdownMenuItem(
            //       child: Text('1'),
            //       value: 1,
            //     ),
            //   ],
            //   onChanged: (value) {
            //     setState(() {
            //       _selectedValue = value!;
            //     });
            //   },
            // ),
            SizedBox(height: 20),
            Switch(
              value: _selectedValue == 1,
              onChanged: (value) {
                setState(() {
                  _selectedValue = value ? 1 : 0;
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              _selectedValue == 1 ? 'On' : 'Off',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
