import 'package:equatable/equatable.dart';
import 'package:event_bus_plus/res/app_event.dart';

class PagamentoPixEvent extends Equatable implements AppEvent {
  final String identificadorDispositivo;
  final String statusPagamento;

  PagamentoPixEvent(this.identificadorDispositivo, this.statusPagamento);

  @override
  List<Object?> get props => [identificadorDispositivo, statusPagamento];

  @override
  DateTime get timestamp => DateTime.now();
}
