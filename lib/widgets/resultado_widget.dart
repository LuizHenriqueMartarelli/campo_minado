import 'package:flutter/material.dart';

typedef OnReset = void Function();

class ResultadoWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool? venceu;
  final OnReset? onReset;

  ResultadoWidget({required this.venceu, required this.onReset});

  Color _getCor() {
    if (venceu == null)
      return Colors.yellow;
    else if (venceu!)
      return Colors.green[300]!;
    else
      return Colors.red[300]!;
  }

  IconData _getIcon() {
    if (venceu == null)
      return Icons.sentiment_satisfied;
    else if (venceu!)
      return Icons.sentiment_very_satisfied;
    else
      return Icons.sentiment_very_dissatisfied;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: CircleAvatar(
            backgroundColor: _getCor(),
            child: IconButton(
              padding: const EdgeInsets.all(0),
              icon: Icon(
                _getIcon(),
                color: Colors.black,
                size: 35,
              ),
              onPressed: onReset != null ? onReset : null,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(120);
}
