import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:totenvalen/model/store_convenio.dart';
import 'package:totenvalen/model/store_cpf.dart';
import 'package:totenvalen/pages/resumo_sem_convenio.dart';

import '../model/authToken.dart';
import '../widgets/cancel_button_item.dart';
import '../widgets/header_section_item.dart';
import '../widgets/real_time_clock_item.dart';
import 'package:totenvalen/model/scan_result.dart';
import 'package:http/http.dart' as http;

import 'cpf.dart';

class CpfInsertPage extends StatefulWidget {
  const CpfInsertPage({Key? key}) : super(key: key);

  @override
  State<CpfInsertPage> createState() => _CpfInsertPageState();
}

class _CpfInsertPageState extends State<CpfInsertPage> {
  String actualDateTime = DateFormat("HH:mm:ss").format(DateTime.now());
  String enterDate = "";
  String enterHour = "";
  String permanecia = "179h 25m";
  String placa = "AAA-1111";
  double proportion = 1.437500004211426;
  bool convenio = false;
  String? convenio_id;

  final TextEditingController inputCPFController = TextEditingController();

  String test_bearer = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIyMyIsImp0aSI6ImU5YTlmNmRhZDNkNWQ4ODBlYWYxOWE4ZTY3YzcxNjExZjAwMDUwNjYzOGNmNDg5ODQ1OWE2Yjk0ODZhZWUxYzhhYTNkYTkxY2M3NDE4MDY3IiwiaWF0IjoxNjgzODI2NzQ0LjU3MzQ2MiwibmJmIjoxNjgzODI2NzQ0LjU3MzQ2NywiZXhwIjoxNjgzODMyMTQ0LjU1ODU0Miwic3ViIjoiMyIsInNjb3BlcyI6WyJ0b3Rlbl9wZHYiLCJ0b3Rlbl9wZHZfcGF0aW9fMSJdfQ.hVR6MnuM1Hk8ih0tq3OKYpDx9ijW4S_Z3J92XJhayZInCz9qM8kaUjWJMMx0sdimIawS0N5YNQdJR56dxah9D-_wmi9xKqRWzNCz_iJK74B9THwBRRF_u4hLhtY_5CzFzATHDV5crLX-eGfRGWbleuXPm8Azdo3C5yN7sN2cv8HSDZEJGAz3nGQ1jXp_6xe88twb46nrx4Gfp3tyPKmlGSUvNjVIY2BzAtgAEwK1KSGNzUOHdyE1id26B5B1WCQuT7N35UgwJuDq2sLYuTh5GsOgaaGPWbCOyAoSVSCOyqh2epA8giwGV6H2HEc9688jvooUOxxHmtWfmh6Mz2ICExeBWmXL6GktWgciadpnJz3t1J6qrmY0SnyZKVMQKVUZjQ1iS2f0FzShtnMfsidjspVp6bDmiyijv0fjUbDzeX828G0pMENjIePFJucohDvB4LiGYuYtsH__wj5NwqxRRofnKuf6148csPK9jF4SgYgcsbQJYkR6hvwOUdQctX4Hs93IXO6ar4ymgdWWWijlVIso9AD1gHAXN_XKnPH9-LskEpGCYnEbI9z7CUqd_oovkS2RDHHTiEyg6P25dR_l2nU9z2DverS-AazB09-JTkqZRuFmc1DbmRoHQzdaITuPkE3XRRDGxIAQytNqSyrO48T1a3eTnATkH99mAUUdZoE";
  String test_ticket = "037691180539";

  _carregarDados() async {
    final authToken = AuthToken().token;
    var response = await http.get(
      Uri.parse(
          'https://qas.sgpi.valenlog.com.br/api/v1/pdv/caixas/ticket/${test_ticket}'),
      headers: {'Authorization': 'Bearer $test_bearer'},
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      print(response.body);
      setState(() {
        placa = map['dados']['ticket']['placa'];
        permanecia = map['dados']['permanencia'][0];
        enterDate = map['dados']['ticket']['dataEntradaDia'];
        enterHour = map['dados']['ticket']['dataEntradaHora'];
        convenio = map['dados']['convenio'];

        if (convenio) {
          convenio_id = map['dados']['convenio_dados']['convenio_id'];
        }
      });
    } else {
      throw Exception('Erro ao carregar dados');
    }
  }

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  bool get isConveniado => convenio;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                height: (570 / proportion).roundToDouble(),
                width: (1340 / proportion).roundToDouble(),
                decoration: BoxDecoration(
                    color: Color(0xFFF0F0F0),
                    borderRadius: BorderRadius.all(
                        Radius.circular((12 / proportion).roundToDouble()))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Digite seu CPF/CNPJ",
                      style: TextStyle(
                        color: Color(0xFF1A2EA1),
                        fontSize: (72 / proportion).roundToDouble(),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: (124 / proportion).roundToDouble(),
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(-5, -5),
                              blurRadius: 60,
                              color: Colors.white,
                            ),
                            BoxShadow(
                              offset: Offset(20, 20),
                              blurRadius: 60,
                              color: Color(0xFFBEBEBE),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: inputCPFController,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF1E1E1E),
                            fontSize: (60 / proportion).roundToDouble(),
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                (15 / proportion).roundToDouble(),
                              ),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            alignLabelWithHint: true,
                            hintText: "XXX.XXX.XXX-XX",
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black.withOpacity(0.3),
                              fontSize: (60 / proportion).roundToDouble(),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
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
                                    width: (24 / proportion).roundToDouble(),
                                    height: (24 / proportion).roundToDouble(),
                                  ),
                                  Text(
                                    "Cancelar",
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
                                String text = inputCPFController.text;
                                StoreCpf.setCpf(text);
                                isConveniado
                                    ? StoreConvenio.setConvenio(convenio_id)
                                    : StoreConvenio.setConvenio("");
                                Navigator.push(
                                  context,
                                  isConveniado
                                      ? MaterialPageRoute(
                                          builder: (context) => const CpfPage(),
                                        )
                                      : MaterialPageRoute(
                                          builder: (context) =>
                                              const ResumoSemConvenioPage(),
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
                                    Icons.check_circle_outline,
                                    size: (50 / proportion).roundToDouble(),
                                  ),
                                  SizedBox(
                                    width: (24 / proportion).roundToDouble(),
                                    height: (24 / proportion).roundToDouble(),
                                  ),
                                  Text(
                                    "Confirmar",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RealTimeClockItem(
                    proportion: proportion,
                  ),
                  CancelButtonItem(proportion: proportion),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
