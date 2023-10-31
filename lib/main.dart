import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'table_calebdar.dart';

void main() {
  return runApp(MyApp());
}

/// My app class to display the date range picker
class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

/// State for MyApp
class MyAppState extends State<MyApp> {
  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
        // ignore: lines_longer_than_80_chars
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TableCalendarScreen(),
        // home: Scaffold(
        //     appBar: AppBar(
        //       title: const Text('DatePicker demo'),
        //     ),
        //     body: Stack(
        //       children: <Widget>[
        //         Positioned(
        //           left: 0,
        //           right: 0,
        //           top: 0,
        //           height: 80,
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //             mainAxisSize: MainAxisSize.min,
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: <Widget>[
        //
        //               Text('Selected date: $_selectedDate'),
        //               Text('Selected date count: $_dateCount'),
        //               Text('Selected range: $_range'),
        //               Text('Selected ranges count: $_rangeCount'),
        //
        //             ],
        //           ),
        //         ),
        //         Positioned(
        //           left: 0,
        //           top: 80,
        //           right: 0,
        //           bottom: 0,
        //           child: SfDateRangePicker(
        //             onSelectionChanged: _onSelectionChanged,
        //             selectionMode: DateRangePickerSelectionMode.multiple,
        //             onSubmit: ( val) {
        //               print(val);
        //             },
        //             onViewChanged: (val){
        //               print(val);
        //             },
        //           ),
        //         ),
        //       ],
        //     ))


    );
  }
}