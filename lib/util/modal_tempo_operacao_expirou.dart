import 'package:flutter/material.dart';
import 'package:totenvalen/widgets/tempo_operacao_expirou.dart';

showModalTempoOperacaoExpirou(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return TempoOperacaoExpirou();
    },
  );
}
