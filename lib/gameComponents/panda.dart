import 'package:filamentize2/game/assets.dart';
import 'package:filamentize2/game/trash_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

class Panda extends SpriteComponent with HasGameRef<TrashGame>, DragCallbacks {
  Panda();

  int score = 0;

  @override
  Future<void> onLoad() async {
    final panda = await gameRef.loadSprite(Assets.panda);
    size = Vector2(80, 120);
    position = Vector2(
        gameRef.size.x / 2 - size.x / 2, gameRef.size.y - (size.y + 20));
    sprite = panda;

    add(CircleHitbox());
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    position.x += event.localDelta.x;
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (score < 0) {
      score = 0;
    }
  }
}
