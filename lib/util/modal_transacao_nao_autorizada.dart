import 'package:flutter/material.dart';
import 'package:totenvalen/widgets/transacao_nao_autorizada.dart';

showModalTransacaoNaoAutorizada(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return TransacaoNaoAutorizada();
    },
  );
}
