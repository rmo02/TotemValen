import 'package:flutter/material.dart';
import 'package:totenvalen/model/scan_result.dart';

class TicketPagoWidget extends StatefulWidget {
  const TicketPagoWidget({
    Key? key,
    required this.objetoResponse
  }) : super(key: key);

  final dynamic objetoResponse;

  @override
  State<TicketPagoWidget> createState() => _TicketPagoWidgetState();
}

class _TicketPagoWidgetState extends State<TicketPagoWidget> {
  @override
  Widget build(BuildContext context) {
    double proportion = 1.437500004211426;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular((12 / proportion).roundToDouble()),
      ),
      child: Container(
        height: (593 / proportion).roundToDouble(),
        width: (1340 / proportion).roundToDouble(),
        decoration: BoxDecoration(
            color: Color(0xFFF0F0F0),
            borderRadius: BorderRadius.all(
                Radius.circular((12 / proportion).roundToDouble()))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Ticket ${ScanResult.result} pago",
              style: TextStyle(
                color: Color(0xFFFC7014),
                fontSize: (72 / proportion).roundToDouble(),
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "${widget.objetoResponse["menssagem"]}",
              style: TextStyle(
                color: Color(0xFF1E1E1E),
                fontSize: (48 / proportion).roundToDouble(),
                fontWeight: FontWeight.w400,
              ),
            ),
            Icon(
              Icons.error_outline,
              size: (127 / proportion).roundToDouble(),
              color: Color(0xFFFC7014),
            ),
          ],
        ),
      ),
    );
  }
}
