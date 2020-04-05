import 'package:flame/components/animation_component.dart';
import 'package:startrek_game/klingon.dart';
import 'package:startrek_game/main.dart';

class Explosion extends AnimationComponent {
  static const TIME = 0.75;

  Explosion(Klingon klingon)
      : super.sequenced(klingon_SIZE, klingon_SIZE, 'explosion-4.png', 7,
            textureWidth: 31.0, textureHeight: 31.0) {
    this.x = klingon.x;
    this.y = klingon.y;
    this.animation.stepTime = TIME / 7;
  }

  bool destroy() {
    return this.animation.isLastFrame;
  }
}
