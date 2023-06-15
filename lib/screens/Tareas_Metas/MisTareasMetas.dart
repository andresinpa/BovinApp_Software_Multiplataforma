import 'package:flutter/material.dart';
import 'package:clean_calendar/clean_calendar.dart';

class MisTareasMetas extends StatelessWidget {
  const MisTareasMetas({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text(
              'Calendario de metas 📅',
              style: TextStyle(
                color: Color.fromARGB(255, 253, 249, 249),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.calendar_month_outlined),
                onPressed: () {
                  Navigator.pushNamed(context, 'ListadoTareas');
                },
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
  _MetasTareasState createState() => _MetasTareasState();
}

class _MetasTareasState extends State<MetasTareas> {
  List<DateTime> selectedDates = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text("Calendar"),
      ),
      body: Center(
        child: ListView(
          children: [
            CleanCalendar(
              enableDenseViewForDates: true,
              enableDenseSplashForDates: true,
              datesForStreaks: [
                DateTime(2023, 01, 5),
                DateTime(2023, 01, 6),
                DateTime(2023, 01, 7),
                DateTime(2023, 01, 9),
                DateTime(2023, 01, 10),
                DateTime(2023, 01, 11),
                DateTime(2023, 01, 13),
                DateTime(2023, 01, 20),
                DateTime(2023, 01, 21),
                DateTime(2023, 01, 23),
                DateTime(2023, 01, 24),
                DateTime(2023, 01, 25),
              ],
              dateSelectionMode: DatePickerSelectionMode.singleOrMultiple,
              startWeekday: WeekDay.wednesday,
              selectedDates: selectedDates,
              onCalendarViewDate: (DateTime calendarViewDate) {
                // print(calendarViewDate);
              },
              onSelectedDates: (List<DateTime> value) {
                setState(() {
                  if (selectedDates.contains(value.first)) {
                    selectedDates.remove(value.first);
                  } else {
                    selectedDates.add(value.first);
                  }
                });
                // print(selectedDates);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            CleanCalendar(
              datePickerCalendarView: DatePickerCalendarView.weekView,
              enableDenseViewForDates: true,
              enableDenseSplashForDates: true,
              datesForStreaks: [
                DateTime(2023, 01, 5),
                DateTime(2023, 01, 6),
                DateTime(2023, 01, 7),
                DateTime(2023, 01, 9),
                DateTime(2023, 01, 10),
                DateTime(2023, 01, 11),
                DateTime(2023, 01, 13),
                DateTime(2023, 01, 20),
                DateTime(2023, 01, 21),
                DateTime(2023, 01, 23),
                DateTime(2023, 01, 24),
                DateTime(2023, 01, 25),
              ],
              dateSelectionMode: DatePickerSelectionMode.singleOrMultiple,
              onCalendarViewDate: (DateTime calendarViewDate) {
                // print(calendarViewDate);
              },
              selectedDates: selectedDates,
              onSelectedDates: (List<DateTime> value) {
                setState(() {
                  if (selectedDates.contains(value.first)) {
                    selectedDates.remove(value.first);
                  } else {
                    selectedDates.add(value.first);
                  }
                });
                // print(selectedDates);
              },
            ),
            CleanCalendar(
              headerProperties: HeaderProperties(
                monthYearDecoration: MonthYearDecoration(
                  monthYearTextColor: Colors.amber,
                  monthYearTextStyle: Theme.of(context).textTheme.labelMedium,
                ),
                navigatorDecoration: NavigatorDecoration(
                  navigatorResetButtonIcon: const Icon(
                    Icons.restart_alt,
                    color: Colors.amber,
                  ),
                  navigateLeftButtonIcon: const Icon(
                    Icons.arrow_circle_left,
                    color: Colors.amber,
                  ),
                  navigateRightButtonIcon: const Icon(
                    Icons.arrow_circle_right,
                    color: Colors.amber,
                  ),
                ),
              ),
              datePickerCalendarView: DatePickerCalendarView.weekView,
              enableDenseViewForDates: true,
              enableDenseSplashForDates: true,
              datesForStreaks: [
                DateTime(2023, 01, 5),
                DateTime(2023, 01, 6),
                DateTime(2023, 01, 7),
                DateTime(2023, 01, 9),
                DateTime(2023, 01, 10),
                DateTime(2023, 01, 11),
                DateTime(2023, 01, 13),
                DateTime(2023, 01, 20),
                DateTime(2023, 01, 21),
                DateTime(2023, 01, 23),
                DateTime(2023, 01, 24),
                DateTime(2023, 01, 25),
              ],
              dateSelectionMode: DatePickerSelectionMode.disable,
              onCalendarViewDate: (DateTime calendarViewDate) {
                // print(calendarViewDate);
              },
              startWeekday: WeekDay.monday,
              weekdaysSymbol: const Weekdays(
                sunday: "s",
                monday: "m",
                tuesday: "t",
                wednesday: "w",
                thursday: "t",
                friday: "f",
                saturday: "s",
              ),
              monthsSymbol: const Months(
                  january: "Jan",
                  february: "Feb",
                  march: "Mar",
                  april: "Apr",
                  may: "May",
                  june: "Jun",
                  july: "Jul",
                  august: "Aug",
                  september: "Sep",
                  october: "Oct",
                  november: "Nov",
                  december: "Dec"),
              weekdaysProperties: WeekdaysProperties(
                generalWeekdaysDecoration:
                    WeekdaysDecoration(weekdayTextColor: Colors.red),
                sundayDecoration: WeekdaysDecoration(
                    weekdayTextColor: Colors.green,
                    weekdayTextStyle:
                        Theme.of(context).textTheme.headlineMedium),
                saturdayDecoration: WeekdaysDecoration(
                    weekdayTextColor: Colors.green,
                    weekdayTextStyle:
                        Theme.of(context).textTheme.headlineMedium),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
