import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:totenvalen/model/consulta_response.dart';
import 'package:totenvalen/model/scan_result.dart';
import 'package:totenvalen/pages/cpf.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:totenvalen/pages/home.dart';
import 'package:totenvalen/widgets/header_section_item.dart';
import 'package:totenvalen/widgets/real_time_clock_item.dart';
import 'package:http/http.dart' as http;

import '../model/authToken.dart';
import '../util/modal_cliente_no_function.dart';
import '../util/modal_cliente_ok_function.dart';
import '../widgets/cancel_button_item.dart';
import 'cpf_insert.dart';

class PlacaInsertPage extends StatefulWidget {
  const PlacaInsertPage({Key? key}) : super(key: key);

  @override
  State<PlacaInsertPage> createState() => _PlacaInsertPageState();
}

class _PlacaInsertPageState extends State<PlacaInsertPage> {
  String actualDateTime = DateFormat("HH:mm:ss").format(DateTime.now());
  String enterDate = "";
  String enterHour = "";
  String permanecia = "";
  String placa = "";
  double proportion = 1.437500004211426;
  bool convenio = false;
  bool ticket_pago = false;

  var placaMaskFormatter = MaskTextInputFormatter(
    mask: '###-####',
    filter: {'#': RegExp(r'[A-Za-z0-9]')},
  );

  final TextEditingController inputPlacaController = TextEditingController();

  _carregarDados() async {
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
  // ??? that is function ???
  _postPlaca() async {
    final authToken = AuthToken().token;
    var response = await http.get(
      Uri.parse(
          'https://qas.sgpi.valenlog.com.br/api/v1/pdv/caixas/ticket/placa/atualizar/'),
      headers: {'Authorization': 'Bearer $authToken'},
    );
    if (response.statusCode == 200) {

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
                      "Alterar placa",
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
                          controller: inputPlacaController,
                          inputFormatters: [placaMaskFormatter],
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
                            hintText: placa,
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

                              onPressed: alterarPlaca,
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
                                    "Alterar placa",
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

  //metodo de alterar placa
  Future<void> alterarPlaca() async {
    final authToken = AuthToken().token;
    final url = Uri.parse(
        'https://qas.sgpi.valenlog.com.br/api/v1/pdv/caixas/ticket/placa/atualizar');
    final request = http.MultipartRequest('POST', url);
    request.fields['ticket_numero'] = '1970287849';
    // request.fields['ticket_numero'] = '${ScanResult.result}';
    request.fields['placa'] = inputPlacaController.text;

    // request.headers.addAll({'Authorization': 'Bearer $authToken'});
    request.headers.addAll({'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxMSIsImp0aSI6ImRkNjkzZDdkMzU1Y2VkMTBlZDMzMDZhZjY1ODU5Y2FjODM5ZTU2ZjEyYzNhNGFjMDExYTcxMzQ3ZDNjMDY5Y2Q1OWMyZTRhNTQxYzY4ZWE5IiwiaWF0IjoxNjc4OTkxMTc1LjMyODc2LCJuYmYiOjE2Nzg5OTExNzUuMzI4NzY0LCJleHAiOjE2Nzg5OTY1NzUuMzE4NzcyLCJzdWIiOiIzIiwic2NvcGVzIjpbInRvdGVuX3BkdiIsInRvdGVuX3Bkdl9wYXRpb18xIl19.oAQB7p-6kX_KAND6OO1jOBGXr06_qAJS7GgIfjki1anJlu3uad94cgTP5t8mhejAKVddAI4SFVUH13dJreVNBqtXtXgzOTDzVwUipvAlqilva1T5DQ6LSAiacNVwsqJmKdaDXjfXVffUKyO793LZigqSsMK-U26w73nVWOHSGjhW_2Eh_4Ri_6ZtCHp9bdytHouY3W-w4pdaUb0_nM39ATlLnzmpPIKPB05KbgNVf4LPif0m1qa_VQpmBRzbhTO-IClaFwux7Vw7ChKgsRVWE3UktSudp4fUD-fIuUdxHYPwl4IAav-Jfor2PD5zpKliw-tsmhhZGVORHZxGdpcAV__q91smq8Dju-VsEDbI58CsqeYXLjXTYbRpjqhg0eyrbcbVbN5Mz5T2BwunRXPtQAhSPRHlxSZeNvPcN9uiZqI-Exp9YkdLceqRKPtLVdy4ygDGH2jdWHZ0o82cNfM79tvBboXFUE80sr4XWyEruZVE0TavtF13R0Gmg0_XFf1IhNatgdcouSJowYkm9GDLjHShz_gvEQrT3xaD69VqI6-jnLQ0a5Qk4KkSIfSnk0wyHPwjmxXCYX1bO0QfAVp15oIl2UbYqlg3rH2xoc6MiuIxpoe1759W_jMYfrosHRIr20lnWGM5k8h_YWJPlAwJC9PvlkbDOfUdisPbsAwmcRs'});
    final resposta = await request.send();

    print(resposta.statusCode);
    if (resposta.statusCode == 200) {
      print("entrou");
      print(resposta);



      (isConveniado & isTicketPago) ? showModalClienteOk(context) : showModalClienteNo(context);

      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        Navigator.push(
          context,
          (isConveniado & isTicketPago)
              ? MaterialPageRoute(
                  builder: (context) => const CpfInsertPage(),
                )
              : MaterialPageRoute(
                  builder: (context) => const CpfPage(),
                ),
        );
      }
    }

    // if (resposta.statusCode == 200) {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => CpfPage()),
    //   );
    // } else {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => HomePage()),
    //   );
    // }
  }
}

// onPressed: () async {
//   isConveniado
//       ? showModalClienteOk(context)
//       : showModalClienteNo(context);
//
//   await Future.delayed(
//       const Duration(seconds: 2));
//
//   if (mounted) {
//     Navigator.push(
//       context,
//       isConveniado
//           ? MaterialPageRoute(
//               builder: (context) =>
//                   const CpfInsertPage(),
//             )
//           : MaterialPageRoute(
//               builder: (context) =>
//                   const CpfPage(),
//             ),
//     );
//   }
// },