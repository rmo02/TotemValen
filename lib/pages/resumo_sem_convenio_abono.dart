import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:totenvalen/pages/pagamento_select.dart';
import 'package:totenvalen/widgets/header_section_item.dart';
import '../model/authToken.dart';
import '../model/scan_result.dart';
import '../widgets/cancel_button_item.dart';
import '../widgets/real_time_clock_item.dart';
import 'package:totenvalen/model/scan_result.dart';
import 'package:http/http.dart' as http;

class ResumoSemConvenioAbonoPage extends StatefulWidget {
  const ResumoSemConvenioAbonoPage({Key? key}) : super(key: key);

  @override
  State<ResumoSemConvenioAbonoPage> createState() =>
      _ResumoSemConvenioAbonoPageState();
}

class _ResumoSemConvenioAbonoPageState
    extends State<ResumoSemConvenioAbonoPage> {
  String actualDateTime = DateFormat("HH:mm:ss").format(DateTime.now());
  String enterDate = "";
  String enterHour = "";
  String permanecia = "";
  String placa = "AAA-1111";
  double proportion = 1.437500004211426;
  double tarifa = 100.00;
  double desconto = 20.00;
  double? total = 0;

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
        placa = map['dados']['ticket']['placa'];
        permanecia = map['dados']['permanencia'][0];
        enterDate = map['dados']['ticket']['dataEntradaDia'];
        enterHour = map['dados']['ticket']['dataEntradaHora'];
        tarifa = map['dados']['tarifas'][0]['valor'];
      });
    } else {
      throw Exception('Erro ao carregar dados');
    }
  }

  @override
  void initState() {
    super.initState();
    _carregarDados();
    total = calculaTotal(tarifa: tarifa, desconto: desconto);

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
              Container(
                height: (660 / proportion).roundToDouble(),
                width: (1340 / proportion).roundToDouble(),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                        Radius.circular((12 / proportion).roundToDouble()))),
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
                                    "Tarifa de Estacionamento",
                                    style: TextStyle(
                                      fontSize:
                                          (40 / proportion).roundToDouble(),
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF292929),
                                    ),
                                  ),
                                  Text(
                                    "RS $tarifa",
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
                            // Colocar if aqui (caso tenha desconto)
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: (16 / proportion).roundToDouble(),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Cupom de desconto",
                                    style: TextStyle(
                                      fontSize:
                                          (40 / proportion).roundToDouble(),
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF689A28),
                                    ),
                                  ),
                                  Text(
                                    "-RS $desconto",
                                    style: TextStyle(
                                      fontSize:
                                          (40 / proportion).roundToDouble(),
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF689A28),
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
                            "RS $total",
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PagamentoSelectPage(),
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
                                      "Pagamento",
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
}

double calculaTotal({required tarifa, required desconto}) {
  return tarifa - desconto;
}
