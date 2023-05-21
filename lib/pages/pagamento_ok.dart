import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sunmi_printer_plus/column_maker.dart';
import 'package:sunmi_printer_plus/enums.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
import 'package:sunmi_printer_plus/sunmi_style.dart';
import 'package:totenvalen/model/authToken.dart';
import 'package:totenvalen/model/consulta_response.dart';
import 'package:totenvalen/model/faturado_response.dart';
import 'package:totenvalen/model/scan_result.dart';
import 'package:totenvalen/model/store_cpf.dart';
import 'package:totenvalen/pages/home.dart';
import 'package:totenvalen/pages/placa_insert.dart';
import '../widgets/header_section_item.dart';
import '../widgets/real_time_clock_item.dart';
import 'package:quiver/async.dart';
import 'package:http/http.dart' as http;

class PagamentoOKPage extends StatefulWidget {
  const PagamentoOKPage({
    Key? key,
  }) : super(key: key);

  @override
  State<PagamentoOKPage> createState() => _PagamentoOKPageState();
}

class _PagamentoOKPageState extends State<PagamentoOKPage> {
  bool printBinded = false;
  int paperSize = 0;
  String placa = "";
  String serialNumber = "";
  String printerVersion = "";
  String actualDateTime = DateFormat("HH:mm:ss").format(DateTime.now());
  String enterDate = "";
  String enterHour = "";
  String permanecia = "";
  double proportion = 1.437500004211426;
  int _start = 10;
  int _current = 10;

  String test_bearer =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIyNSIsImp0aSI6Ijc4NWJhZDVlNWExODkxOWQwNDIwZGI1YmRiYThkMGIwMmQ4NDNhNmFmZTE4ZWMyNjFlZDhiZTFkMTJmYWQ0ODE2OGZlZWExNDcwNDMwZGRjIiwiaWF0IjoxNjg0NTk5OTc3Ljk4MjUyOSwibmJmIjoxNjg0NTk5OTc3Ljk4MjUzMSwiZXhwIjoxNjg0NjA1Mzc3Ljk3NjQ2MSwic3ViIjoiMyIsInNjb3BlcyI6WyJ0b3Rlbl9wZHYiLCJ0b3Rlbl9wZHZfcGF0aW9fMSJdfQ.SUgYSJegTpR2ss_HzhUS-VSn3RTnu1CFaKoaOErmNy_kyX-71cbr8UcdNWdxG2wBJDcJ-VHBuAThjRZM57KJIF3CqZLZXzUKw644Wp11r1lGVua1UYyoeAsuoe6Yl6udiOZCI-A-a_0H1LXYKNKdDQ-eeLa4OCrmu9FNmd-m__kwsHuDA5M1YcPBWWzyaNMZMtZ8jRDyZvgwPf2yBIkqPW-jNCOuspKLXxUgIxJv__csRCBnJ1QcszD3bYVOTEAQb6YxMo9hOA43Zp6txoa4BaUb8H132vOSqlYHwYss_Uf25n26QyQviXC5l2n_kFVccHJAF5avshyJ3MIqUPAyUwarvDHCYKEYVrfC2_o6q0kEteBsV69TBmOrhI36TC8xV7cVcRnwww7ZQiWGn4zpHc8LPnR87czVReE26unEdb_yA0VrSQF8RwjvTkDAumTa9fs3DYrQcly9QtvmEYkpRza0sbtgLb-a21HJuSJ_6m-VnEaFUEz1bhHBC7aUVx34QQELpd1r9YlNXi-fpP3BZx7IvR2fAXNI075bYsa9nkKSI3jUThhBrRYg_Q8BL6KyfmXCxR7TywNNUlJNCwdwuFeC48RBap0eVVAP_e9Ar0cKSfQeL_a7jKQ6DOul0dkzSiMUVUrRMFM7O6bZaK7IGGaSN1FhxlIfhC1elAaJJaI";
  String test_ticket = "037695606126";

  // ${ScanResult.result}

  Future<void> _carregarDados() async {
    final authToken = AuthToken().token;
    var response = await http.get(
      Uri.parse(
          'https://qas.sgpi.valenlog.com.br/api/v1/pdv/caixas/ticket/${ScanResult.result}'),
      headers: {'Authorization': 'Bearer $authToken'},
    );
    if (response.statusCode == 200) {
      print("Requisição feita com sucesso!");
    } else {
      throw Exception('Erro ao carregar dados');
    }
  }

  _imprimirRecibo() async {
    await SunmiPrinter.initPrinter();
    await SunmiPrinter.startTransactionPrint(true);
    await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
    await SunmiPrinter.bold();
    await SunmiPrinter.printText('VALENLOG ESTACIONAMENTO LTDA');
    await SunmiPrinter.resetBold();

    await SunmiPrinter.printText('CNPJ: 33.176.727/0001-83');
    await SunmiPrinter.printText('E-MAIL: VALENLOG.SAOLUIS@REDEVALEN.COM');
    await SunmiPrinter.printText('FONE: (98) 99100-1319 / 99245-2418');
    await SunmiPrinter.printText('ENDEREÇO: AVENIDA EMILIANO MACIEIRA, 100,');
    await SunmiPrinter.printText('SÃO LUÍS/MA, 65091-320');

    await SunmiPrinter.printText('PATIO: ${FaturadoResponse.patio}');
    await SunmiPrinter.printText('ATENDENTE: ${FaturadoResponse.atendente}');
    await SunmiPrinter.line();
    await SunmiPrinter.printText('TICKET: ${ScanResult.result}');
    await SunmiPrinter.printText('PLACA: ${FaturadoResponse.placa}');
    await SunmiPrinter.printText('ENTRADA: ${FaturadoResponse.entrada}');
    await SunmiPrinter.printText('PAGAMENTO: ${FaturadoResponse.pagamento}');
    await SunmiPrinter.printText(
        'PERMANENCIA: ${FaturadoResponse.permanencia}');
    await SunmiPrinter.printText(
        'SAIDA PERMITIDA: ${FaturadoResponse.saidaPermitida}');
    await SunmiPrinter.line();
    await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
    await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);

    await SunmiPrinter.bold();
    await SunmiPrinter.printText('Detalhes');
    await SunmiPrinter.bold();
    await SunmiPrinter.printText('${FaturadoResponse.descricao}');
    await SunmiPrinter.bold();
    await SunmiPrinter.printText('${FaturadoResponse.motorista}');
    await SunmiPrinter.line();
    await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
    await SunmiPrinter.bold();
    await SunmiPrinter.printText('Pagamentos');
    await SunmiPrinter.resetBold();

    await SunmiPrinter.printText('DINHEIRO: R\$ ${FaturadoResponse.dinheiro}');
    await SunmiPrinter.line();
    await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
    await SunmiPrinter.bold();
    await SunmiPrinter.printText('Resumo');
    await SunmiPrinter.resetBold();
    await SunmiPrinter.printText(
        'Valor a Receber: R\$ ${FaturadoResponse.valorReceber}');
    await SunmiPrinter.printText(
        'Total Pago: R\$ ${FaturadoResponse.totalPago}');
    await SunmiPrinter.printText('Troco: R\$ ${FaturadoResponse.troco}');
    await SunmiPrinter.line();

    await SunmiPrinter.bold();
    await SunmiPrinter.printText('SR(A). MOTORISTA QUE VAI');
    await SunmiPrinter.bold();
    await SunmiPrinter.printText('DESCARREGAR, A PARTIR DA BAIXA');
    await SunmiPrinter.bold();
    await SunmiPrinter.printText('DESSE TICKET VOCÊ TEM 1 HORA PARA');
    await SunmiPrinter.bold();
    await SunmiPrinter.printText('CHEGAR NO PORTO DO ITAQUI,');
    await SunmiPrinter.bold();
    await SunmiPrinter.printText('PASSANDO DISSO DEVE RETORNAR AO');
    await SunmiPrinter.bold();
    await SunmiPrinter.printText('PATIO DE TRIAGEM PARA GERAR NOVA');
    await SunmiPrinter.bold();
    await SunmiPrinter.printText('ESTADIA.');

    await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
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
    _imprimirRecibo();
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
                enterHour: ConsultaResponse.enterHour,
                enterDate: ConsultaResponse.enterDate,
                permanecia: ConsultaResponse.permanencia,
                placa: ConsultaResponse.placa,
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
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        HomePage(),
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
