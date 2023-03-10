import 'package:flutter/material.dart';
import 'PlayTab.dart';

class SelectableItemWidget extends StatefulWidget {
  final String url;
  final bool isSelected;

  const SelectableItemWidget({
    Key? key,
    required this.url,
    required this.isSelected,
  }) : super(key: key);

  @override
  _SelectableItemWidgetState createState() => _SelectableItemWidgetState();
}

class _SelectableItemWidgetState extends State<SelectableItemWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      value: widget.isSelected ? 1 : 0,
      duration: kThemeChangeDuration,
      vsync: this,
    );

    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.ease,
    ));
  }

  @override
  void didUpdateWidget(SelectableItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isSelected != widget.isSelected) {
      if (widget.isSelected) {
        controller.forward();
      } else {
        controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: scaleAnimation,
        builder: (context, child) => Transform.scale(
          scale: scaleAnimation.value,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: widget.isSelected ? 3 : 0,
                color: widget.isSelected ? Colors.black : Colors.white,
              ),
            ),
            child: child,
          ),
        ),
        child: cardImageSprite(widget.url, 200.00),
      );
}
