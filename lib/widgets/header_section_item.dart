import 'package:flutter/material.dart';

class HeaderSectionItem extends StatelessWidget {
  const HeaderSectionItem({
    Key? key,
    required this.proportion,
    required this.actualDateTime,
    required this.actualDate,
    required this.permanecia,
    required this.placa,
  }) : super(key: key);

  final double proportion;
  final String actualDateTime;
  final String actualDate;
  final String permanecia;
  final String placa;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Blue Section
        Container(
          width: MediaQuery.of(context).size.width,
          height: (32 / proportion).roundToDouble(),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF061F89), Color(0xFF2233AB)],
            ),
          ),
        ),

        // White Section
        Container(
          width: MediaQuery.of(context).size.width,
          height: (155 / proportion).roundToDouble(),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular((30 / proportion).roundToDouble()),
              bottomRight: Radius.circular((30 / proportion).roundToDouble()),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    actualDate,
                    style: TextStyle(
                      color: Color(0xFF292929),
                      fontSize: (36 / proportion).roundToDouble(),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "Data",
                    style: TextStyle(
                      color: Color(0xFF292929),
                      fontSize: (36 / proportion).roundToDouble(),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    actualDateTime,
                    style: TextStyle(
                      color: Color(0xFF292929),
                      fontSize: (36 / proportion).roundToDouble(),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "Hora",
                    style: TextStyle(
                      color: Color(0xFF292929),
                      fontSize: (36 / proportion).roundToDouble(),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    permanecia,
                    style: TextStyle(
                      color: Color(0xFF292929),
                      fontSize: (36 / proportion).roundToDouble(),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "Permanência",
                    style: TextStyle(
                      color: Color(0xFF292929),
                      fontSize: (36 / proportion).roundToDouble(),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    placa,
                    style: TextStyle(
                      color: Color(0xFF292929),
                      fontSize: (36 / proportion).roundToDouble(),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "Placa",
                    style: TextStyle(
                      color: Color(0xFF292929),
                      fontSize: (36 / proportion).roundToDouble(),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
