import 'package:flutter/material.dart';
import 'package:insta_riverpod/views/components/animations/index.dart';

class EmptyContentAnimationView extends StatelessWidget {
  final String text;

  const EmptyContentAnimationView({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white54,
                  ),
            ),
            const EmptyAnimationView(),
          ],
        ),
      ),
    );
  }
}
