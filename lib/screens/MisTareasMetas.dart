import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MisTareasMetas extends StatelessWidget {
  const MisTareasMetas({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text(
              'BovinApp',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.exit_to_app_rounded),
                onPressed: () {},
              ),
            ],
          ),
          body: const MetasTareas(),
        ),
      ],
    );
  }
}

class MetasTareas extends StatefulWidget {
  const MetasTareas({super.key});

  @override
  State<MetasTareas> createState() => _MetasTareasState();
}

class _MetasTareasState extends State<MetasTareas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfCalendar(
        view: CalendarView.week,
        firstDayOfWeek: 6,
        //initialDisplayDate: DateTime(2021, 03, 01, 08, 30),
        //initialSelectedDate: DateTime(2021, 03, 01, 08, 30),
        dataSource: MeetingDataSource(getAppointments()),
      ),
    );
  }
}

List<Appointment> getAppointments() {
  List<Appointment> meetings = <Appointment>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
      DateTime(today.year, today.month, today.day, 9, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 2));

  meetings.add(Appointment(
      startTime: startTime,
      endTime: endTime,
      subject: 'Ordeño',
      color: Colors.blue,
      recurrenceRule: 'FREQ-DAILY;COUNT-10'));
  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
