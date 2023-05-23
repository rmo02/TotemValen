import 'package:flutter/material.dart';
import 'package:totenvalen/widgets/cliente_ok_modal.dart';

showModalClienteOk(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ClienteOkWidget();
    },
  );
}
