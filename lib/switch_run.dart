import 'package:flutter/material.dart';

class SwitchRunning extends StatefulWidget {
   const SwitchRunning({super.key});

  @override
  State<SwitchRunning> createState() => _SwitchRunningState();
}

class _SwitchRunningState extends State<SwitchRunning> {
  var value = 1;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Switch.adaptive(value: value == 1, onChanged: (val){
         setState(() {
           value = val ? 1 : 0;
         });
        }),
      ),
    );
  }
}
