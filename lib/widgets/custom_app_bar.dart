import 'package:flutter/material.dart';
import 'package:melodex/theme/app_theme.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.music_note, color: AppTheme.primary, size: 24),
            SizedBox(width: 2),
            Text(
              'Melodex',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(color: AppTheme.accent),
            ),
          ],
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.person_pin, color: Colors.white, size: 24),
        ),
      ],
    );
  }
}
