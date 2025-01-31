import 'package:brainly/Constants/answer_stages.dart';
import 'package:brainly/Constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/controller.dart';

class Tile extends StatefulWidget {
  const Tile({
    super.key,
    required this.index,
  });
  final int index;

  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> {
  Color _backgroundColor = Colors.transparent;
  late AnswerStages _answerStages;
  Color borderColor=Colors.transparent;

@override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      
    borderColor=Theme.of(context).primaryColorLight;
    },);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Controller>(builder: (_, notifier, __) {
      String text = "";
      Color fontColor=Colors.white;
      if (widget.index < notifier.tilesEntered.length) {
        text = notifier.tilesEntered[widget.index].letter;
        _answerStages = notifier.tilesEntered[widget.index].answerStages;
        if (_answerStages == AnswerStages.contains) {
          _backgroundColor = containsYellow;
        } else if (_answerStages == AnswerStages.correct) {
          _backgroundColor = correctGreen;
          borderColor=Colors.transparent;
        }
        else if(_answerStages==AnswerStages.incorrect){
          borderColor=Colors.transparent;
          _backgroundColor=Theme.of(context).primaryColorDark;
        }
        else{
          _backgroundColor = Colors.transparent;
          fontColor= Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black;
        }
        return Container(
            decoration: BoxDecoration(
              color: _backgroundColor,
              border:Border.all(
                color: borderColor,
              )
            ),
            child: FittedBox(
                fit: BoxFit.contain,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(text, style: TextStyle().copyWith(
                    color: fontColor,
                  )),
                )));
      } else {
        return Container(
          decoration: BoxDecoration(
              color: _backgroundColor,
              border:Border.all(
                color: borderColor,
              )
            ),
        );
      }
    });
  }
}
