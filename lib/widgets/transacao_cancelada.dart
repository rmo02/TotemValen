import 'package:flutter/material.dart';

class TransacaoCanceladaWidget extends StatefulWidget {
  const TransacaoCanceladaWidget({Key? key}) : super(key: key);

  @override
  State<TransacaoCanceladaWidget> createState() => _TransacaoCanceladaWidgetState();
}

class _TransacaoCanceladaWidgetState extends State<TransacaoCanceladaWidget> {
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
              "Operação cancelada",
              style: TextStyle(
                color: Color(0xFFFC7014),
                fontSize: (72 / proportion).roundToDouble(),
                fontWeight: FontWeight.w600,
              ),
            ),
            Icon(
              Icons.block,
              size: (127 / proportion).roundToDouble(),
              color: Color(0xFFFC7014),
            ),
          ],
        ),
      ),
    );
  }
}
