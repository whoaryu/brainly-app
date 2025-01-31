import 'package:brainly/Constants/answer_stages.dart';
import 'package:brainly/Constants/colors.dart';
import 'package:brainly/providers/controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Data/keys_map.dart';

class KeyboardRow extends StatelessWidget {
  const KeyboardRow({
    super.key, required this.min, required this.max,
  });
  final int min, max;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Consumer<Controller>(
      builder: (_,notifier,__) {
        int index=0;
        return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: keysMap.entries.map((e) {
          index++;
          if (index >= min && index <= max) {
            Color color=Theme.of(context).primaryColorLight;
            Color keyColor=Colors.white;
            if(e.key==AnswerStages.contains){
              color=correctGreen;
            }
            else if(e.key==AnswerStages.contains){
              color=containsYellow;
            }
            else if(e.key==AnswerStages.incorrect){
              color=Theme.of(context).primaryColorDark;
            }
            else{
              keyColor=Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black;
            }
            return Padding(
              padding: EdgeInsets.all(size.width * 0.006),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: SizedBox(
                  width: e.key == 'Enter' || e.key == 'Back'
                      ? size.width * 0.13
                      : size.width * 0.085,
                  height: size.height * 0.06,
                  child: Material(
                    color: color,
                    child: InkWell(
                       onTap: () {
                                    Provider.of<Controller>(context,
                                            listen: false)
                                        .setKeyTapped(value: e.key);
                                  },
                      child: Center(
                        child: e.key == 'Back'
                            ? Icon(Icons.backspace_outlined, size: size.width * 0.04) 
                            : Text(
                                e.key,
                                style:  Theme.of(context).textTheme.bodyMedium?.copyWith(color:keyColor),
                              ), // Show text for other keys
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        }).toList(),
      );
      },
    );
  }
}
