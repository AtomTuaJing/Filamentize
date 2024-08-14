import 'package:filamentize2/game/assets.dart';
import 'package:filamentize2/game/trash_game.dart';
import 'package:filamentize2/game/heart_amount.dart';
import 'package:flame/components.dart';

class Heart extends SpriteGroupComponent with HasGameRef<TrashGame> {
  Heart();

  @override
  Future<void> onLoad() async {
    final zeroHeart = await gameRef.loadSprite(Assets.zeroHeart);
    final oneHeart = await gameRef.loadSprite(Assets.oneHeart);
    final twoHeart = await gameRef.loadSprite(Assets.twoHeart);
    final threeHeart = await gameRef.loadSprite(Assets.threeHeart);
    final fourHeart = await gameRef.loadSprite(Assets.fourHeart);
    final fiveHeart = await gameRef.loadSprite(Assets.fiveHeart);
    final sixHeart = await gameRef.loadSprite(Assets.sixHeart);

    size = Vector2(140, 40);
    position = Vector2(gameRef.size.x - (size.x + 10), 10);
    current = heartAmount.six;
    sprites = {
      heartAmount.zero: zeroHeart,
      heartAmount.one: oneHeart,
      heartAmount.two: twoHeart,
      heartAmount.three: threeHeart,
      heartAmount.four: fourHeart,
      heartAmount.five: fiveHeart,
      heartAmount.six: sixHeart,
    };
  }

  @override
  void update(double dt) {
    super.update(dt);

    switch (gameRef.heart) {
      case 6:
        current = heartAmount.six;
        break;
      case 5:
        current = heartAmount.five;
        break;
      case 4:
        current = heartAmount.four;
        break;
      case 3:
        current = heartAmount.three;
        break;
      case 2:
        current = heartAmount.two;
        break;
      case 1:
        current = heartAmount.one;
        break;
      case 0:
        current = heartAmount.zero;
        break;
    }
  }
}
