import 'package:flutter/material.dart';
import 'package:totenvalen/widgets/cupom_modal.dart';

showModalCupom(context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupomModalWidget();
      });
}
