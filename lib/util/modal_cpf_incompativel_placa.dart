import 'package:flutter/material.dart';
import 'package:totenvalen/widgets/cpf_incompativel_placa.dart';

showModalCPFIncompativelPlaca(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CPFIncompativelPlaca();
    },
  );
}
