import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:totenvalen/model/authToken.dart';
import 'package:totenvalen/model/scan_result.dart';
import 'package:totenvalen/pages/placa.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? scanResult;
  String tdata = DateFormat("HH:mm").format(DateTime.now());




  _authToken() async {
    Map<String, dynamic> data = {
      "login": "00000000001",
      "senha": "Valen@123",
      "scope": "toten_pdv, toten_pdv_patio_1"
    };
    String body = json.encode(data);
    final response = await http.post(
      Uri.parse('https://qas.sgpi.valenlog.com.br/api/v1/auth-token'),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      print('Requisição enviada com sucesso!');
      AuthToken().token = map['token'];
    } else {
      print('Falha ao enviar requisição. Status: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    _authToken();
  }

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
                  onPressed: scanBarCode,
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

  //método scan
  Future scanBarCode() async {
    try {
      final scanResult = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666",
        "Cancelar",
        false,
        ScanMode.BARCODE,
      );
      if (scanResult != '-1') {
        ScanResult.setResult(scanResult);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PlacaPage()),
        );
      }
    } on PlatformException {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Não foi possível ler o código de barras')),
      );
    }
  }
}
