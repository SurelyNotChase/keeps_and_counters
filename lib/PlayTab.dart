// ignore_for_file: prefer_typing_uninitialized_variables

import 'constants.dart';
import 'ReviewHand.dart';
import 'selectable_item_widget.dart';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:flutter/material.dart';

class PlayTab extends StatefulWidget {
  const PlayTab({super.key});

  @override
  PlayTabState createState() => PlayTabState();
}

class PlayTabState extends State<PlayTab> {
  final controller = DragSelectGridViewController();
  final urlImages = cardData
      .map(
        (card) => '${card["name"]}',
      )
      .toList();
  final cardList = cardData.toList();

  @override
  void initState() {
    super.initState();
    controller.addListener(rebuild);
  }

  @override
  void dispose() {
    controller.removeListener(rebuild);
    super.dispose();
  }

  void rebuild() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final isSelected = controller.value.isSelecting;
    final text = isSelected
        ? '${controller.value.amount} Cards Selected'
        : 'Select Hand';

    return Scaffold(
      appBar: AppBar(
        title: Text(text),
        leading: isSelected
            ? const CloseButton()
            : const SizedBox(
                width: 0,
                height: 0,
              ),
        actions: [
          if (isSelected && ( controller.value.selectedIndexes.length >= 4 &&
                    controller.value.selectedIndexes.length <= 7))
            IconButton(
              icon: const Icon(Icons.done),
              onPressed: () {
                final urlSelectedCards = controller.value.selectedIndexes
                    .map((index) => cardList[index])
                    .toList();

                if (controller.value.selectedIndexes.length >= 4 &&
                    controller.value.selectedIndexes.length <= 7) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ReviewHand(
                      handCards: urlSelectedCards,
                    ),
                  ));
                }
              },
            ),
        ],
      ),
      body: DragSelectGridView(
        gridController: controller,
        padding: const EdgeInsets.all(8),
        itemCount: cardList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (context, index, isSelected) => SelectableItemWidget(
          url: urlImages[index],
          isSelected: isSelected,
        ),
      ),
    );
  }
}

cardSprite(cardName, size) => Image(
    height: size,
    width: size,
    image: AssetImage('assets/images/cards/$cardName.png'));

cardImageSprite(cardName, size) => Image(
    height: size,
    width: size,
    image: AssetImage('assets/images/cardImages/$cardName.png'));
