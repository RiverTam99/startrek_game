import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:startrek_game/startrek.dart';
import 'package:startrek_game/klingon.dart';
import 'package:startrek_game/main.dart';

class Canvas1 extends BaseGame {
  bool checkOnce = true;

  List<Klingon> klingonList = <Klingon>[];
  List<Startrek> startrekList = <Startrek>[];
  Size dimenstions;

  Canvas1(this.dimenstions);

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    String text = points.toString();
    TextPainter p = Flame.util
        .text(text, color: Colors.white, fontSize: 48.0, fontFamily: 'Halo');
    String over = "Qapla'";
    TextPainter overGame = Flame.util
        .text(over, color: Colors.white, fontSize: 48.0, fontFamily: 'Halo');
    gameOver
        ? overGame.paint(canvas, Offset(size.width / 3, size.height / 2))
        : p.paint(canvas,
            new Offset(size.width - p.width - 10, size.height - p.height - 10));
  }

  double creationTimer = 0.0;
  @override
  void update(double t) {
    creationTimer += t;
    if (creationTimer >= 4) {
      creationTimer = 0.0;

      for (int i = 1; i <= klingon_SIZE / 7; i++) {
        for (int j = 0; j < i; ++j) {
          klingon = new Klingon(dimenstions, i, j);
          klingonList.add(klingon);
          add(klingon);
        }
      }
    }
    super.update(t);
  }

  void tapInput(Offset position) {
    touchPositionDx = position.dx;
    touchPositionDy = position.dy;
    startrekStartStop = true;
    startrekList.add(startrek);
    startrek = new Startrek(klingonList, startrekList);
    add(startrek);
  }

  void dragInput(Offset position) {
    touchPositionDx = position.dx;
    touchPositionDy = position.dy;
    startrekStartStop = true;
  }

  void onUp() {
    startrekStartStop = false;
  }
}
