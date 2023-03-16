import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RealTimeClockItem extends StatefulWidget {
  RealTimeClockItem({
    Key? key,
    required this.proportion,
  }) : super(key: key);

  final double proportion;

  @override
  State<RealTimeClockItem> createState() => _RealTimeClockItemState();
}

class _RealTimeClockItemState extends State<RealTimeClockItem> {

  String _timeString = "";

  @override
  void initState() {
    _timeString = _formatDateTime(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        width: (509 / widget.proportion).roundToDouble(),
        height: (155 / widget.proportion).roundToDouble(),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF061F89),
              Color(0xFF2233AB),
            ],
          ),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular((30 / widget.proportion).roundToDouble()),
          ),
        ),
        child: Center(
          child: Text(
            _timeString,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: (100 / widget.proportion).roundToDouble(),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('HH:mm:ss').format(dateTime);
  }
}
