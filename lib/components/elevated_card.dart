import 'package:flutter/material.dart';

class ElevatedCard extends StatelessWidget {
  final Widget content;

  const ElevatedCard({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6), // Apply border radius here
      ),
      elevation: 4,
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: content,
        ),
      ),
    );
  }
}
