import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class GameWord extends FlameGame {
  late MyContainerComponent myContainerComponent;

  @override
  Future<void> onLoad() async {
    myContainerComponent = MyContainerComponent();
    add(myContainerComponent);
  }

  void toggleVisibility() {
    myContainerComponent.isVisible = !myContainerComponent.isVisible;
  }
}

class MyContainerComponent extends PositionComponent {
  bool isVisible = false;

  @override
  Future<void> onLoad() async {
    size = Vector2(200, 200); // Tamaño del cuadrado
    position = Vector2(100, 100); // Posición inicial
  }

  @override
  void render(Canvas canvas) {
    if (isVisible) {
      Paint paint = Paint()..color = Colors.blue;
      Rect rect = Rect.fromLTWH(0, 0, size.x, size.y);
      RRect rrect = RRect.fromRectAndRadius(rect, const Radius.circular(20));
      canvas.drawRRect(rrect, paint);

      TextPainter textPainter = TextPainter(
        text: const TextSpan(
          text: 'Hello',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(minWidth: 0, maxWidth: size.x);
      textPainter.paint(
          canvas,
          Offset((size.x - textPainter.width) / 2,
              (size.y - textPainter.height) / 2));
    }
  }
}

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    GameWord myGame = GameWord();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flame with Flutter UI'),
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            GameWidget(game: myGame),
            Positioned(
              bottom: 50,
              child: ElevatedButton(
                onPressed: () {
                  myGame.toggleVisibility();
                },
                child: const Text('Toggle Visibility'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
