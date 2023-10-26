// ignore_for_file: file_names

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
