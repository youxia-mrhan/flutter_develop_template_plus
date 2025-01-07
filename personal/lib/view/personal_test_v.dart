import 'package:flutter/material.dart';
import 'package:personal/res/string/str_personal.dart';

class PersonalTestV extends StatefulWidget {
  const PersonalTestV({super.key});

  @override
  State<PersonalTestV> createState() => _PersonalTestVState();
}

class _PersonalTestVState extends State<PersonalTestV> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StrPersonal.TestRoute),
      ),
    );
  }
}
