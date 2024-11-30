import 'dart:math';
import 'package:flame/components.dart';
import 'package:flappy_bird/components/pipe.dart';
import 'package:flappy_bird/constants.dart';
import 'package:flappy_bird/game.dart';

class PipeManager extends Component with HasGameRef<FlappyBirdGame> {
  double pipeSpawnTimer = 0;
  final Random random = Random();
  final double pipeScaleFactor = 0.7; 
  final double adjustedPipeGap = pipeGap * 0.8; 

  @override
  void update(double dt) {
    pipeSpawnTimer += dt;

    if (pipeSpawnTimer > pipeInterval) {
      pipeSpawnTimer = 0;
      spawnPipe();
    }
  }

  void spawnPipe() {
    final double screenHeight = gameRef.size.y;

    final double maxPipeHeight = (screenHeight - groundHeight - adjustedPipeGap - minPipeHeight) * pipeScaleFactor;

    final double bottomPipeHeight = minPipeHeight + random.nextDouble() * (maxPipeHeight - minPipeHeight);

    final double topPipeHeight = screenHeight - groundHeight - bottomPipeHeight - adjustedPipeGap;

    final bottomPipe = Pipe(
      Vector2(gameRef.size.x, screenHeight - groundHeight - bottomPipeHeight),
      Vector2(pipeWidth * pipeScaleFactor, bottomPipeHeight),
      isTopPipe: false,
    );

    final topPipe = Pipe(
      Vector2(gameRef.size.x, 0),
      Vector2(pipeWidth * pipeScaleFactor, topPipeHeight),
      isTopPipe: true,
    );

    gameRef.add(bottomPipe);
    gameRef.add(topPipe);
  }
}
