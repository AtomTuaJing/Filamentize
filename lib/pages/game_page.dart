import 'package:filamentize2/game/trash_game.dart';
import 'package:filamentize2/screens/game_over_screen.dart';
import 'package:filamentize2/screens/main_menu_screen.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class GamePage extends StatelessWidget {
  final game = TrashGame();

  GamePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(game: game, initialActiveOverlays: [
        MainMenuScreen.id
      ], overlayBuilderMap: {
        'mainMenu': (context, _) => MainMenuScreen(game: game),
        'gameOver': (context, _) => GameOverScreen(
              game: game,
            )
      }),
    );
  }
}
