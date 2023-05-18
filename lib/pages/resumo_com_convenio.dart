import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:totenvalen/model/authToken.dart';
import 'package:totenvalen/model/scan_result.dart';
import 'package:totenvalen/model/store_cpf.dart';
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

  String test_bearer = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIyMyIsImp0aSI6Ijk4ZThjM2Y4NGVlNDk1NTk4ZjM3ODZlZDllN2I3NjA5MzRkZGNhNzkwZTFmYjI1ODcyNDNiNWRjYWRmNTA3MzQyNzI5NGFmNzA3MmEwMDc3IiwiaWF0IjoxNjg0MzQ2NzY2LjAxODAxNiwibmJmIjoxNjg0MzQ2NzY2LjAxODAyLCJleHAiOjE2ODQzNTIxNjUuOTk2OTg0LCJzdWIiOiIzIiwic2NvcGVzIjpbInRvdGVuX3BkdiIsInRvdGVuX3Bkdl9wYXRpb18xIl19.SqvQNr484Z6TaLX9WY3UG09ZRrOK2wCe_r9Wpulee_7ftpwAhHLviKQ82asMIqbO2x4_aboXSFrTW_H_v5o8z90JptHC-LizAbkCCBBa11cwhGGWbI2zSA_ruScvBGlqL7jb_Y2A00aet2vgQW0bHhsiENmbylF1j4JGjotwrFqBaVisAc0uQfqFjJjP4PoH2wWEaHI3NgsCYW6r0OcVa7LfNUGnFo0V4_KsqcnuCE0Il0bW7n4Y0KDF1wwKelHqt7hNwIDqWT_YvZtVZbJmg_gmUgRScS8RQDTOCVsCWJGxHMmd6rNKV8UU80greWTS3X-QFZP9lZzOFGmTTNFM75Tr1SUCzmh0KcMVScib_XigNtmOLVCKW-PwvjmEUJE2yMFrn2m_B9KqYWTH5-Ruhbvnq3VKNfat-VzOE2skGSPyxQHN2OjfcjlZs3_ZeQN-perL7sS_rT8Dju7AZ6wZ9bicAdx68Uonx21qDk3AY2NnNRxAZeBAo1B6tQoi-6CvEETbdSyqfcv8rRNGbMtIEE-HjnsvAbWpMDw4IFmkIEYYu1whWjkjrv8-DoTpj5b0q9ncWYvn8AzEWYP9v33NKJH4s2jvUCRYj_gsib5ZZN3te6QozPFjqY01tXsZxNEWieCZRWEJLw1M07PFoZjKaC7Wo4dnCNEGexqySCYU1T8";
  String test_ticket = "037691180539";

  _carregarDados() async {
    final authToken = AuthToken().token;
    var response = await http.get(
      Uri.parse(
          'https://qas.sgpi.valenlog.com.br/api/v1/pdv/caixas/ticket/$test_ticket'),
      headers: {
        'Authorization':
            'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIyNSIsImp0aSI6IjBhZmQ3MzBiMThhM2I5MDVmMjc0MWViNDVkNDZkODVjN2U2OGI1YjljYzAxOWE2YmI0NDJjNTVkOTk5ZGRlYzgxOTk2ZjFkYjczN2YwNTE1IiwiaWF0IjoxNjg0MzQ4MTM0LjEyMzIzMSwibmJmIjoxNjg0MzQ4MTM0LjEyMzIzNiwiZXhwIjoxNjg0MzUzNTM0LjExODE0Niwic3ViIjoiMyIsInNjb3BlcyI6WyJ0b3Rlbl9wZHYiLCJ0b3Rlbl9wZHZfcGF0aW9fMSJdfQ.uP1tH7ulJ-lBJ-VUfkGMOUGjk_wdWPkpvmwC9cePSZgT8sWMX1cmXVxgN_surkvtNqRO1wduVFJRPu3JWFXyodpUZvBBGUCpW3lN8HgqaBIt0SbVG_cvH68G6czGMhJ-AwstFgeLBfQjERfhDo_hJwU4gMwGryUb7wpjT_yTu35Gi__gQiXFdh2hB3FHxqFeQHolBdLugcWDhhyglIHVlq2N7Vdj6xbCB9mcRoXwmNaKfvnyVBxppw7a2EAPC-6pFHBO8i5wBrvG-CdLE89RskZZwmqP7NhIAPCZNAk6wexUA7YSB37WohXbUHrTXtPuxiiNEN4-MQt29J3hVY-F47etVCKU0cNfRbjFSPdX-GopTBKj6ON0xGkXRQzs5yGAlGpoh6-zWzmka-P3vURcUYRutq7P_KivRxsqsnJnFVbj5X3wGyER5UiYKUlcCP40KDrvhFow0umukbicbIOdxtMJ7oIsLb1SgDmMKo5PyZt3IhLmEZSpuhMAlkYfUWJSPKSUjfcM0K4aJUTJBxzNgYXaYtUeBWyfc3ZgZVoqMlXCxtU1C5Pe_H0-ECOzIzwVZWR6UBg4srCirOBcoanHXYZZaXmMNSL8t2WlH9RoTEyINvmWlQOpmaD5_pfPbgaVi0SYGJDWwpkzc89ElGWGgVLaDzX2XhMuIW92SmVgIW0'
      },
    );
      Map<String, dynamic> map = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      setState(() {
        placa = map['dados']['ticket']['placa'];
        ticket = map['dados']['ticket']['ticketNumero'];
        permanecia = map['dados']['permanencia'][0];
        enterDate = map['dados']['ticket']['dataEntradaDia'];
        enterHour = map['dados']['ticket']['dataEntradaHora'];
        convenio_id = map['dados']['convenio_dados']['convenio_id'];
        convenio_descricao = map['dados']['convenio_dados']['convenio_descricao'];
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
    final url = Uri.parse('https://qas.sgpi.valenlog.com.br/api/v1/pdv/caixas/ticket/baixa/convenio');
    final request = http.MultipartRequest('POST', url);
    request.fields['ticket'] = ticket;
    request.fields['convenio_id'] = convenio_id;
    request.fields['motorista_cpf'] = cpf;

    request.headers.addAll({'Authorization': 'Bearer $test_bearer'});
    var resposta = await request.send();
    final respStr = await resposta.stream.bytesToString();

    Map<String, dynamic> map = jsonDecode(respStr);
    var dados = map["dados"][0];

    if(resposta.statusCode == 200) {
      if(mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
            const PagamentoOKPage(),
          ),
        );
      }
    } else {
      print(dados);
    }
  }
}
