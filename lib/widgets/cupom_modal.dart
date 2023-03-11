import 'package:flutter/material.dart';

class CupomModalWidget extends StatefulWidget {
  const CupomModalWidget({Key? key}) : super(key: key);

  @override
  State<CupomModalWidget> createState() => _CupomModalWidgetState();
}

class _CupomModalWidgetState extends State<CupomModalWidget> {
  double proportion = 1.437500004211426;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular((12 / proportion).roundToDouble()),
      ),
      child: Container(
        height: (500 / proportion).roundToDouble(),
        width: (1340 / proportion).roundToDouble(),
        decoration: BoxDecoration(
            color: Color(0xFFF0F0F0),
            borderRadius: BorderRadius.all(
                Radius.circular((12 / proportion).roundToDouble()))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Aproxime o cupom na leitora",
              style: TextStyle(
                color: Color(0xFF1A2EA1),
                fontSize: (72 / proportion).roundToDouble(),
                fontWeight: FontWeight.w600,
              ),
            ),
            CircularProgressIndicator(),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
