import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:totenvalen/model/authToken.dart';
import 'package:totenvalen/model/faturado_response.dart';
import 'package:totenvalen/model/scan_result.dart';
import 'package:totenvalen/model/store_cpf.dart';
import 'package:totenvalen/pages/home.dart';
import 'package:totenvalen/pages/pagamento_ok.dart';
import 'package:totenvalen/widgets/header_section_item.dart';
import '../model/tarifa.dart';
import '../util/modal_cupom_function.dart';
import '../widgets/cancel_button_item.dart';
import '../widgets/real_time_clock_item.dart';
import 'package:http/http.dart' as http;

class ResumoComConvenioPage extends StatefulWidget {
  const ResumoComConvenioPage({Key? key}) : super(key: key);

  @override
  State<ResumoComConvenioPage> createState() => _ResumoComConvenioPageState();
}

class _ResumoComConvenioPageState extends State<ResumoComConvenioPage> {
  String actualDateTime = DateFormat("HH:mm:ss").format(DateTime.now());
  String enterDate = "";
  String enterHour = "";
  String permanecia = "";
  String placa = "";
  String ticket = "";
  double proportion = 1.437500004211426;
  String desconto = "0";
  List<Tarifa> tarifas = [];
  String convenio_id = "";
  String cpf = "";
  String convenio_descricao = "";

  _carregarDados() async {
    final authToken = AuthToken().token;
    var response = await http.get(
      Uri.parse(
          'https://qas.sgpi.valenlog.com.br/api/v1/pdv/caixas/ticket/${ScanResult.result}'),
      headers: {'Authorization': 'Bearer $authToken'},
    );
    Map<String, dynamic> map = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        placa = map['dados']['ticket']['placa'];
        ticket = map['dados']['ticket']['ticketNumero'];
        permanecia = map['dados']['permanencia'][0];
        enterDate = map['dados']['ticket']['dataEntradaDia'];
        enterHour = map['dados']['ticket']['dataEntradaHora'];
        convenio_id = map['dados']['convenio_dados']['convenio_id'];
        convenio_descricao =
            map['dados']['convenio_dados']['convenio_descricao'];
        cpf = StoreCpf.cpf!;
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
              Container(
                height: (660 / proportion).roundToDouble(),
                width: (1340 / proportion).roundToDouble(),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      (12 / proportion).roundToDouble(),
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        "Resumo",
                        style: TextStyle(
                          color: Color(0xFF1A2EA1),
                          fontSize: (72 / proportion).roundToDouble(),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 160,
                      width: (1270 / proportion).roundToDouble(),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Tarifa",
                                  style: TextStyle(
                                    fontSize: (48 / proportion).roundToDouble(),
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF132999),
                                  ),
                                ),
                                Text(
                                  "Valor",
                                  style: TextStyle(
                                    fontSize: (48 / proportion).roundToDouble(),
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF132999),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: (16 / proportion).roundToDouble(),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    convenio_descricao,
                                    style: TextStyle(
                                      fontSize:
                                          (40 / proportion).roundToDouble(),
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF292929),
                                    ),
                                  ),
                                  Text(
                                    "RS Valor Exemplo",
                                    style: TextStyle(
                                      fontSize:
                                          (40 / proportion).roundToDouble(),
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF292929),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 26.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total",
                            style: TextStyle(
                              fontSize: (48 / proportion).roundToDouble(),
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF08218C),
                            ),
                          ),
                          Text(
                            "RS Valor exemplo",
                            style: TextStyle(
                              fontSize: (48 / proportion).roundToDouble(),
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF292929),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
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
                                  // MUDAR ISSO AQUI PRA MODAL CANCELAR E TESTAR
                                  showModalCupom(context);
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
                                onPressed: liberarSaida,
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
                                      "Liberar saída",
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

  Future<void> liberarSaida() async {
    final authToken = AuthToken().token;
    final url = Uri.parse(
        'https://qas.sgpi.valenlog.com.br/api/v1/pdv/caixas/ticket/baixa/convenio');
    final request = http.MultipartRequest('POST', url);
    request.fields['ticket'] = ticket;
    request.fields['convenio_id'] = convenio_id;
    request.fields['motorista_cpf'] = StoreCpf.cpf!;

    request.headers.addAll({'Authorization': 'Bearer $authToken'});
    var resposta = await request.send();
    final respStr = await resposta.stream.bytesToString();

    Map<String, dynamic> map = jsonDecode(respStr);
    var dados = map["dados"][0];


    if (resposta.statusCode == 200) {
      FaturadoResponse.setPatio(map["dados"][0]["dados"]["patio"]);
      FaturadoResponse.setAtendente(map["dados"][0]["dados"]["atendente"]);
      FaturadoResponse.setPlaca(map["dados"][0]["dados"]["placa"]);
      FaturadoResponse.setEntrada(map["dados"][0]["dados"]["data_entrada"]);
      FaturadoResponse.setPagamento(map["dados"][0]["dados"]["data_pagamento"]);
      FaturadoResponse.setPermanencia(map["dados"][0]["dados"]["permancia"]);
      FaturadoResponse.setSaidaPermitida(map["dados"][0]["dados"]["data_saida"]);
      FaturadoResponse.setDescricao(map["dados"][0]["dados"]["detalhes"]["convenio"]);
      FaturadoResponse.setMotorista(map["dados"][0]["dados"]["detalhes"]["motorista"]);
      FaturadoResponse.setDinheiro(map["dados"][0]["dados"]["valor_original"]);
      FaturadoResponse.setValorReceber(map["dados"][0]["dados"]["valor_original"]);
      FaturadoResponse.setTotalPago(map["dados"][0]["dados"]["totalPago"]);
      FaturadoResponse.setTroco(map["dados"][0]["dados"]["troco"]);

      // var globalData = GlobalData.fromJson(dados);

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PagamentoOKPage(),
          ),
        );
      }
    } else {
      if(mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      }
    }
  }
}
