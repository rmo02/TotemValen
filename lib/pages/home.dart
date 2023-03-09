import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:totenvalen/pages/scan.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String tdata = DateFormat("HH:mm").format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assests/fundo.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 155,
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  colors: [Color(0xFF061F89), Color(0xFF2233AB)],
                  radius: 0.8,
                  center: Alignment(0, 0),
                ),
              ),
              child: Center(
                child: Text(tdata,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Center(
              child: SizedBox(
                height: 350,
                width: 900,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    primary: Colors.white
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ScanPage()),
                    );
                  },
                  child: SizedBox(
                    height: 335,
                    width: 890,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Color(0xFFFF875E),
                              Color(0xFFFA6900)
                              //add more colors
                            ]),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: const Center(child: Text('Toque para pagar seu ticket', style: TextStyle(fontSize: 30),)),
                    ),
                  )
                ),
              )
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  colors: [Color(0xFF061F89), Color(0xFF2233AB)],
                  radius: 0.8,
                  center: Alignment(0, 0),
                ),
              ),
              child: Center(
                child: Text(tdata,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
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
