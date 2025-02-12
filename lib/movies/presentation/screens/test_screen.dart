import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/helpers/extensions/string_extensions.dart';

@RoutePage()
class TestDummyScreen extends StatelessWidget {
  const TestDummyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(child: 'hello world'.toSubTitle(),);
  }
}