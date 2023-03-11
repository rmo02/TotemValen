import 'package:flutter/material.dart';
import 'package:totenvalen/widgets/cliente_no_modal.dart';

showModalClienteNo(context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return ClienteNoWidget();
      });
}
