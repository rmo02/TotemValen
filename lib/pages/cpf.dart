import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:totenvalen/pages/cpf_insert.dart';
import 'package:totenvalen/pages/resumo.dart';
import 'package:totenvalen/widgets/header_section_item.dart';
import '../widgets/real_time_clock_item.dart';
import 'package:http/http.dart' as http;

class CpfPage extends StatefulWidget {
  const CpfPage({Key? key}) : super(key: key);

  @override
  State<CpfPage> createState() => _CpfPageState();
}

class _CpfPageState extends State<CpfPage> {
  String actualDateTime = DateFormat("HH:mm:ss").format(DateTime.now());
  String enterDate = "";
  String enterHour = "";
  String permanecia = "";
  String placa = "";
  double proportion = 1.437500004211426;
  String convenio = "";

  _carregarDados() async {
    var response = await http.get(
      Uri.parse('https://qas.sgpi.valenlog.com.br/api/v1/pdv/caixas/ticket/1969695423'),
      headers: {'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI5IiwianRpIjoiNDk3NzY5YTM4M2FjZWE1Nzk5ZTNhN2YxYzgyMjU4NDIzYWE4OWM3NjFhMmUwNjgwODhhNjU3YjlhM2M4MzIxNjI1ZTYyOGEwMWMxMTk5ZjUiLCJpYXQiOjE2Nzg2NDUxNTQuMTMwMzI1LCJuYmYiOjE2Nzg2NDUxNTQuMTMwMzI4LCJleHAiOjE2Nzg2NTA1NTQuMTI1MjI1LCJzdWIiOiIzIiwic2NvcGVzIjpbInRvdGVuX3BkdiIsInRvdGVuX3Bkdl9wYXRpb18xIl19.M1vctvG5wFTgD-my86xOs6ZMh2gbH5d-zbjr9H1BfciyNNJXB1p4YIDoIAzKlRsHLvk1GZbBXloU-7wWjNuvyGZrU_B606zZlRNnJZVe5mg8bDBhRgxd9LDzbGOyMHp-VGQ960x9um_xoe81SIc_9d-uoHlAmHymbuIkmLbXsAN_krmFGnrcAnoPz64xHWsa801Qw6UwveJ8rw4aTEGVTyvLClBcDHJ9BYvTH5A15FpxxUH58HLnjN2wSi0-ydj0qBD2zaVWjgm2f8JiNZbQlbSidfLSdwpcfi7vqILCaOmhG5hMDbqN4REEuHjD0CR3Vxyf7C32Ml8hlH_eqJhOjbNxYx-rRiktbGkHvmoncF4hDCayKAEW3b3i4NJUSn8YPl3z2KLryZuSb6dW3bTXtcroFRUd9r-LkPRcjopaRT0NgAUy7tacCD6bN2l0mFGgWJtzEKZiLg7fRTMS57R4CBsbNx51e4gXIsSmS4olxeJlhTEewQIKURiO2V9TDKe08ak6eoZ_ENxnukFGs-1KuoC4flssnZle-0Z2Y5OHdekMGxvOULVRxfa9SEpderRHl_EIQPHXwkRnmpcUVG9ZS31kzmlxKDu-4RBwXrRbgFCSZWdfdfLAlVGKJO7_PeV7yGbpS4zNAJZTAQ_wUl_OhzLQs-NOb4qcnbPrQ-8ac3M'},
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      setState(() {
        placa = map['dados']['ticket']['placa'];
        permanecia = map['dados']['permanencia'][0];
        enterDate = map['dados']['ticket']['dataEntradaDia'];
        enterHour = map['dados']['ticket']['dataEntradaHora'];
        convenio = map['dados']['convenio'];
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
              Container(
                height: (500 / proportion).roundToDouble(),
                width: (1340 / proportion).roundToDouble(),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                        Radius.circular((12 / proportion).roundToDouble()))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Deseja o CPF/CNPJ na nota?",
                      style: TextStyle(
                        color: Color(0xFF1A2EA1),
                        fontSize: (72 / proportion).roundToDouble(),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: (130 / proportion).roundToDouble(),
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
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => ResumoPage())
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
                                    "Não",
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
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => CpfInsertPage())
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
