import 'package:flutter/material.dart';

final theme = ThemeData(
        textTheme: TextTheme(
          bodyMedium: const TextStyle(color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 20),
        bodySmall: const TextStyle(color: Colors.white,
            fontWeight: FontWeight.w300,
            fontSize: 16),
            labelLarge: const TextStyle(
              color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 24
            ),
            bodyLarge: const TextStyle(
              color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 36
            ),
            labelMedium: const TextStyle(color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 20),
            labelSmall: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                )
        )
      );