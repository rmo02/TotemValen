import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  final shape = StadiumBorder();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assests/fundo.png"),
          fit: BoxFit.cover,
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Header
            Column(
              children: [
                // Blue Section
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 32,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF061F89), Color(0xFF2233AB)],
                    ),
                  ),
                ),

                // White Section
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 155,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
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
                              fontSize: 36,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            "Data",
                            style: TextStyle(
                              color: Color(0xFF292929),
                              fontSize: 36,
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
                              fontSize: 36,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            "Hora",
                            style: TextStyle(
                              color: Color(0xFF292929),
                              fontSize: 36,
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
                              fontSize: 36,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            "Permanência",
                            style: TextStyle(
                              color: Color(0xFF292929),
                              fontSize: 36,
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
                              fontSize: 36,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            "Placa",
                            style: TextStyle(
                              color: Color(0xFF292929),
                              fontSize: 36,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Main info
            Container(
              height: 570,
              width: 1340,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    placa,
                    style: const TextStyle(
                      color: Color(0xFF1A2EA1),
                      fontSize: 72,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Text(
                    "Sua placa está correta?",
                    style: TextStyle(
                      color: Color(0xFF1E1E1E),
                      fontSize: 60,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 620,
                        height: 152,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFFF875E),
                                Color(0xFFFA6900),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(15),
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
                              children: const [
                                Icon(
                                  Icons.block,
                                  size: 50,
                                ),
                                SizedBox(
                                  width: 24,
                                  height: 24,
                                ),
                                Text(
                                  "Não, alterar placa",
                                  style: TextStyle(
                                    fontSize: 48,
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
                        width: 620,
                        height: 152,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF061F89),
                                Color(0xFF2233AB),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(15),
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
                                  Icons.check_circle_outline,
                                  size: 50,
                                ),
                                SizedBox(
                                  width: 24,
                                  height: 24,
                                ),
                                Text(
                                  "Sim",
                                  style: TextStyle(
                                    fontSize: 48,
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
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                width: 509,
                height: 155,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color(0xFF061F89),
                    Color(0xFF2233AB),
                  ]),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Center(
                  child: Text(
                    actualDateTime,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 100,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
