import 'package:filamentize2/game/assets.dart';
import 'package:filamentize2/game/trash_game.dart';
import 'package:flutter/material.dart';

class GameOverScreen extends StatelessWidget {
  final TrashGame game;
  static const String id = "gameOver";

  const GameOverScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black38,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Score ${game.panda.score}",
                style: const TextStyle(
                    fontSize: 60, color: Colors.white, fontFamily: "Game")),
            Image.asset(Assets.gameOver),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: onRestart,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[600]),
                child: const Text("Restart",
                    style: TextStyle(fontSize: 20, color: Colors.white)))
          ],
        ),
      ),
    );
  }

  void onRestart() {
    game.overlays.remove("gameOver");
    game.panda.score = 0;
    game.heart = 6;
    game.resumeEngine();
  }
}
