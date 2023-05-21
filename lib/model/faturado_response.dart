class FaturadoResponse {
  // String ticket;
  // String placa;
  // String entrada;
  // String pagamento;
  // String permanencia;
  // String saidaPermitida;
  //
  // String descricao;
  // String motorista;
  //
  // String dinheiro;
  // String valorReceber;
  // String totalPago;
  // String troco;
  // String atendente;

  static String? _placa;
  static String? get placa => _placa;
  static void setPlaca(String? value) {
    _placa = value;
  }

  static String? _entrada;
  static String? get entrada => _entrada;
  static void setEntrada(String? value) {
    _entrada = value;
  }

  static String? _pagamento;
  static String? get pagamento => _pagamento;
  static void setPagamento(String? value) {
    _pagamento = value;
  }

  static String? _permanencia;
  static String? get permanencia => _permanencia;
  static void setPermanencia(String? value) {
    _permanencia = value;
  }

  static String? _saidaPermitida;
  static String? get saidaPermitida => _saidaPermitida;
  static void setSaidaPermitida(String? value) {
    _saidaPermitida = value;
  }

  static String? _descricao;
  static String? get descricao => _descricao;
  static void setDescricao(String? value) {
    _descricao = value;
  }

  static String? _motorista;
  static String? get motorista => _motorista;
  static void setMotorista(String? value) {
    _motorista = value;
  }

  static int? _dinheiro;
  static int? get dinheiro => _dinheiro;
  static void setDinheiro(int? value) {
    _dinheiro = value;
  }

  static int? _valorReceber;
  static int? get valorReceber => _valorReceber;
  static void setValorReceber(int? value) {
    _valorReceber = value;
  }

  static int? _totalPago;
  static int? get totalPago => _totalPago;
  static void setTotalPago(int? value) {
    _totalPago = value;
  }

  static int? _troco;
  static int? get troco => _troco;
  static void setTroco(int? value) {
    _troco = value;
  }

  static String? _atendente;
  static String? get atendente => _atendente;
  static void setAtendente(String? value) {
    _atendente = value;
  }

  static String? _patio;
  static String? get patio => _patio;
  static void setPatio(String? value) {
    _patio = value;
  }
}






//
// import 'dart:convert';
//
// class GlobalData {
//   int codigo;
//   String mensagem;
//   List<Dados> dados;
//
//   GlobalData({
//     required this.codigo,
//     required this.mensagem,
//     required this.dados,
//   });
//
//   factory GlobalData.fromJson(Map<String, dynamic> json) {
//     var dadosList = json['dados'] as List;
//     List<Dados> parsedDadosList =
//         dadosList.map((e) => Dados.fromJson(e['dados'])).toList();
//
//     return GlobalData(
//       codigo: json['codigo'],
//       mensagem: json['mensagem'],
//       dados: parsedDadosList,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     List<Map<String, dynamic>> dadosList =
//         dados.map((e) => e.toJson()).toList();
//
//     return {
//       'codigo': codigo,
//       'mensagem': mensagem,
//       'dados': dadosList,
//     };
//   }
// }
//
// class Dados {
//   String descricao;
//   String ticketNumero;
//   String placa;
//   String dataEntrada;
//   String dataPagamento;
//   String permancia;
//   String dataSaida;
//   Detalhes detalhes;
//   double valorOriginal;
//   int totalPago;
//   int troco;
//   int valorDesconto;
//   String atendente;
//   String patio;
//
//   Dados({
//     required this.descricao,
//     required this.ticketNumero,
//     required this.placa,
//     required this.dataEntrada,
//     required this.dataPagamento,
//     required this.permancia,
//     required this.dataSaida,
//     required this.detalhes,
//     required this.valorOriginal,
//     required this.totalPago,
//     required this.troco,
//     required this.valorDesconto,
//     required this.atendente,
//     required this.patio,
//   });
//
//   factory Dados.fromJson(Map<String, dynamic> json) {
//     return Dados(
//       descricao: json['descricao'],
//       ticketNumero: json['ticket_numero'],
//       placa: json['placa'],
//       dataEntrada: json['data_entrada'],
//       dataPagamento: json['data_pagamento'],
//       permancia: json['permancia'],
//       dataSaida: json['data_saida'],
//       detalhes: Detalhes.fromJson(json['detalhes']),
//       valorOriginal: json['valor_original'],
//       totalPago: json['totalPago'],
//       troco: json['troco'],
//       valorDesconto: json['valorDesconto'],
//       atendente: json['atendente'],
//       patio: json['patio'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'descricao': descricao,
//       'ticket_numero': ticketNumero,
//       'placa': placa,
//       'data_entrada': dataEntrada,
//       'data_pagamento': dataPagamento,
//       'permancia': permancia,
//       'data_saida': dataSaida,
//       'detalhes': detalhes.toJson(),
//       'valor_original': valorOriginal,
//       'totalPago': totalPago,
//       'troco': troco,
//       'valorDesconto': valorDesconto,
//       'atendente': atendente,
//       'patio': patio,
//     };
//   }
// }
//
// class Detalhes {
//   String convenio;
//   String motorista;
//
//   Detalhes({
//     required this.convenio,
//     required this.motorista,
//   });
//
//   factory Detalhes.fromJson(Map<String, dynamic> json) {
//     return Detalhes(
//       convenio: json['convenio'],
//       motorista: json['motorista'],
//     );
//   }
// }
