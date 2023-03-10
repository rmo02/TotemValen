import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/header_section_item.dart';
import '../widgets/real_time_clock_item.dart';

class PagamentoSelectPage extends StatefulWidget {
  const PagamentoSelectPage({Key? key}) : super(key: key);

  @override
  State<PagamentoSelectPage> createState() => _PagamentoSelectPageState();
}

class _PagamentoSelectPageState extends State<PagamentoSelectPage> {
  String actualDateTime = DateFormat("HH:mm:ss").format(DateTime.now());
  String enterDate = "";
  String enterHour = "";
  String permanecia = "";
  String placa = "AAA-1111";
  double proportion = 1.437500004211426;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assests/fundo.png"),
            fit: BoxFit.cover,
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HeaderSectionItem(
                proportion: proportion,
                actualDateTime: actualDateTime,
                enterHour: enterHour,
                enterDate: enterDate,
                permanecia: permanecia,
                placa: placa,
              ),
              Container(
                height: (660 / proportion).roundToDouble(),
                width: (1340 / proportion).roundToDouble(),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                        Radius.circular((12 / proportion).roundToDouble()))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Qual a forma de pagamento?",
                      style: TextStyle(
                        color: Color(0xFF1A2EA1),
                        fontSize: (72 / proportion).roundToDouble(),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: (620 / proportion).roundToDouble(),
                              height: (200 / proportion).roundToDouble(),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF3E58C8),
                                      Color(0xFF455CFF),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      (15 / proportion).roundToDouble()),
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    disabledForegroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.credit_card_rounded,
                                        size: (50 / proportion).roundToDouble(),
                                      ),
                                      SizedBox(
                                        width:
                                            (24 / proportion).roundToDouble(),
                                        height:
                                            (24 / proportion).roundToDouble(),
                                      ),
                                      Text(
                                        "Cart??o de D??bito",
                                        style: TextStyle(
                                          fontSize:
                                              (48 / proportion).roundToDouble(),
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: (620 / proportion).roundToDouble(),
                              height: (200 / proportion).roundToDouble(),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF061F89),
                                      Color(0xFF2233AB),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      (15 / proportion).roundToDouble()),
                                ),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    disabledForegroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.credit_card_rounded,
                                        size: (50 / proportion).roundToDouble(),
                                      ),
                                      SizedBox(
                                        width:
                                            (24 / proportion).roundToDouble(),
                                        height:
                                            (24 / proportion).roundToDouble(),
                                      ),
                                      Text(
                                        "Cart??o de Cr??dito",
                                        style: TextStyle(
                                          fontSize:
                                              (48 / proportion).roundToDouble(),
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: SizedBox(
                              width: (620 / proportion).roundToDouble(),
                              height: (200 / proportion).roundToDouble(),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF1B2F84),
                                      Color(0xFF4652A3),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      (15 / proportion).roundToDouble()),
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    disabledForegroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.block,
                                        size: (50 / proportion).roundToDouble(),
                                      ),
                                      SizedBox(
                                        width:
                                            (24 / proportion).roundToDouble(),
                                        height:
                                            (24 / proportion).roundToDouble(),
                                      ),
                                      Text(
                                        "Pix",
                                        style: TextStyle(
                                          fontSize:
                                              (48 / proportion).roundToDouble(),
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              RealTimeClockItem(
                proportion: proportion,
                actualDateTime: actualDateTime,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
