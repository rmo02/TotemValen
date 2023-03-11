import 'package:flutter/material.dart';

class ClienteNoWidget extends StatefulWidget {
  const ClienteNoWidget({Key? key}) : super(key: key);

  @override
  State<ClienteNoWidget> createState() => _ClienteNoWidgetState();
}

class _ClienteNoWidgetState extends State<ClienteNoWidget> {
  double proportion = 1.437500004211426;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular((12 / proportion).roundToDouble()),
      ),
      child: Container(
        height: (500 / proportion).roundToDouble(),
        width: (1340 / proportion).roundToDouble(),
        decoration: BoxDecoration(
            color: Color(0xFFF0F0F0),
            borderRadius: BorderRadius.all(
                Radius.circular((12 / proportion).roundToDouble()))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Cliente não conveniado",
              style: TextStyle(
                color: Color(0xFF1A2EA1),
                fontSize: (72 / proportion).roundToDouble(),
                fontWeight: FontWeight.w600,
              ),
            ),
            Icon(
              Icons.check_circle_outline,
              size: (127 / proportion).roundToDouble(),
              color: Color(0xFF1A2EA1),
            ),
          ],
        ),
      ),
    );
  }
}
