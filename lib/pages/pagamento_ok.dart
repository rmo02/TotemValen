import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
import 'package:totenvalen/model/authToken.dart';
import 'package:totenvalen/model/scan_result.dart';
import 'package:totenvalen/pages/home.dart';
import '../widgets/header_section_item.dart';
import '../widgets/real_time_clock_item.dart';
import 'package:quiver/async.dart';
import 'package:http/http.dart' as http;

class PagamentoOKPage extends StatefulWidget {
  const PagamentoOKPage({Key? key}) : super(key: key);

  @override
  State<PagamentoOKPage> createState() => _PagamentoOKPageState();
}

class _PagamentoOKPageState extends State<PagamentoOKPage> {
  bool printBinded = false;
  int paperSize = 0;
  String serialNumber = "";
  String printerVersion = "";
  String actualDateTime = DateFormat("HH:mm:ss").format(DateTime.now());
  String enterDate = "";
  String enterHour = "";
  String permanecia = "";
  String placa = "";
  double proportion = 1.437500004211426;
  int _start = 10;
  int _current = 10;

  String test_bearer = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIyMyIsImp0aSI6ImU5YTlmNmRhZDNkNWQ4ODBlYWYxOWE4ZTY3YzcxNjExZjAwMDUwNjYzOGNmNDg5ODQ1OWE2Yjk0ODZhZWUxYzhhYTNkYTkxY2M3NDE4MDY3IiwiaWF0IjoxNjgzODI2NzQ0LjU3MzQ2MiwibmJmIjoxNjgzODI2NzQ0LjU3MzQ2NywiZXhwIjoxNjgzODMyMTQ0LjU1ODU0Miwic3ViIjoiMyIsInNjb3BlcyI6WyJ0b3Rlbl9wZHYiLCJ0b3Rlbl9wZHZfcGF0aW9fMSJdfQ.hVR6MnuM1Hk8ih0tq3OKYpDx9ijW4S_Z3J92XJhayZInCz9qM8kaUjWJMMx0sdimIawS0N5YNQdJR56dxah9D-_wmi9xKqRWzNCz_iJK74B9THwBRRF_u4hLhtY_5CzFzATHDV5crLX-eGfRGWbleuXPm8Azdo3C5yN7sN2cv8HSDZEJGAz3nGQ1jXp_6xe88twb46nrx4Gfp3tyPKmlGSUvNjVIY2BzAtgAEwK1KSGNzUOHdyE1id26B5B1WCQuT7N35UgwJuDq2sLYuTh5GsOgaaGPWbCOyAoSVSCOyqh2epA8giwGV6H2HEc9688jvooUOxxHmtWfmh6Mz2ICExeBWmXL6GktWgciadpnJz3t1J6qrmY0SnyZKVMQKVUZjQ1iS2f0FzShtnMfsidjspVp6bDmiyijv0fjUbDzeX828G0pMENjIePFJucohDvB4LiGYuYtsH__wj5NwqxRRofnKuf6148csPK9jF4SgYgcsbQJYkR6hvwOUdQctX4Hs93IXO6ar4ymgdWWWijlVIso9AD1gHAXN_XKnPH9-LskEpGCYnEbI9z7CUqd_oovkS2RDHHTiEyg6P25dR_l2nU9z2DverS-AazB09-JTkqZRuFmc1DbmRoHQzdaITuPkE3XRRDGxIAQytNqSyrO48T1a3eTnATkH99mAUUdZoE";
  String test_ticket = "037691180539";
  // ${ScanResult.result}

  _carregarDados() async {
    final authToken = AuthToken().token;
    var response = await http.get(
      Uri.parse('https://qas.sgpi.valenlog.com.br/api/v1/pdv/caixas/ticket/${test_ticket}'),
      headers: {'Authorization': 'Bearer $test_bearer'},
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      setState(() {
        placa = map['dados']['ticket']['placa'];
        permanecia = map['dados']['permanencia'][0];
        enterDate = map['dados']['ticket']['dataEntradaDia'];
        enterHour = map['dados']['ticket']['dataEntradaHora'];
      });
    } else {
      throw Exception('Erro ao carregar dados');
    }
  }

  _imprimirRecibo() async {
    await SunmiPrinter.initPrinter();
    await SunmiPrinter.startTransactionPrint(true);
    await SunmiPrinter.setCustomFontSize(60);
    await SunmiPrinter.printText('Teste de recibo!');
    await SunmiPrinter.resetFontSize();
    await SunmiPrinter.lineWrap(2);
    await SunmiPrinter.exitTransactionPrint(true);

    await SunmiPrinter.cut();
  }


  void startTimer() {
    CountdownTimer countDownTimer = new CountdownTimer(
      new Duration(seconds: _start),
      new Duration(seconds: 1),
    );

    var sub = countDownTimer.listen(null);
    sub.onData((duration) {
      setState(() {
        _current = _start - duration.elapsed.inSeconds;
      });
    });

    sub.onDone(() {
      print("Done");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
      sub.cancel();
    });
  }


  @override
  void initState() {
    super.initState();
    _carregarDados();
    startTimer();
    _bindingPrinter().then((bool? isBind) async {
      SunmiPrinter.paperSize().then((int size) {
        setState(() {
          paperSize = size;
        });
      });

      SunmiPrinter.printerVersion().then((String version) {
        setState(() {
          printerVersion = version;
        });
      });

      SunmiPrinter.serialNumber().then((String serial) {
        setState(() {
          serialNumber = serial;
        });
      });

      setState(() {
        printBinded = isBind!;
      });
    });
  }

  Future<bool?> _bindingPrinter() async {
    final bool? result = await SunmiPrinter.bindingPrinter();
    return result;
  }

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

              // Main info
              Container(
                height: (640 / proportion).roundToDouble(),
                width: (1340 / proportion).roundToDouble(),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                        Radius.circular((12 / proportion).roundToDouble()))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Pagamento confirmado",
                      style: TextStyle(
                        color: Color(0xFF1A2EA1),
                        fontSize: (72 / proportion).roundToDouble(),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Aguarde o comprovante",
                      style: TextStyle(
                        color: Color(0xFF000000),
                        fontSize: (48 / proportion).roundToDouble(),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: (1280 / proportion).roundToDouble(),
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
                              onPressed: _imprimirRecibo,
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
                                    "Finalizar ($_current)",
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

              RealTimeClockItem(
                proportion: proportion,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
