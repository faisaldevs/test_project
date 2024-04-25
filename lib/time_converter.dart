
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(DateTimeConverterApp());
}

class DateTimeConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DateTime Format Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DateTimeConverterScreen(),
    );
  }
}

class DateTimeConverterScreen extends StatefulWidget {
  @override
  _DateTimeConverterScreenState createState() =>
      _DateTimeConverterScreenState();
}

class _DateTimeConverterScreenState extends State<DateTimeConverterScreen> {
  TextEditingController _inputDateController = TextEditingController();
  TextEditingController _outputDateController = TextEditingController();

  TextEditingController _inputTimeController = TextEditingController();
  TextEditingController _outputTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DateTime Format Converter'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _inputDateController,
              decoration: InputDecoration(
                labelText: 'Enter Date (YYYY-MM-DD)',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                convertDate();
              },
              child: Text('Convert Date'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _outputDateController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Converted Date',
              ),
            ),
            SizedBox(height: 32.0),
            TextField(
              controller: _inputTimeController,
              decoration: InputDecoration(
                labelText: 'Enter Time (HH:MM AM/PM)',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                convertTime();
              },
              child: Text('Convert Time'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _outputTimeController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Converted Time',
              ),
            ),
          ],
        ),
      ),
    );
  }

  void convertDate() {
    String inputDateText = _inputDateController.text.trim();
    if (inputDateText.isNotEmpty) {
      try {
        DateTime inputDate = DateFormat('yyyy-MM-dd').parse(inputDateText);
        String outputDateText = DateFormat('MMMM dd, yyyy').format(inputDate);
        setState(() {
          _outputDateController.text = outputDateText;
        });
      } catch (e) {
        setState(() {
          _outputDateController.text = 'Invalid Date Format';
        });
      }
    } else {
      setState(() {
        _outputDateController.text = 'Please enter a date';
      });
    }
  }

  void convertTime() {
    String inputTimeText = _inputTimeController.text.trim();
    if (inputTimeText.isNotEmpty) {
      try {
        DateTime inputTime = DateFormat('hh:mm a').parse(inputTimeText);
        String outputTimeText = DateFormat('HH:mm').format(inputTime);
        setState(() {
          _outputTimeController.text = outputTimeText;
        });
      } catch (e) {
        setState(() {
          _outputTimeController.text = 'Invalid Time Format';
        });
      }
    } else {
      setState(() {
        _outputTimeController.text = 'Please enter a time';
      });
    }
  }

  @override
  void dispose() {
    _inputDateController.dispose();
    _outputDateController.dispose();
    _inputTimeController.dispose();
    _outputTimeController.dispose();
    super.dispose();
  }
}
