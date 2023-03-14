import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_stateful_1/counter_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Parent(),
    );
  }
}

class Parent extends StatefulWidget {
  const Parent({Key? key}) : super(key: key);

  @override
  State<Parent> createState() => _ParentState();
}

class _ParentState extends State<Parent> {

  @override
  Widget build(BuildContext context) {
    final counterController = context.read<CounterController>();
    return Row(
      children: [
        Child1(),
        Child2(),
      ],
    );
  }
}

class Child1 extends StatelessWidget {

  const Child1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (){
      },
      child: Text("난수 생성"),
    );
  }
}

class Child2 extends StatelessWidget {

  const Child2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("0");
  }
}