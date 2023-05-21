import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:totenvalen/model/consulta_response.dart';
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
  double proportion = 1.437500004211426;
  String? convenio_id;
  bool ticket_pago = false;

  final TextEditingController inputCPFController = TextEditingController();

  String test_bearer =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIyNSIsImp0aSI6Ijc4NWJhZDVlNWExODkxOWQwNDIwZGI1YmRiYThkMGIwMmQ4NDNhNmFmZTE4ZWMyNjFlZDhiZTFkMTJmYWQ0ODE2OGZlZWExNDcwNDMwZGRjIiwiaWF0IjoxNjg0NTk5OTc3Ljk4MjUyOSwibmJmIjoxNjg0NTk5OTc3Ljk4MjUzMSwiZXhwIjoxNjg0NjA1Mzc3Ljk3NjQ2MSwic3ViIjoiMyIsInNjb3BlcyI6WyJ0b3Rlbl9wZHYiLCJ0b3Rlbl9wZHZfcGF0aW9fMSJdfQ.SUgYSJegTpR2ss_HzhUS-VSn3RTnu1CFaKoaOErmNy_kyX-71cbr8UcdNWdxG2wBJDcJ-VHBuAThjRZM57KJIF3CqZLZXzUKw644Wp11r1lGVua1UYyoeAsuoe6Yl6udiOZCI-A-a_0H1LXYKNKdDQ-eeLa4OCrmu9FNmd-m__kwsHuDA5M1YcPBWWzyaNMZMtZ8jRDyZvgwPf2yBIkqPW-jNCOuspKLXxUgIxJv__csRCBnJ1QcszD3bYVOTEAQb6YxMo9hOA43Zp6txoa4BaUb8H132vOSqlYHwYss_Uf25n26QyQviXC5l2n_kFVccHJAF5avshyJ3MIqUPAyUwarvDHCYKEYVrfC2_o6q0kEteBsV69TBmOrhI36TC8xV7cVcRnwww7ZQiWGn4zpHc8LPnR87czVReE26unEdb_yA0VrSQF8RwjvTkDAumTa9fs3DYrQcly9QtvmEYkpRza0sbtgLb-a21HJuSJ_6m-VnEaFUEz1bhHBC7aUVx34QQELpd1r9YlNXi-fpP3BZx7IvR2fAXNI075bYsa9nkKSI3jUThhBrRYg_Q8BL6KyfmXCxR7TywNNUlJNCwdwuFeC48RBap0eVVAP_e9Ar0cKSfQeL_a7jKQ6DOul0dkzSiMUVUrRMFM7O6bZaK7IGGaSN1FhxlIfhC1elAaJJaI";
  String test_ticket = "037695606126";

  _carregarDados() async {
    final authToken = AuthToken().token;
    var response = await http.get(
      Uri.parse(
          'https://qas.sgpi.valenlog.com.br/api/v1/pdv/caixas/ticket/${ScanResult.result}'),
      headers: {'Authorization': 'Bearer $authToken'},
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      setState(() {
        if (ConsultaResponse.convenio) {
          ConsultaResponse.setConvenioId(
              map['dados']['convenio_dados']['convenio_id']);
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
                enterHour: ConsultaResponse.enterHour,
                enterDate: ConsultaResponse.enterDate,
                permanecia: ConsultaResponse.permanencia,
                placa: ConsultaResponse.placa,
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
                                (ConsultaResponse.convenio &
                                ConsultaResponse.ticket_pago)
                                    ? StoreConvenio.setConvenio(convenio_id)
                                    : StoreConvenio.setConvenio("");
                                Navigator.push(
                                  context,
                                  (ConsultaResponse.convenio &
                                  ConsultaResponse.ticket_pago)
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