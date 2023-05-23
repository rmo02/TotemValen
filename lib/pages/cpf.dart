import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:totenvalen/model/authToken.dart';
import 'package:totenvalen/model/consulta_response.dart';
import 'package:totenvalen/model/scan_result.dart';
import 'package:totenvalen/model/store_convenio.dart';
import 'package:totenvalen/model/store_cpf.dart';
import 'package:totenvalen/pages/cpf_insert.dart';
import 'package:totenvalen/pages/resumo_com_convenio.dart';
import 'package:totenvalen/pages/resumo_sem_convenio.dart';
import 'package:totenvalen/util/modal_transacao_nao_autorizada.dart';
import 'package:totenvalen/widgets/header_section_item.dart';
import '../widgets/cancel_button_item.dart';
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
  late bool convenio = false;
  late bool ticket_pago = false;

  String test_bearer =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIyNSIsImp0aSI6Ijc4NWJhZDVlNWExODkxOWQwNDIwZGI1YmRiYThkMGIwMmQ4NDNhNmFmZTE4ZWMyNjFlZDhiZTFkMTJmYWQ0ODE2OGZlZWExNDcwNDMwZGRjIiwiaWF0IjoxNjg0NTk5OTc3Ljk4MjUyOSwibmJmIjoxNjg0NTk5OTc3Ljk4MjUzMSwiZXhwIjoxNjg0NjA1Mzc3Ljk3NjQ2MSwic3ViIjoiMyIsInNjb3BlcyI6WyJ0b3Rlbl9wZHYiLCJ0b3Rlbl9wZHZfcGF0aW9fMSJdfQ.SUgYSJegTpR2ss_HzhUS-VSn3RTnu1CFaKoaOErmNy_kyX-71cbr8UcdNWdxG2wBJDcJ-VHBuAThjRZM57KJIF3CqZLZXzUKw644Wp11r1lGVua1UYyoeAsuoe6Yl6udiOZCI-A-a_0H1LXYKNKdDQ-eeLa4OCrmu9FNmd-m__kwsHuDA5M1YcPBWWzyaNMZMtZ8jRDyZvgwPf2yBIkqPW-jNCOuspKLXxUgIxJv__csRCBnJ1QcszD3bYVOTEAQb6YxMo9hOA43Zp6txoa4BaUb8H132vOSqlYHwYss_Uf25n26QyQviXC5l2n_kFVccHJAF5avshyJ3MIqUPAyUwarvDHCYKEYVrfC2_o6q0kEteBsV69TBmOrhI36TC8xV7cVcRnwww7ZQiWGn4zpHc8LPnR87czVReE26unEdb_yA0VrSQF8RwjvTkDAumTa9fs3DYrQcly9QtvmEYkpRza0sbtgLb-a21HJuSJ_6m-VnEaFUEz1bhHBC7aUVx34QQELpd1r9YlNXi-fpP3BZx7IvR2fAXNI075bYsa9nkKSI3jUThhBrRYg_Q8BL6KyfmXCxR7TywNNUlJNCwdwuFeC48RBap0eVVAP_e9Ar0cKSfQeL_a7jKQ6DOul0dkzSiMUVUrRMFM7O6bZaK7IGGaSN1FhxlIfhC1elAaJJaI";
  String test_ticket = "037695606126";

  // ${ScanResult.result}

  //get dados
  Future<void> _carregarDados() async {
    final authToken = AuthToken().token;
    var response = await http.get(
      Uri.parse(
          'https://qas.sgpi.valenlog.com.br/api/v1/pdv/caixas/ticket/${ScanResult.result}'),
      headers: {'Authorization': 'Bearer $authToken'},
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
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
                enterHour: ConsultaResponse.enterHour,
                enterDate: ConsultaResponse.enterDate,
                permanecia: ConsultaResponse.permanencia,
                placa: ConsultaResponse.placa,
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
                              onPressed: () async {
                                if (ConsultaResponse.convenio &
                                ConsultaResponse.ticket_pago) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                      const ResumoComConvenioPage(),
                                    ),
                                  );
                                }
                                else if (!ConsultaResponse.convenio &
                                !ConsultaResponse.ticket_pago) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                      const ResumoSemConvenioPage(),
                                    ),
                                  );
                                }
                                else {
                                  showModalTransacaoNaoAutorizada(context);

                                  await Future.delayed(
                                    const Duration(seconds: 2),
                                  );
                                }

                                // Navigator.push(
                                //   context,
                                //   (ConsultaResponse.convenio &
                                //   ConsultaResponse.ticket_pago)
                                //       ? MaterialPageRoute(
                                //     builder: (context) =>
                                //     const ResumoComConvenioPage(),
                                //   )
                                //       : MaterialPageRoute(
                                //     builder: (context) =>
                                //     const ResumoSemConvenioPage(),
                                //   ),
                                // );
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
                                Navigator.push(
                                  context,
                                  (ConsultaResponse.convenio &
                                  ConsultaResponse.ticket_pago)
                                      ? MaterialPageRoute(
                                    builder: (context) =>
                                    const ResumoComConvenioPage(),
                                  )
                                      : MaterialPageRoute(
                                    builder: (context) =>
                                    const CpfInsertPage(),
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