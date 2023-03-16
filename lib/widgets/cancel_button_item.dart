import 'package:flutter/material.dart';
import 'package:totenvalen/pages/home.dart';
import 'package:totenvalen/util/modal_transacao_cancelada_function.dart';

class CancelButtonItem extends StatefulWidget {
  const CancelButtonItem({
    Key? key,
    required this.proportion,
  }) : super(key: key);

  final double proportion;

  @override
  State<CancelButtonItem> createState() => _CancelButtonItemState();
}

class _CancelButtonItemState extends State<CancelButtonItem> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: SizedBox(
        width: (192 / widget.proportion).roundToDouble(),
        height: (155 / widget.proportion).roundToDouble(),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFFFF875E),
                Color(0xFFFA6900),
              ],
            ),
            borderRadius: BorderRadius.only(
              topLeft:
                  Radius.circular((30 / widget.proportion).roundToDouble()),
            ),
          ),
          child: ElevatedButton(
            onPressed: () async {
              showModalTransacaoCancelada(context);

              await Future.delayed(const Duration(seconds: 2));

              if (mounted) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              disabledForegroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
            child: Icon(
              Icons.cancel_outlined,
              size: (80 / widget.proportion).roundToDouble(),
            ),
          ),
        ),
      ),
    );
  }
}
