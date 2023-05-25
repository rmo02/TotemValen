class ConsultaResponse {
  static String _ticket = "";
  static String get ticket => _ticket;
  static void setTicket(String value) {
    _ticket = value;
  }

  static String _placa = "";
  static String get placa => _placa;
  static void setPlaca(String value) {
    _placa = value;
  }

  static String _permanencia = "";
  static String get permanencia => _permanencia;
  static void setPermanencia(String value) {
    _permanencia = value;
  }

  static String _enterDate = "";
  static String get enterDate => _enterDate;
  static void setEnterDate(String value) {
    _enterDate = value;
  }

  static String _enterHour = "";
  static String get enterHour => _enterHour;
  static void setEnterHour(String value) {
    _enterHour = value;
  }

  static bool _convenio = false;
  static bool get convenio => _convenio;
  static void setConvenio(bool value) {
    _convenio = value;
  }

  static String _convenio_descricao = "";
  static String get convenio_descricao => _convenio_descricao;
  static void setConvenioDescricao(String value) {
    _convenio_descricao = value;
  }

  static String _convenio_id = "";
  static String get convenio_id => _convenio_id;
  static void setConvenioId(String value) {
    _convenio_id = value;
  }

  static bool _ticket_pago = false;
  static bool get ticket_pago => _ticket_pago;
  static void setTicket_pago(bool value) {
    _ticket_pago = value;
  }

  static double _valorTotal = 0.0;
  static double get valorTotal => _valorTotal;
  static void setValorTotal(double value) {
    _valorTotal = value;
  }

  static String _descricaoFinal = "";
  static String get descricaoFinal => _descricaoFinal;
  static void setDescricaoFinal(String value) {
    _descricaoFinal = value;
  }


}