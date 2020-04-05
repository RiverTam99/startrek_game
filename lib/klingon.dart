import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:startrek_game/main.dart';

class Klingon extends SpriteComponent {
  Size dimenstions;
  int postion;
  int ypostion;
  bool explode = false;
  double maxY;

  Klingon(this.dimenstions, this.postion, this.ypostion)
      : super.square(klingon_SIZE, 'klingon.png');

  @override
  void update(double t) {
    y += gameOver ? 0 : (t * klingonSPEED);
  }

  @override
  bool destroy() {
    if (explode) {
      return true;
    }
    if (y == null || maxY == null) {
      return false;
    }
    bool destroy = y >= maxY + klingon_SIZE / 2;
    if (destroy) {
      gameOver = true;

      print("Qapla");
      return true;
    }
    return destroy;
  }

  @override
  void resize(Size size) {
    this.x = (klingon_SIZE * postion);
    this.y = klingon_SIZE * ypostion;
    this.maxY = size.height;
  }
}
