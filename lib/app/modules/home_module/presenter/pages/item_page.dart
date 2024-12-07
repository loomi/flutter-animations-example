import 'package:flutter/material.dart';

import 'components/placeholder_widget.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({super.key, required this.index});

  final int index;

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _topBarOffsetAnimation;
  late Animation<Offset> _itemDescriptionOffsetAnimation;
  late Animation<Offset> _actionBarOffsetAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _topBarOffsetAnimation = Tween<Offset>(
      begin: const Offset(0, -2),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.0,
          0.5,
          curve: Curves.easeInOut,
        ),
      ),
    );

    _itemDescriptionOffsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1.5),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.5,
          1.0,
          curve: Curves.easeInOut,
        ),
      ),
    );

    _actionBarOffsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.5,
          1.0,
          curve: Curves.easeInOut,
        ),
      ),
    );

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRect(
                  child: SlideTransition(
                    position: _topBarOffsetAnimation,
                    child: Container(
                      height: 250,
                      color: Colors.green.shade100,
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: Hero(
                      tag: widget.index,
                      child: PlaceholderWidget(
                        radius: 30,
                        color: Colors.grey.shade300,
                        label: "Imagem",
                        height: 300,
                        width: 200,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ClipRect(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SlideTransition(
                  position: _itemDescriptionOffsetAnimation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Nome do item",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          PlaceholderWidget(
                            color: Colors.grey.shade300,
                            label: "Descrição",
                          ),
                          const SizedBox(width: 10),
                          PlaceholderWidget(
                            color: Colors.grey.shade300,
                            label: "Descrição",
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Descrição do item item item item item item item item item item item item item item item item item item item item item item item item item item item",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ClipRect(
              child: SlideTransition(
                position: _actionBarOffsetAnimation,
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: PlaceholderWidget(
                    radius: 10,
                    padding: EdgeInsets.all(20),
                    color: Colors.brown,
                    label: "Barra de ações",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
