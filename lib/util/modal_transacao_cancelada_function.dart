import 'package:flutter/material.dart';
import 'package:totenvalen/widgets/transacao_cancelada.dart';

showModalTransacaoCancelada(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return TransacaoCanceladaWidget();
    },
  );
}
