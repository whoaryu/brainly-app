import 'dart:math';

import 'package:brainly/Constants/words.dart';
import 'package:brainly/Pages/settings.dart';
import 'package:brainly/providers/controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Components/grid.dart';
import '../Components/keyboard.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String _word;

  @override
  void initState() {
    final r=Random().nextInt(words.length);
    _word=words[r];
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Provider.of<Controller>(context, listen: false)
          .setCorrectWord(word: _word);
    });
    super.initState();  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Brainly'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Settings()));
          }, icon: const Icon(Icons.settings)),
        ],
        elevation: 0,
      ),
      body: const Column(
        children: [
          Divider(
            thickness: 2,
            height: 1,
          ),
          Expanded(
              flex: 7,
              child: Grid()),
          Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  KeyboardRow(min: 1, max: 10,),
                  KeyboardRow(min: 11, max: 19,),
                  KeyboardRow(min: 20, max: 29,),
                ],
              )),
        ],
      ),
    );
  }
}
