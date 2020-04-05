import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:startrek_game/startrek.dart';
import 'package:startrek_game/klingon.dart';
import 'package:startrek_game/canvas.dart';

bool gameOver = false;
const klingonSPEED = 120.0;
const StartrekSPEED = 60.0;
const klingon_SIZE = 40.0;
const Startrek_SIZE = 20.0;

var points = 0;
Klingon klingon;
Startrek startrek;

var game;

bool startrekStartStop = false;

double touchPositionDx = 0.0;
double touchPositionDy = 0.0;

main() async {
  Flame.audio.disableLog();
  Flame.images.loadAll(['klingon.png', 'startrek.png']);

  var dimensions = await Flame.util.initialDimensions();

  game = new Canvas1(dimensions);
  runApp(MaterialApp(
      home: Scaffold(
          body: Container(
    decoration: new BoxDecoration(
      image: new DecorationImage(
        image: new AssetImage("assets/images/ship.jpg"),
        fit: BoxFit.cover,
      ),
    ),
    child: GameWrapper(game),
  ))));

  HorizontalDragGestureRecognizer horizontalDragGestureRecognizer =
      new HorizontalDragGestureRecognizer();

  Flame.util.addGestureRecognizer(horizontalDragGestureRecognizer
    ..onUpdate = (startDetails) => game.dragInput(startDetails.globalPosition));

  Flame.util.addGestureRecognizer(new TapGestureRecognizer()
    ..onTapDown = (TapDownDetails evt) => game.tapInput(evt.globalPosition));

  // Adds onUP feature to fire startreks
  Flame.util.addGestureRecognizer(new TapGestureRecognizer()
    ..onTapUp = (TapUpDetails evt) => game.onUp(evt.globalPosition));
}

class GameWrapper extends StatelessWidget {
  final Canvas1 game;
  GameWrapper(this.game);

  @override
  Widget build(BuildContext context) {
    return game.widget;
  }
}
