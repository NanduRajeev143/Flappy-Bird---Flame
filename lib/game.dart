import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird/components/background.dart';
import 'package:flappy_bird/components/bird.dart';
import 'package:flappy_bird/components/ground.dart';
import 'package:flappy_bird/components/pipe.dart';
import 'package:flappy_bird/components/pipe_manager.dart';
import 'package:flappy_bird/components/score.dart';
import 'package:flappy_bird/constants.dart';
import 'package:flutter/material.dart';

class FlappyBirdGame extends FlameGame with TapDetector, HasCollisionDetection {
  
  late Bird bird;
  late Background background;
  late Ground ground;
  late PipeManager pipeManager;
  late ScoreText scoreText;

  @override   
  FutureOr<void> onLoad() {
    background = Background(size);
    add(background);

    bird = Bird();
    add(bird);
    ground = Ground();
    add(ground);
    pipeManager = PipeManager();
    add(pipeManager);

    scoreText = ScoreText();
    add(scoreText);
  }

  @override
  void onTap() {
    bird.flap();
  }

  int score = 0;


  void increment(){
    score++;
  }

  bool isGameOver = false;

  void gameOver() {
    if (isGameOver) return;

    isGameOver = true;
    pauseEngine();

    showDialog(
      context: buildContext!,
      builder: (context) => AlertDialog(
        title: const Text("Game Over"),
        content: Text("Highest Score:  $score"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              resetGame();
            },
            child: const Text("Restart"),
          ),
        ],
      ),
    );
  }

  void resetGame() {
    bird.position = Vector2(birdStartx, birdstarty);
    bird.velocity = 0;
    score = 0;
    isGameOver = false;

    children.whereType<Pipe>().forEach((pipe) => pipe.removeFromParent());
    resumeEngine();
  }
}
