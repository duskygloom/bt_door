import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Text(
            '--- Empty ---',
            textAlign: TextAlign.center,
            style: TextTheme.of(context).bodyLarge,
          ),
        ),
      ],
    );
  }
}
