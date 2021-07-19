import 'package:campo_minado/models/campo.dart';
import 'package:flutter/material.dart';

class CampoWidget extends StatelessWidget {
  final Campo campo;
  final void Function(Campo) onOpen;
  final void Function(Campo) onChangeMark;

  CampoWidget({
    required this.campo,
    required this.onOpen,
    required this.onChangeMark,
  });

  Widget _getImage() {
    int qtdMina = campo.qtdMinasNaVizinhanca;

    if (campo.aberto && campo.minado && campo.explodido)
      return Image.asset('assets/images/bomba_0.jpeg');
    else if (campo.aberto && campo.minado)
      return Image.asset('assets/images/bomba_1.jpeg');
    else if (campo.aberto)
      return Image.asset('assets/images/aberto_$qtdMina.jpeg');
    else if (campo.marcado)
      return Image.asset('assets/images/bandeira.jpeg');
    else
      return Image.asset('assets/images/fechado.jpeg');
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onOpen(campo),
      onLongPress: () => onChangeMark(campo),
      child: _getImage(),
    );
  }
}
