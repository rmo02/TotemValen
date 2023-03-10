import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:totenvalen/pages/cpf.dart';
import 'package:totenvalen/pages/placa_insert.dart';
import 'package:totenvalen/widgets/header_section_item.dart';
import 'package:totenvalen/widgets/real_time_clock_item.dart';

class PlacaPage extends StatefulWidget {
  const PlacaPage({Key? key}) : super(key: key);

  @override
  State<PlacaPage> createState() => _PlacaPageState();
}

class _PlacaPageState extends State<PlacaPage> {
  String actualDateTime = DateFormat("HH:mm:ss").format(DateTime.now());
  String actualDate = DateFormat("dd/MM/yyyy").format(DateTime.now());
  String permanecia = "179h 25m";
  String placa = "AAA-1111";
  double proportion = 1.437500004211426;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assests/fundo.png"),
            fit: BoxFit.cover,
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Header
              // Column(
              //   children: [
              //     // Blue Section
              //     Container(
              //       width: MediaQuery.of(context).size.width,
              //       height: (32 / proportion).roundToDouble(),
              //       decoration: BoxDecoration(
              //         gradient: LinearGradient(
              //           colors: [Color(0xFF061F89), Color(0xFF2233AB)],
              //         ),
              //       ),
              //     ),
              //
              //     // White Section
              //     Container(
              //       width: MediaQuery.of(context).size.width,
              //       height: (155 / proportion).roundToDouble(),
              //       decoration: BoxDecoration(
              //         color: Colors.white,
              //         borderRadius: BorderRadius.only(
              //           bottomLeft:
              //               Radius.circular((30 / proportion).roundToDouble()),
              //           bottomRight:
              //               Radius.circular((30 / proportion).roundToDouble()),
              //         ),
              //       ),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceAround,
              //         children: [
              //           Column(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               Text(
              //                 actualDate,
              //                 style: TextStyle(
              //                   color: Color(0xFF292929),
              //                   fontSize: (36 / proportion).roundToDouble(),
              //                   fontWeight: FontWeight.w700,
              //                 ),
              //               ),
              //               Text(
              //                 "Data",
              //                 style: TextStyle(
              //                   color: Color(0xFF292929),
              //                   fontSize: (36 / proportion).roundToDouble(),
              //                   fontWeight: FontWeight.w500,
              //                 ),
              //               ),
              //             ],
              //           ),
              //           Column(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               Text(
              //                 actualDateTime,
              //                 style: TextStyle(
              //                   color: Color(0xFF292929),
              //                   fontSize: (36 / proportion).roundToDouble(),
              //                   fontWeight: FontWeight.w700,
              //                 ),
              //               ),
              //               Text(
              //                 "Hora",
              //                 style: TextStyle(
              //                   color: Color(0xFF292929),
              //                   fontSize: (36 / proportion).roundToDouble(),
              //                   fontWeight: FontWeight.w500,
              //                 ),
              //               ),
              //             ],
              //           ),
              //           Column(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               Text(
              //                 permanecia,
              //                 style: TextStyle(
              //                   color: Color(0xFF292929),
              //                   fontSize: (36 / proportion).roundToDouble(),
              //                   fontWeight: FontWeight.w700,
              //                 ),
              //               ),
              //               Text(
              //                 "Permanência",
              //                 style: TextStyle(
              //                   color: Color(0xFF292929),
              //                   fontSize: (36 / proportion).roundToDouble(),
              //                   fontWeight: FontWeight.w500,
              //                 ),
              //               ),
              //             ],
              //           ),
              //           Column(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               Text(
              //                 placa,
              //                 style: TextStyle(
              //                   color: Color(0xFF292929),
              //                   fontSize: (36 / proportion).roundToDouble(),
              //                   fontWeight: FontWeight.w700,
              //                 ),
              //               ),
              //               Text(
              //                 "Placa",
              //                 style: TextStyle(
              //                   color: Color(0xFF292929),
              //                   fontSize: (36 / proportion).roundToDouble(),
              //                   fontWeight: FontWeight.w500,
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),

              HeaderSectionItem(
                proportion: proportion,
                actualDateTime: actualDateTime,
                actualDate: actualDate,
                permanecia: permanecia,
                placa: placa,
              ),

              // Main info
              Container(
                height: (570 / proportion).roundToDouble(),
                width: (1340 / proportion).roundToDouble(),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                        Radius.circular((12 / proportion).roundToDouble()))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      placa,
                      style: TextStyle(
                        color: Color(0xFF1A2EA1),
                        fontSize: (72 / proportion).roundToDouble(),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Sua placa está correta?",
                      style: TextStyle(
                        color: Color(0xFF1E1E1E),
                        fontSize: (60 / proportion).roundToDouble(),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: (620 / proportion).roundToDouble(),
                          height: (152 / proportion).roundToDouble(),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFFFF875E),
                                  Color(0xFFFA6900),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(
                                  (15 / proportion).roundToDouble()),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const PlacaInsertPage(),
                                  ),
                                );
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
                                    width: (24 / proportion).roundToDouble(),
                                    height: (24 / proportion).roundToDouble(),
                                  ),
                                  Text(
                                    "Não, alterar placa",
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
                          height: (152 / proportion).roundToDouble(),
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
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const CpfPage()),
                                );
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
                                    Icons.check_circle_outline,
                                    size: (50 / proportion).roundToDouble(),
                                  ),
                                  SizedBox(
                                    width: (24 / proportion).roundToDouble(),
                                    height: (24 / proportion).roundToDouble(),
                                  ),
                                  Text(
                                    "Sim",
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
                  ],
                ),
              ),

              // Real Time Clock
              // Align(
              //   alignment: Alignment.bottomLeft,
              //   child: Container(
              //     width: (509 / proportion).roundToDouble(),
              //     height: (155 / proportion).roundToDouble(),
              //     decoration: BoxDecoration(
              //       gradient: const LinearGradient(
              //         colors: [
              //           Color(0xFF061F89),
              //           Color(0xFF2233AB),
              //         ],
              //       ),
              //       borderRadius: BorderRadius.only(
              //         topRight:
              //             Radius.circular((30 / proportion).roundToDouble()),
              //       ),
              //     ),
              //     child: Center(
              //       child: Text(
              //         actualDateTime,
              //         textAlign: TextAlign.center,
              //         style: TextStyle(
              //           color: Colors.white,
              //           fontSize: (100 / proportion).roundToDouble(),
              //           fontWeight: FontWeight.w400,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
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
