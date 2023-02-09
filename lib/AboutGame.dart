import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flame_texturepacker/flame_texturepacker.dart';

var aboutMessages = [
  'Hey there,  \n'
      'thanks for checking out my game! \n'
      'This turn-based card game concept \n'
      'was developed by my cousin and I in \n'
      '2018. We originally printed out cards \n'
      'with Roman numerals on them denoting \n'
      'character values and slowly came up with \n'
      'simple thematic mechanics of counter \n'
      'plays according to different card classes. \n'
      '\n'
      '\n'
      '\n'
      '<                                                                       >',
  'After we got the concept down, we started  \n'
      'to slowly fine-tune the balance of the \n'
      'different cards by trying diferent unlikely \n'
      'combinations & scenarios. We wanted to  \n'
      'make it as simple as possible, yet generally \n'
      'fair and with plenty of room for strategic \n'
      'creativity. We found the best way to use the \n'
      'cards is to choose a selection for your \n'
      'hand before the game starts.\n'
      '\n'
      '\n'
      '\n'
      '<                                                                       >',
  'Since our high-school game developer \n'
      'days, John and I have really enjoyed  \n'
      'analyzing different kinds of strategy  \n'
      'card games in our spare time. We recently \n'
      'started casually developing a deck-building  \n'
      'card game, similar to \'Dominion\' but \n'
      'co-operative and with a theme of \n'
      'a ninja warrior RPG. However; me going\n'
      'to college and him starting as an electrician \n'
      'has slowed us down just a bit. We will\n'
      'finish it one day though.\n'
      '\n'
      '<                                                                       >',
  'When I started working on this app \n'
      'I told him about it and he was   \n'
      'excited to see how it would work.  \n'
      'Suprisingly enough, I found that coding \n'
      'the game taught me more about it, and  \n'
      'now we are eager to expand the concept, \n'
      'design more cards, and maybe get it \n'
      'printed out. After all, it\'s a lot\n'
      'easier to test out the mechanics with \n'
      'paper cards than with an app that I\n'
      'have to program myself.\n'
        '\n'
      '<                                                                       >',
  'We ended up adding 6 new cards, \n'
      're-vamping the abilities, and   \n'
      'playtesting it a ton in the process.  \n'
      'We think we could add more, but we \n'
      'want to have something robust and \n'
      'refined before we do. \n'
      ''
      ''
      'We also need to decide on a name...\n'
      '\n'
      '\n'
      '\n'
      '\n'
      '\n'
      '<                                                                       >',
];

class AboutGameTab extends FlameGame with TapDetector {
  final double characterSize = 120.0;

  late SpriteAnimationComponent boy;
  int state = 1; //0 = idle, 1=walk right, 2 = walk left, 3 = jump
  int dialogLevel = 0;
  var intscreenWidth;
  var screenHeight;
  var screenWidth;

  late SpriteAnimation idle;
  late SpriteAnimation walk;
  late SpriteAnimation walkLeft;
  late SpriteAnimation jump;

  TextPaint aboutTextPaint = TextPaint(
      style: const TextStyle(
    color: Colors.black,
    // fontFamily: 'FrizQuadrata',
    fontSize: 16,
  ));

  var rightEdge;
  var leftEdge;

  Future<void> onLoad() async {
    super.onLoad();

    screenWidth = size[0];
    screenHeight = size[1];
    rightEdge = screenWidth - (characterSize * .75);
    leftEdge = 0.00 - (characterSize * .25);

    final idleSheet = await fromJSONAtlas('idle.png', 'idle.json');
    final walkSheet = await fromJSONAtlas('walk.png', 'walk.json');
    final walkLeftSheet = await fromJSONAtlas('walkLeft.png', 'walkLeft.json');
    final jumpSheet = await fromJSONAtlas('jump.png', 'jump.json');

    idle = SpriteAnimation.spriteList(idleSheet, stepTime: .2);
    walk = SpriteAnimation.spriteList(walkSheet, stepTime: .2);
    walkLeft = SpriteAnimation.spriteList(walkLeftSheet, stepTime: .2);
    jump = SpriteAnimation.spriteList(jumpSheet, stepTime: .2);

    boy = SpriteAnimationComponent()
      ..animation = idle
      // ..position = Vector2(screenWidth/2, screenHeight/4)
      ..x = leftEdge
      ..y = screenHeight * .70
      ..size = Vector2(characterSize, characterSize);
    add(boy);
  }

  @override
  void update(double dt) {
    super.update(dt);
    switch (state) {
      case 0:
        boy.animation = idle;
        break;
      case 1:
        boy.animation = walk;
        boy.x += .5;

        break;
      case 2:
        boy.animation = walkLeft;
        boy.x -= .5;

        break;
      case 3:
        boy.animation = jump;
        break;
    }

    if (boy.x > rightEdge) {
      state = 2;
    }

    if (boy.x < leftEdge) {
      state = 1;
    }
  }

  @override
  void onTapUp(TapUpInfo info) {
    //get tap location relative to the viewport as aVector
    Vector2 tapLocation = info.eventPosition.viewport;

    if (tapLocation.x <= 120) {
      state = 2; //walk right
      dialogLevel--;
    } else if (tapLocation.x > 300) {
      state = 1; //walk left
      dialogLevel++;
    } else if (state == 0 &&
        tapLocation.x < 300 &&
        tapLocation.x > 120 &&
        tapLocation.y < 200) {
      state = 3; //jump up and down (only from idle)
    } else {
      state = 0; //stop
    }

    switch (state) {
      case 0:
        boy.animation = idle;
        break;
      case 1:
        boy.animation = walk;
        break;
      case 2:
        boy.animation = walkLeft;
        break;
      case 3:
        boy.animation = jump;
        break;
    }

    if (dialogLevel > aboutMessages.length - 1) dialogLevel = 0;
    if (dialogLevel < 0) dialogLevel = aboutMessages.length - 1;
  }

  @override
  Color backgroundColor() => const Color(0x0fffffff);

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    aboutTextPaint.render(canvas, aboutMessages[dialogLevel], Vector2(30, 50));
  }
}
