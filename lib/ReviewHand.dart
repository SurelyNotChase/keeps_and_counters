import 'package:flutter/material.dart';
import 'Game.dart';

class ReviewHand extends StatelessWidget {
  final List<Map> handCards;

  const ReviewHand({
    Key? key,
    required this.handCards,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Review Hand'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.done),
              onPressed: () {
                
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PlayGame(
                    hand: handCards,
                  ),
                ));
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Center(
            child: Row(
              children: handCards.toList()
                  .map((handCard) => Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image(
                          image: AssetImage(
                              'assets/images/cards/${handCard["name"]}.png'),
                          height: 400,
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
      );
}
