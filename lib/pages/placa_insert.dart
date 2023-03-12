import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:totenvalen/pages/cpf.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:totenvalen/pages/home.dart';
import 'package:totenvalen/widgets/header_section_item.dart';
import 'package:totenvalen/widgets/real_time_clock_item.dart';
import 'package:http/http.dart' as http;

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

  var placaMaskFormatter = MaskTextInputFormatter(
    mask: '###-####',
    filter: {'#': RegExp(r'[A-Za-z0-9]')},
  );

  final TextEditingController inputPlacaController = TextEditingController();

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
              RealTimeClockItem(
                  proportion: proportion, actualDateTime: actualDateTime),
            ],
          ),
        ),
      ),
    );
  }

  //metodo de alterar placa
    Future<void>alterarPlaca () async {
    final url = Uri.parse('https://qas.sgpi.valenlog.com.br/api/v1/pdv/caixas/ticket/placa/atualizar');
    final request = http.MultipartRequest('POST', url);
    request.fields['ticket_numero'] = '196969542325';
    request.fields['placa'] = 'BBB-1c24';
    request.headers.addAll({'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI5IiwianRpIjoiNDE0NGYxZGYyNTc2MmU5Y2ViNzY3NzVlMGJiM2U2OTVkYmU3YWFhYzcwZDcwNjIwZDNjMDRlN2E1MzZiNDAyODhiYmQ5MTg2YThkZTA5NzYiLCJpYXQiOjE2Nzg2MjYwMzIuNTk5MTg5LCJuYmYiOjE2Nzg2MjYwMzIuNTk5MTk0LCJleHAiOjE2Nzg2MzE0MzIuNTg3MDIxLCJzdWIiOiIzIiwic2NvcGVzIjpbInRvdGVuX3BkdiIsInRvdGVuX3Bkdl9wYXRpb18xIl19.PIh61WSwzJrigk1ytcAH0yT6769GTSRmSvq0qQ76cKRFSzcEMZZw8B51S1SmDBG7IdNLU100tt_HYag6E-K-6XnKa8TeHcx2DPzJ64rFSisxshrvVVNVILJK9iGnbN3x1pOwTsBjv-0I7z1U3wfnxzu36f-swfBG1i8_82mMWVG9NpH2dthxdFWvRRxoHj8i8X7UTlu7M45ycKp_4eNb4k2HsXlSU7N-2l3CB7D3DJZrCqUKTmOBgew2MALbOn1DeXFyDCgkiC375h3IfHeqwrr_CK5JitAQtUFmwGZ4lqI-tnWLUibgXY8T4DqiU5GaVv5Wo6CdgyaAubtAVS06ssJl0GLDzm20zq_1w4G-zd_AUP_c48nDHOO7igysJ1JZiSnj35msjV2_vCp74tPxI5uG9ABlFHqwGlXVdWw5Mh6LFux9-EPflCmNwn-W6XwfSlsMEegkJwcVNed3tw949LJewTcyzlRefFGTy-J0LITvLQIEfj8vqwQDYC-YI2yGYVbO8PHoLmFkySXV5zb00DerY1SlPZZVES1wbYlDUIAGJjb-Js_-lFgkrXdw0UQWAftOWt2AkBTbqOdGZIZd-e6afC2NNTy6v6fIh0Z6hfu6OLeVTkk7I09CGyRRry6dGwwdyYoUdacc3GH-jlr2VQXrhqj3jfrrIT5-ThfbdQU'});
    final resposta = await request.send();
    if (resposta.statusCode == 200){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CpfPage()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
    }
    }

