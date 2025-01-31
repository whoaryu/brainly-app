import 'package:brainly/Constants/answer_stages.dart';
import 'package:brainly/Data/keys_map.dart';
import 'package:brainly/models/tile_model.dart';
import 'package:flutter/material.dart';

class Controller extends ChangeNotifier{
  int currentTile =0, currentRow=0;
  String correctWord="";
  List<TileModel> tilesEntered=[];
  
  setCorrectWord({required String word}) => correctWord=word;


  
  setKeyTapped({required String value}){
    if(value=='Enter'){
      if(currentTile==5*(currentRow+1)){
        checkWord();
       
        
      }
      else{
        return SnackBar(content: Text('Not a valid word'));
      }
      
    }
    else if(value=='Back'){
      if(currentTile>=5*(currentRow+1)-5){
        currentTile--;
        tilesEntered.removeLast();
      }
      
    }
    else{
      if(currentTile<5*(currentRow+1)){
        tilesEntered.add(TileModel(letter: value, answerStages: AnswerStages.notAnswered)); 
        currentTile++;
      }
      
    }
    notifyListeners();
  }

  checkWord(){
  List<String> guessed=[];
  List<String> remainingCorrect=[];
  String guessedWord="";
  for(int i=currentRow*5; i<currentRow*5+5;i++){
    guessed.add(tilesEntered[i].letter);
  }
  guessedWord=guessed.join();
  remainingCorrect=correctWord.characters.toList( );
  if(guessedWord==correctWord){
     for(int i=currentRow*5; i<currentRow*5+5;i++){
    tilesEntered[i].answerStages=AnswerStages.correct;
    keysMap.update(tilesEntered[i].letter, (value) => AnswerStages.correct);
  }
  }
  else{
    for(int i=0;i<5;i++){
      if(guessedWord[i]==correctWord[i]){
        tilesEntered[i+(currentRow*5)].answerStages=AnswerStages.correct;
        remainingCorrect.remove(guessedWord[i]);
      }
    }
    for(int i=0;i<remainingCorrect.length;i++){
      for(int j=0;j<5;j++){
        if(remainingCorrect[i]==tilesEntered[j+(currentRow*5)].letter){
          if(tilesEntered[j+(currentRow*5)].answerStages!=AnswerStages.correct) {
            tilesEntered[j+(currentRow*5)].answerStages=AnswerStages.contains;
          }
          final resultkey=keysMap.entries.where((element) => element.key==tilesEntered[j+currentRow*5]);
          if(resultkey.single.value!=AnswerStages.correct){
            keysMap.update(resultkey.single.key, (value)=> AnswerStages.contains);
          }
        }
      }
    }
  }

  for(int i=currentRow*5; i<currentRow*5+5;i++){
    if(tilesEntered[i].answerStages==AnswerStages.notAnswered){
      tilesEntered[i].answerStages=AnswerStages.incorrect;
      keysMap.update(tilesEntered[i].letter, (value)=>AnswerStages.incorrect);
    }
  }


   currentRow++;
   notifyListeners();
}
}

