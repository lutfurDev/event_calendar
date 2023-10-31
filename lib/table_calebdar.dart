import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class TableCalendarScreen extends StatefulWidget {
  const TableCalendarScreen({super.key});

  @override
  State<TableCalendarScreen> createState() => _TableCalendarScreenState();
}

class _TableCalendarScreenState extends State<TableCalendarScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _drcController = TextEditingController();

  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDate;


  Map<DateTime, List<Event>> event = {};

  @override
  void initState() {
    _selectedDate = _focusedDay;
    super.initState();
  }

  void _onDaySelected(selectedDay, focusedDay) {
    if (!isSameDay(_selectedDate, selectedDay)) {
      setState(() {
        _selectedDate = selectedDay;
        _focusedDay = focusedDay;
      });
    }
  }

  Map<String, List> mySelectedEvent = {};

  List _listOfDayEvents(DateTime? dateTime) {
    if (mySelectedEvent[DateFormat("yyyy-MM-dd").format(dateTime!)] != null) {
      return mySelectedEvent[DateFormat("yyyy-MM-dd").format(dateTime)]!;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime(2022),
              lastDay: DateTime(2050),

              focusedDay: _focusedDay,
              onDaySelected: _onDaySelected, //
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDate, day);
              },
              calendarFormat: _calendarFormat,
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },

              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },

              eventLoader: _listOfDayEvents,


            ),
            ..._listOfDayEvents(_selectedDate).map((e) => ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(e["title"] ?? ""),
                      Text(e["date"] ?? ""),
                    ],
                  ),
                ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _showDialog();
          },
          label: const Text("Add event")),
    );
  }

  _showDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Event", textAlign: TextAlign.center),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
              ),
              TextField(
                controller: _drcController,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (mySelectedEvent[DateFormat("yyyy-MM-dd").format(_selectedDate!)] != null) {
                      mySelectedEvent[DateFormat("yyyy-MM-dd").format(_selectedDate!)]?.add({
                        "title": _titleController.text,
                        "description": _drcController.text,
                        "date":DateFormat("yyyy-MM-dd").format(_selectedDate!)

                      });
                    } else {
                      mySelectedEvent[DateFormat("yyyy-MM-dd").format(_selectedDate!)] = [
                        {
                          "title": _titleController.text,
                          "description": _drcController.text,
                          "date":DateFormat("yyyy-MM-dd").format(_selectedDate!)
                        }
                      ];
                    }
                    setState(() {});
                    print(json.encode(mySelectedEvent));
                    _titleController.clear();
                    _drcController.clear();
                    Navigator.pop(context);
                    return;
                  },
                  child: const Text("Added")),
            ],
          ),
        );
      },
    );
  }
}

class Event {
  final String title;

  Event(this.title);
}
