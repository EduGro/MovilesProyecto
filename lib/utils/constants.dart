import 'package:flutter/material.dart';

// home
const String APP_TITLE = "HOGWARTS";
// app
const _redPrimaryValue = 0xFF800000;
const Color PRIMARY_COLOR = const MaterialColor(
  _redPrimaryValue,
  const <int, Color>{
    50: const Color(0xFFD21616),
    100: const Color(0xFFD21616),
    200: const Color(0xFFD21616),
    300: const Color(0xFFD21616),
    400: const Color(0xFFD21616),
    500: const Color(_redPrimaryValue),
    600: const Color(0xFFD21616),
    700: const Color(0xFFD21616),
    800: const Color(0xFFD21616),
    900: const Color(0xFFD21616),
  },
);

const _silverSecondaryValue = 0xFFACACAB;
const Color SECONDARY_COLOR = const MaterialColor(
  _silverSecondaryValue,
  const <int, Color>{
    50: const Color(0xFFACACAB),
    100: const Color(0xFFACACAB),
    200: const Color(0xFFACACAB),
    300: const Color(0xFFACACAB),
    400: const Color(0xFFACACAB),
    500: const Color(_silverSecondaryValue),
    600: const Color(0xFFACACAB),
    700: const Color(0xFFACACAB),
    800: const Color(0xFFACACAB),
    900: const Color(0xFFACACAB),
  },
);

const Color SLYTHERIN_COLOR = Color(0xFF1B5E20);
const Color RAVENCLAW_COLOR = Color(0xFF01579B);
const Color HUFFLEPUFF_COLOR = Color(0xFFFFD600);
const Color GRYFFINDOR_COLOR = Color(0xFFB71C1C);