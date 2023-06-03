import 'package:equatable/equatable.dart';
import 'package:event_bus_plus/res/app_event.dart';

class IdentificadorTotemEvent extends Equatable implements AppEvent {
  final String identificador;

  IdentificadorTotemEvent(this.identificador);

  @override
  List<Object?> get props => [identificador];

  @override
  DateTime get timestamp => DateTime.now();
}
