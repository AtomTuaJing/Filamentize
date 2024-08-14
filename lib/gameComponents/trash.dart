import 'dart:math';

import 'package:filamentize2/game/assets.dart';
import 'package:filamentize2/game/trash_game.dart';
import 'package:filamentize2/gameComponents/panda.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';

class Trash extends SpriteComponent
    with HasGameRef<TrashGame>, CollisionCallbacks {
  Trash();

  final random = Random();
  late int number;

  @override
  Future<void> onLoad() async {
    final trash1 = await Flame.images.load(Assets.trash1);
    final trash2 = await Flame.images.load(Assets.trash2);
    final trash3 = await Flame.images.load(Assets.trash3);
    final trash4 = await Flame.images.load(Assets.trash4);
    final trash5 = await Flame.images.load(Assets.trash5);
    final trash6 = await Flame.images.load(Assets.trash6);
    size = Vector2(50, 50);
    position = Vector2(random.nextDouble() * gameRef.size.x, 0);

    number = random.nextInt(230) + 150;

    int randomNumber = random.nextInt(6);

    switch (randomNumber) {
      case 1:
        sprite = Sprite(trash1);
        break;
      case 2:
        sprite = Sprite(trash2);
        break;
      case 3:
        sprite = Sprite(trash3);
        break;
      case 4:
        sprite = Sprite(trash4);
        break;
      case 5:
        sprite = Sprite(trash5);
        break;
      case 6:
        sprite = Sprite(trash6);
        break;
      default:
        sprite = Sprite(trash1);
        break;
    }

    add(RectangleHitbox());
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Panda) {
      removeFromParent();
      updateScore();
    }
  }

  void updateScore() {
    gameRef.heart -= 1;
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += number * dt;
  }
}
