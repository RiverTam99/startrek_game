import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:startrek_game/klingon.dart';
import 'package:startrek_game/explosion.dart';
import 'package:startrek_game/main.dart';

class Startrek extends SpriteComponent {
  bool explode = false;
  double maxY;
  List<Klingon> klingonList = <Klingon>[];
  List<Startrek> startrekList = <Startrek>[];
  Startrek(this.klingonList, this.startrekList)
      : super.square(Startrek_SIZE, 'startrek.png');

  @override
  void update(double t) {
    y -= gameOver ? 0 : t * StartrekSPEED;

    if (klingonList.isNotEmpty)
      klingonList.forEach((klingon) {
        bool remove = this.toRect().contains(klingon.toRect().bottomCenter) ||
            this.toRect().contains(klingon.toRect().bottomLeft) ||
            this.toRect().contains(klingon.toRect().bottomRight);
        if (remove) {
          points += 1;
          klingon.explode = true;
          startrek.explode = true;
          klingonList.remove(klingon);
          game.add(new Explosion(klingon));
        }
      });
  }

  @override
  bool destroy() {
    if (explode) {
      return true;
    }
    if (y == null || maxY == null) {
      return false;
    }
    bool destroy = y >= maxY;

    return destroy;
  }

  @override
  void resize(Size size) {
    this.x = touchPositionDx;
    this.y = touchPositionDy;
    this.maxY = size.height;
  }
}
