import 'dart:math';
import 'package:filamentize2/game/assets.dart';
import 'package:filamentize2/game/trash_game.dart';
import 'package:filamentize2/gameComponents/panda.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';

class Bottle extends SpriteComponent
    with HasGameRef<TrashGame>, CollisionCallbacks {
  Bottle();

  final random = Random();

  @override
  Future<void> onLoad() async {
    final bottle1 = await Flame.images.load(Assets.bottle1);
    final bottle2 = await Flame.images.load(Assets.bottle2);
    final bottle3 = await Flame.images.load(Assets.bottle3);
    final bottle4 = await Flame.images.load(Assets.bottle4);
    final bottle5 = await Flame.images.load(Assets.bottle5);
    final bottle6 = await Flame.images.load(Assets.bottle6);
    size = Vector2(40, 85);
    position = Vector2(random.nextDouble() * gameRef.size.x, 0);

    int number = random.nextInt(6);

    switch (number) {
      case 1:
        sprite = Sprite(bottle1);
        break;
      case 2:
        sprite = Sprite(bottle2);
        break;
      case 3:
        sprite = Sprite(bottle3);
        break;
      case 4:
        sprite = Sprite(bottle4);
        break;
      case 5:
        sprite = Sprite(bottle5);
        break;
      case 6:
        sprite = Sprite(bottle6);
        break;
      default:
        sprite = Sprite(bottle1);
        break;
    }

    add(RectangleHitbox());
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    removeFromParent();
    if (other is Panda) {
      updateScore();
    }
  }

  void updateScore() {
    gameRef.panda.score += 1;
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += 210 * dt;

    if (position.y > gameRef.size.y) {
      removeFromParent();
      gameRef.panda.score -= 1;
      gameRef.heart -= 1;
    }
  }
}
