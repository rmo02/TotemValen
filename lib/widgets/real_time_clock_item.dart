import 'package:flutter/material.dart';

class RealTimeClockItem extends StatelessWidget {
  const RealTimeClockItem({
    Key? key,
    required this.proportion,
    required this.actualDateTime,
  }) : super(key: key);

  final double proportion;
  final String actualDateTime;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        width: (509 / proportion).roundToDouble(),
        height: (155 / proportion).roundToDouble(),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF061F89),
              Color(0xFF2233AB),
            ],
          ),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular((30 / proportion).roundToDouble()),
          ),
        ),
        child: Center(
          child: Text(
            actualDateTime,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: (100 / proportion).roundToDouble(),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
