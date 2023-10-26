// ignore_for_file: library_private_types_in_public_api, avoid_print, file_names, use_build_context_synchronously

import 'package:BovinApp/DTO/Services/UserProvider.dart';
import 'package:BovinApp/DTO/User.dart';
import 'package:BovinApp/Screens/Modules/TareasMetas/Metas/Meta.dart';
import 'package:BovinApp/Widgets/BottomBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final firebase = FirebaseFirestore.instance;
  late User objUser;
  late Map<DateTime, List<Event>> selectedEvents;

  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  late List<DateTime> markedDates = [];

  late List<Event> _calendarEvents;
  final TextEditingController _eventTitleController = TextEditingController();
  final TextEditingController _eventDescriptionController =
      TextEditingController();
  String _eventImportance = "Alto"; // Valor por defecto

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    objUser = userProvider.user;
    _calendarEvents = []; // Inicializa _calendarEvents

    selectedEvents = {};
    // Inicializa la localización en español
    initializeDateFormatting('es_ES', null);
    // Llama a la función para cargar las metas desde Firestore
    _loadEventsFromFirestore();
  }

  int currentIndex = 1;
  void onTabSelected(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void dispose() {
    _eventTitleController.dispose();
    _eventDescriptionController.dispose();
    super.dispose();
  }

  //Obtener las metas que se encuentran registradas -------------------------------------

  // Carga las metas desde Firestore y actualiza selectedEvents
  Future<void> _loadEventsFromFirestore() async {
    // Consulta Firestore para obtener las metas del usuario actual
    final querySnapshot = await firebase
        .collection('Usuarios')
        .doc(objUser.usuario)
        .collection('Metas')
        .get();

    selectedEvents = {};
    markedDates = [];

    for (var doc in querySnapshot.docs) {
      // Recupera los datos de la meta desde Firestore
      Map<String, dynamic> data = doc.data();

      // Crea un objeto Event a partir de los datos de Firestore
      Event event = Event(
        metaId: data['metaId'],
        titulo: data['titulo'],
        descripcion: data['descripcion'],
        importancia: data['importancia'],
        completo: data['completo'] ?? false,
        date: data['date'].toDate(),
      );

      // Obtiene la fecha de la meta (date) desde Firestore
      Timestamp timestamp = data['date'];
      DateTime date = timestamp.toDate();

      // Agrega la meta a selectedEvents
      if (selectedEvents[date] != null) {
        selectedEvents[date]?.add(event);
      } else {
        selectedEvents[date] = [event];
        markedDates.add(date);
      }
      markedDates = _calendarEvents.map((event) => event.date).toList();
      // Actualiza el estado para reflejar los cambios
      setState(() {
        _calendarEvents.add(event);
        markedDates.add(event.date);
      });
    }
  }

  //Añadir Meta a la base de datos --------------------------------------------------
  Future<void> _addEvent() async {
    if (_eventTitleController.text.isNotEmpty) {
      final event = Event(
        metaId: UniqueKey().toString(),
        titulo: _eventTitleController.text,
        descripcion: _eventDescriptionController.text,
        importancia: _eventImportance,
        completo: false,
        date: selectedDay, // Pasa la fecha seleccionada
      );
      if (selectedEvents[selectedDay] != null) {
        selectedEvents[selectedDay]?.add(event);
      } else {
        selectedEvents[selectedDay] = [event];
      }
      // Agregar el evento a Firestore
      await firebase
          .collection('Usuarios')
          .doc(objUser.usuario)
          .collection('Metas')
          .doc(event.metaId)
          .set({
        'metaId': event.metaId,
        'titulo': event.titulo,
        'descripcion': event.descripcion,
        'importancia': event.importancia,
        'completo': event.completo,
        'date': DateTime(selectedDay.year, selectedDay.month, selectedDay.day),
      });

      Navigator.pop(context);
      _eventTitleController.clear();
      _eventDescriptionController.clear();
      setState(() {});
    }
  }

  //Actualizar estado Meta -------------------------------------------------------------------------------
  Future<void> _markEventAsComplete(Event event) async {
    bool isComplete = event.completo;
    // Muestra un diálogo de confirmación para marcar como completo o no completo
    bool? complete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isComplete ? "¿Recuperar meta?" : "¿Meta cumplida?"),
        content: Text(isComplete
            ? "❎ Marcar esta meta como No cumplida"
            : "✅ Marcar esta meta como cumplida?"),
        actions: [
          TextButton(
            child: const Text("Cancelar"),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
          TextButton(
            child: const Text("Confirmar"),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
        ],
      ),
    );

    if (complete != null && complete != false) {
      // Actualiza el estado en Firestore
      await firebase
          .collection('Usuarios')
          .doc(objUser.usuario)
          .collection('Metas')
          .doc(event.metaId)
          .update({'completo': !isComplete});

      setState(() {});
    }
  }

  // Widget y pantalla de Calendario ----------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // Filtra las metas que corresponden al día seleccionado
    final filteredEventsAdd = selectedEvents[selectedDay] ?? [];
    final filteredEvents = _calendarEvents
        .where((event) => isSameDay(event.date, selectedDay))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calendario de metas',
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
            icon: const Icon(
              Icons.calendar_today_sharp,
              size: 28,
              color: Color.fromARGB(255, 221, 233, 61),
              semanticLabel: 'show calendar',
            ),
            onPressed: () {
              Navigator.pushNamed(context, 'ListadoTareas');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .04,
              ),
              const Row(
                children: [
                  SizedBox(width: 20),
                  Icon(Icons.assignment, color: Colors.blue),
                  SizedBox(width: 8),
                  Text(
                    "Administra tus Metas",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .04,
              ),
              TableCalendar(
                // ... Propiedades del TableCalendar ...

                locale: 'es_ES',
                availableCalendarFormats: const {
                  CalendarFormat.month: 'Mes',
                  CalendarFormat.week: 'Semana',
                },
                daysOfWeekStyle: const DaysOfWeekStyle(
                  weekdayStyle: TextStyle(color: Colors.blue),
                  weekendStyle: TextStyle(color: Colors.red),
                ),
                focusedDay: selectedDay,
                firstDay: DateTime(1990),
                lastDay: DateTime(2050),
                calendarFormat: format,
                onFormatChanged: (CalendarFormat newFormat) {
                  setState(() {
                    format = newFormat;
                  });
                },
                startingDayOfWeek: StartingDayOfWeek.sunday,
                daysOfWeekVisible: true,
                onDaySelected: (DateTime selectDay, DateTime focusDay) {
                  setState(() {
                    selectedDay = selectDay;
                    focusedDay = focusDay;
                  });
                },
                selectedDayPredicate: (DateTime date) {
                  return isSameDay(selectedDay, date);
                },
                eventLoader: (day) {
                  return selectedEvents[day] ?? [];
                },
                calendarStyle: CalendarStyle(
                  tableBorder: TableBorder(
                    top: BorderSide(
                      color: Colors.grey[300]!,
                      style: BorderStyle.solid,
                      width: 1.0,
                    ),
                    bottom: BorderSide(
                      color: Colors.grey[300]!,
                      style: BorderStyle.solid,
                      width: 3.0,
                    ),
                  ),
                  isTodayHighlighted: true,
                  todayTextStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  selectedDecoration: const BoxDecoration(
                    color: Color.fromARGB(255, 243, 165, 91),
                    shape: BoxShape.circle,
                  ),
                  selectedTextStyle:
                      const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  todayDecoration: const BoxDecoration(
                    color: Color.fromARGB(255, 16, 14, 139),
                    shape: BoxShape.circle,
                  ),
                  defaultDecoration: const BoxDecoration(
                    color: Color.fromARGB(255, 245, 225, 200),
                    shape: BoxShape.circle,
                  ),
                  weekendDecoration: const BoxDecoration(
                    color: Color.fromARGB(255, 245, 209, 166),
                    shape: BoxShape.circle,
                  ),
                  markersAlignment: Alignment.bottomCenter,
                  markerDecoration: BoxDecoration(
                    color: Colors.blueGrey[400],
                    shape: BoxShape.circle,
                  ),
                ),

                calendarBuilders: CalendarBuilders(
                  // Utiliza el decorador para personalizar el estilo de las fechas con eventos
                  markerBuilder: (context, date, events) {
                    final markers = <Widget>[];

                    // Verifica si la fecha tiene eventos

                    var date2 = date.toString().substring(0, 23);

                    if (markedDates.contains(DateTime.parse(date2))) {
                      markers.add(
                        const Positioned(
                          right: 1,
                          bottom: 1,
                          child: Icon(
                            Icons.event,
                            color: Colors.red,
                            size: 20.0,
                          ),
                        ),
                      );
                    }

                    return markers.isNotEmpty ? Stack(children: markers) : null;
                  },
                ),
                headerStyle: HeaderStyle(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.elliptical(70, 70)),
                    color: Colors.blue.withOpacity(0.2),
                  ),
                  formatButtonVisible: true,
                  formatButtonShowsNext: true,
                  formatButtonDecoration: BoxDecoration(
                    color: const Color.fromARGB(255, 243, 100, 33),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  formatButtonTextStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  titleTextStyle: TextStyle(
                      color: Colors.indigoAccent.shade700,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                transformAlignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final eventList in [filteredEvents, filteredEventsAdd])
                      ...eventList.map(
                        (event) => Dismissible(
                            key: Key(event.metaId), // Usar una clave única
                            direction: DismissDirection.startToEnd,
                            background: Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 245, 203, 220),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.all(10),
                              child: const Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.delete,
                                        color: Color.fromARGB(255, 67, 79, 190),
                                      ),
                                      Text(
                                        '¿Eliminar?',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 67, 79, 190),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            confirmDismiss: (direction) async {
                              // Muestra un diálogo de confirmación para eliminar el evento
                              return await showDialog<bool>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text("Eliminar Meta"),
                                  content: const Text(
                                      "¿Estás seguro de que quieres eliminar esta meta?"),
                                  actions: [
                                    TextButton(
                                      child: const Text("Cancelar"),
                                      onPressed: () {
                                        Navigator.pop(context, false);
                                      },
                                    ),
                                    TextButton(
                                      child: const Text("Eliminar"),
                                      onPressed: () {
                                        Navigator.pop(context, true);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                            onDismissed: (direction) async {
                              // Si el usuario confirmó la eliminación, procede a eliminar el evento

                              if (direction == DismissDirection.startToEnd) {
                                // Elimina el evento de Firestore
                                await firebase
                                    .collection('Usuarios')
                                    .doc(objUser.usuario)
                                    .collection('Metas')
                                    .doc(event
                                        .metaId) // Utiliza el ID del documento para eliminarlo
                                    .delete();

                                // Elimina el evento de la lista y actualiza la interfaz
                                setState(() {
                                  _calendarEvents.remove(event);
                                });
                              }
                            },
                            child: InkWell(
                              onTap: () async {
                                // Muestra el diálogo para marcar como completo o no completo
                                await _markEventAsComplete(event);
                                // Luego, navega a la misma pantalla para forzar una recarga
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const Calendar()),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: event.completo ? Colors.green.withOpacity(0.2) : Colors.blue.withOpacity(0.2),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Text(
                                        '🐮 ${event.titulo}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Descripción: ${event.descripcion}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      'Importancia: ${event.importancia}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      'Cumplida: ${event.completo ? "Sí" : "No"}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Color.fromARGB(255, 177, 4, 4),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Añadir Meta"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _eventTitleController,
                  decoration: const InputDecoration(labelText: 'Título'),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _eventDescriptionController,
                  decoration: const InputDecoration(labelText: 'Descripción'),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Importancia',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(188, 71, 71, 71),
                    fontSize: 14,
                  ),
                ),
                DropdownButton<String>(
                  value: _eventImportance,
                  items: <String>['Alto', 'Medio', 'Bajo']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _eventImportance = value!;
                    });
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                child: const Text("Cancelar"),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                onPressed: _addEvent,
                child: const Text("Guardar"),
              ),
            ],
          ),
        ),
        label: const Text("Metas"),
        icon: const Icon(Icons.add),
      ),
      bottomNavigationBar:
          BottomBar(initialIndex: currentIndex, onTabSelected: onTabSelected),
    );
  }
}
