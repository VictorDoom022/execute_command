import 'dart:io';
import 'package:execute_command/view/MainStructure.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Window.initialize();

  runApp(
      FluentApp(
        title: 'Execute Command',
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const MainStructure(),
        },
      )
  );
}
