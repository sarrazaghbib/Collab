import 'event.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late Map<DateTime, List<Event>> selectedEvents;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  TextEditingController _eventController = TextEditingController();

  @override
  void initState() {
    selectedEvents = {};
    super.initState();
  }

  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: EdgeInsets.only(top: 60.0),
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Colors.blue.shade900,
            Colors.blue.shade800,
            Colors.blue.shade400
          ])),
          child: Column(
            children: <Widget>[
              Center(
                  child: Text(
                "Calendar",
                style: TextStyle(color: Colors.white, fontSize: 30),
              )),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(45),
                          topRight: Radius.circular(45))),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          TableCalendar(
                            focusedDay: selectedDay,
                            firstDay: DateTime(2000),
                            lastDay: DateTime(2050),
                            calendarFormat: format,
                            onFormatChanged: (CalendarFormat _format) {
                              setState(() {
                                format = _format;
                              });
                            },
                            startingDayOfWeek: StartingDayOfWeek.monday,
                            daysOfWeekVisible: true,

                            //Day Changed
                            onDaySelected:
                                (DateTime selectDay, DateTime focusDay) {
                              setState(() {
                                selectedDay = selectDay;
                                focusedDay = focusDay;
                              });
                              print(focusedDay);
                            },
                            selectedDayPredicate: (DateTime date) {
                              return isSameDay(selectedDay, date);
                            },

                            eventLoader: _getEventsfromDay,

                            //To style the Calendar
                            calendarStyle: CalendarStyle(
                              isTodayHighlighted: true,
                              todayTextStyle: TextStyle(color: Colors.red),
                              todayDecoration: BoxDecoration(
                                  color: Color.fromARGB(0, 255, 255, 255),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.red,
                                    width: 0.3,
                                  )),
                              selectedDecoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              selectedTextStyle: TextStyle(color: Colors.white),
                              defaultDecoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              weekendTextStyle: TextStyle(color: Colors.black),
                              weekendDecoration: BoxDecoration(
                                color: Color.fromARGB(255, 183, 221, 240),
                                shape: BoxShape.circle,
                              ),
                            ),
                            headerStyle: HeaderStyle(
                              formatButtonVisible: true,
                              titleCentered: true,
                              formatButtonShowsNext: false,
                              formatButtonDecoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              formatButtonTextStyle: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          ..._getEventsfromDay(selectedDay).map(
                            (Event event) => ListTile(
                              title: Text(
                                event.title,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FloatingActionButton.extended(
                onPressed: () {
                  Navigator.pop(context);
                },
                label: Text("Back to Home"),
              ),
              FloatingActionButton.extended(
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Add Event"),
                    content: TextFormField(
                      controller: _eventController,
                    ),
                    actions: [
                      TextButton(
                        child: Text("Cancel"),
                        onPressed: () => Navigator.pop(context),
                      ),
                      TextButton(
                        child: Text("Ok"),
                        onPressed: () {
                          if (_eventController.text.isEmpty) {
                          } else {
                            if (selectedEvents[selectedDay] != null) {
                              selectedEvents[selectedDay]!.add(
                                Event(title: _eventController.text),
                              );
                            } else {
                              selectedEvents[selectedDay] = [
                                Event(title: _eventController.text)
                              ];
                            }
                          }
                          Navigator.pop(context);
                          _eventController.clear();
                          setState(() {});
                          return;
                        },
                      ),
                    ],
                  ),
                ),
                label: Text("Add Event"),
                icon: Icon(Icons.add),
              ),
            ],
          ),
        ));
  }
}
