import 'package:flutter/material.dart';
import 'package:totenvalen/widgets/ticket_pago.dart';

showModalTicketPago(context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return TicketPagoWidget();
      });
}
