// ignore_for_file: file_names

/// The class "Event" represents an event with properties such as metaId, titulo, descripcion,
/// importancia, completo, and date.
class Event {
  final String metaId;
  final String titulo;
  final String descripcion;
  final String importancia;
  final bool completo;
  final DateTime date;
  Event({
    required this.metaId,
    required this.titulo,
    required this.descripcion,
    required this.importancia,
    required this.completo,
    required this.date,
  });
}
