import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_bird/constants.dart';
import 'package:flappy_bird/game.dart';

class Pipe extends SpriteComponent with CollisionCallbacks, HasGameRef<FlappyBirdGame> {
  final bool isTopPipe;
  bool scored = false;

  Pipe(Vector2 position, Vector2 size, {required this.isTopPipe})
      : super(position: position, size: size);

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load(isTopPipe ? 'pipe_top.png' : 'pipe_bottom.png');
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    position.x -= groundScrollingspeed * dt;

    if (!scored && !isTopPipe && position.x + size.x < gameRef.bird.position.x) {
      scored = true;
      gameRef.increment();
    }

    if (position.x + size.x <= 0) {
      removeFromParent();
    }
  }
}