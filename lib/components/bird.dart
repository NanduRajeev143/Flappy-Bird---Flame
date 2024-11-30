import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_bird/components/ground.dart';
import 'package:flappy_bird/components/pipe.dart';
import 'package:flappy_bird/constants.dart';
import 'package:flappy_bird/game.dart';

class Bird extends SpriteComponent with CollisionCallbacks{
  Bird() : 
  super(position: Vector2(birdStartx, birdstarty), size: Vector2(birdWidth, birdHeight));

  double velocity = 0;
  

  @override
  FutureOr<void> onLoad() async {
    try {
      sprite = await Sprite.load('bird.png');
      add(RectangleHitbox());
    } catch (e) {
      //print('Failed to load sprite: $e');
    }
  }

  void flap() {
    velocity = jumpstrength;
  }

  @override
  void update(double dt) {
    super.update(dt);
    velocity += gravity * dt;
    position.y += velocity * dt;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if(other is Ground){
      (parent as FlappyBirdGame).gameOver();
    }
    if(other is Pipe){
      (parent as FlappyBirdGame).gameOver();
    }
  }
}