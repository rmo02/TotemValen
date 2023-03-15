import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
import 'package:totenvalen/model/authToken.dart';
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

  _carregarDados() async {
    final authToken = AuthToken().token;
    var response = await http.get(
      Uri.parse('https://qas.sgpi.valenlog.com.br/api/v1/pdv/caixas/ticket/1969695423'),
      headers: {'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI5IiwianRpIjoiNTU4NTNlYTY1ZGY5NDVhM2Q0OTk4MmJiZjFiNjIyZDI3ZTVkOTM2MWI3MmJmZTk4YWM1Mjg1YWMwMDFlYTE3NWIyNWY0NGYxMTNhZjc1NjUiLCJpYXQiOjE2Nzg2NDkxODEuNTAzOTU0LCJuYmYiOjE2Nzg2NDkxODEuNTAzOTU3LCJleHAiOjE2Nzg2NTQ1ODEuNDk4MjQ0LCJzdWIiOiIzIiwic2NvcGVzIjpbInRvdGVuX3BkdiIsInRvdGVuX3Bkdl9wYXRpb18xIl19.LEwT6IcpgY-DFitmb7ONLyktb6-pn8YOl7Ve1AENq5iDxbNb5UJVsRo7qmjk5viB5CabWS0gDZd3cTGaaC5dpC2vUIYQ59mT48GmCS2yo0U0L9SaM-BqbxDjL1j54fe0JkQJ4y9FJP-jj4FMV7wtJ8CkiiEbjTvzzL_YYwfMvC-e7dxqgmFnBLETn3nSV19_NFS3JDPFVy6OTPgHPxIsFWnuSlWsLgttHIzpVBdSe8mQhlISV1zEOB1InooEdNab0VbW_-FEv0vj0Incrsy1IVJQVMuFn1is-cE5AKGoe2KhWKRmPUCUpoBleE9a2Re4zxvl1KjQe5xUbBz_-AsxVu9A6ZWB6QyaD6ai8tuWLrQQscGDovgUG_HxLBaPCCLeS85fpimHuSGQcWUaNC4n3wgA72Ky9Z56ELsmIaP3gu-StjPrJc-iub8NsQ4qZVE1KgbvWgkijNHGLaDBS2hR3a25J3pSEJaKrwzgIjFLzIOvFujNkpTgsEyLn__QBhqf6lVUlpXJ3kq-MekyN4FUsbFvmgEm3PRaNvvcqKMev9EimIDMosH4T-ru4lXi-Tu9Xh3OYfGNQC8HttsyAjTfY5ZHPVxa561bNWAwuw-Ndr_gTEDNADQVw3wG89Xa4iudQD5edIiVTOZWVTGgAzXJM6BLA_hUJua6A5nlMBhUNkY'},
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
                actualDateTime: actualDateTime,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
