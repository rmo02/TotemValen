import 'package:flutter/material.dart';
import 'package:totenvalen/widgets/erro_operacao_pix.dart';

showModalErroOperacaoPix(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ErroOperacaoPix();
    },
  );
}
