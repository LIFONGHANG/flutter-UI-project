import 'package:flutter/material.dart';
import 'package:flutter_ui_project_salait/models/onboard_model.dart';

class Onboard1 extends StatelessWidget {
  const Onboard1({super.key, required this.data});
  final OnboardModel data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(children: [Text("1/3"),Text("Skip")], ),
        ],
      ),
    );
  }
}
