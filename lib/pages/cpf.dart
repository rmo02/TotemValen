import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:totenvalen/model/authToken.dart';
import 'package:totenvalen/model/scan_result.dart';
import 'package:totenvalen/model/store_convenio.dart';
import 'package:totenvalen/model/store_cpf.dart';
import 'package:totenvalen/pages/cpf_insert.dart';
import 'package:totenvalen/pages/resumo_com_convenio.dart';
import 'package:totenvalen/pages/resumo_sem_convenio.dart';
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
  bool convenio = false;
  bool ticket_pago = false;

  String test_bearer = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIyMyIsImp0aSI6Ijk4ZThjM2Y4NGVlNDk1NTk4ZjM3ODZlZDllN2I3NjA5MzRkZGNhNzkwZTFmYjI1ODcyNDNiNWRjYWRmNTA3MzQyNzI5NGFmNzA3MmEwMDc3IiwiaWF0IjoxNjg0MzQ2NzY2LjAxODAxNiwibmJmIjoxNjg0MzQ2NzY2LjAxODAyLCJleHAiOjE2ODQzNTIxNjUuOTk2OTg0LCJzdWIiOiIzIiwic2NvcGVzIjpbInRvdGVuX3BkdiIsInRvdGVuX3Bkdl9wYXRpb18xIl19.SqvQNr484Z6TaLX9WY3UG09ZRrOK2wCe_r9Wpulee_7ftpwAhHLviKQ82asMIqbO2x4_aboXSFrTW_H_v5o8z90JptHC-LizAbkCCBBa11cwhGGWbI2zSA_ruScvBGlqL7jb_Y2A00aet2vgQW0bHhsiENmbylF1j4JGjotwrFqBaVisAc0uQfqFjJjP4PoH2wWEaHI3NgsCYW6r0OcVa7LfNUGnFo0V4_KsqcnuCE0Il0bW7n4Y0KDF1wwKelHqt7hNwIDqWT_YvZtVZbJmg_gmUgRScS8RQDTOCVsCWJGxHMmd6rNKV8UU80greWTS3X-QFZP9lZzOFGmTTNFM75Tr1SUCzmh0KcMVScib_XigNtmOLVCKW-PwvjmEUJE2yMFrn2m_B9KqYWTH5-Ruhbvnq3VKNfat-VzOE2skGSPyxQHN2OjfcjlZs3_ZeQN-perL7sS_rT8Dju7AZ6wZ9bicAdx68Uonx21qDk3AY2NnNRxAZeBAo1B6tQoi-6CvEETbdSyqfcv8rRNGbMtIEE-HjnsvAbWpMDw4IFmkIEYYu1whWjkjrv8-DoTpj5b0q9ncWYvn8AzEWYP9v33NKJH4s2jvUCRYj_gsib5ZZN3te6QozPFjqY01tXsZxNEWieCZRWEJLw1M07PFoZjKaC7Wo4dnCNEGexqySCYU1T8";
  String test_ticket = "037691180539";
  // ${ScanResult.result}

  //get dados
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
        convenio = map['dados']['convenio'];
        ticket_pago = map['dados']['ticket_pago'];
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
  bool get isTicketPago => ticket_pago;

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
                                Navigator.push(
                                  context,
                                  (isConveniado & isTicketPago)
                                      ? MaterialPageRoute(
                                          builder: (context) =>
                                              const ResumoComConvenioPage(),
                                        )
                                      : MaterialPageRoute(
                                          builder: (context) =>
                                              const ResumoSemConvenioPage(),
                                        ),
                                  // MaterialPageRoute(
                                  //   builder: (context) =>
                                  //       ResumoSemConvenioPage(),
                                  // ),
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
                                Navigator.push(
                                  context,
                                  (isConveniado & isTicketPago)
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
