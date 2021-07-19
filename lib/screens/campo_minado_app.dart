import 'package:campo_minado/models/campo.dart';
import 'package:campo_minado/models/explosao_exception.dart';
import 'package:campo_minado/models/tabuleiro.dart';
import 'package:campo_minado/widgets/resultado_widget.dart';
import 'package:campo_minado/widgets/tabuleiro_widget.dart';
import 'package:flutter/material.dart';

class CampoMinadoApp extends StatefulWidget {
  @override
  _CampoMinadoAppState createState() => _CampoMinadoAppState();
}

class _CampoMinadoAppState extends State<CampoMinadoApp> {
  bool? _venceu;
  Tabuleiro? _tabuleiro;

  void _reinciar() {
    setState(() {
      _venceu = null;
      _tabuleiro!.reiniciar();
    });
  }

  _abrir(Campo c) {
    if (_venceu != null) return;

    setState(() {
      try {
        c.abrir();
        if (_tabuleiro!.resolvido) _venceu = true;
      } on ExplosaoException {
        _venceu = false;
        _tabuleiro!.revelarBombas();
      }
    });
  }

  _onChangeMark(Campo c) {
    if (_venceu != null) return;

    setState(() {
      c.alternarMarcacao();
      if (_tabuleiro!.resolvido) _venceu = true;
    });
  }

  Tabuleiro _getTabuleiro({required double largura, required double altura}) {
    if (_tabuleiro == null) {
      int qtdColunas = 15;
      double tamanhoCampo = largura / qtdColunas;
      int qtdeLinhas = (altura / tamanhoCampo).floor();

      _tabuleiro = Tabuleiro(
        linhas: qtdeLinhas,
        colunas: qtdColunas,
        qtdeBombas: 10,
      );
    }

    return _tabuleiro!;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: ResultadoWidget(
          venceu: _venceu,
          onReset: _reinciar,
        ),
        body: Container(
          color: Colors.grey,
          child: LayoutBuilder(
            builder: (ctx, constrains) {
              return TabuleiroWidget(
                tabuleiro: _getTabuleiro(
                  largura: constrains.maxWidth,
                  altura: constrains.maxHeight,
                ),
                onOpen: _abrir,
                onChangeMark: _onChangeMark,
              );
            },
          ),
        ),
      ),
    );
  }
}
