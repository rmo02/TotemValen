import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:intl/intl.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);


  @override
  State<ScanPage> createState() => _ScanPageState();

}



class _ScanPageState extends State<ScanPage> {
  String? scanResult;
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
            Container(
              height: 350,
              width: 900,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0))
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  TextButton(
                    onPressed: scanBarCode,
                    child: Text('Aproxime o ticket da leitora',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                          color: Color(0xFF1A2EA1),
                          fontSize: 32
                      ),),
                  ),
                  Text(
                    scanResult == null
                        ?'Escaneie o código de barras'
                        : 'Código do scanner é $scanResult'
                  ),
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 100,
                    width: 850,
                    child: ElevatedButton (
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            primary: Colors.white
                        ),
                        onPressed: () {
                          Navigator.pop(context);
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
                            child: const Center(child: Text('Cancelar', style: TextStyle(fontSize: 30),)),
                          ),
                        )
                    ),
                  ),
                ],
              ),
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

  Future scanBarCode() async {
    String scanResult;
    try {
      scanResult = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666",
          "Cancelar",
          false,
          ScanMode.BARCODE
      );
    } on PlatformException {
      scanResult = 'Não foi possível a leitura';
  }
  if (!mounted) return;
  setState(() => this.scanResult = scanResult);

  }

}
