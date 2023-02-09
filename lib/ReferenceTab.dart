// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'constants.dart';

class ReferenceTab extends StatefulWidget {
  const ReferenceTab({super.key});

  @override
  State<ReferenceTab> createState() => _ReferencePageState();
}

class _ReferencePageState extends State<ReferenceTab> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
    body: Align(
      alignment: Alignment.center,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/cardBack.png"),
              opacity: 0.5,
              fit: BoxFit.contain),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: cardSummary(),
          ),
        ),
      ),
    ),
  );
  }
}



List<Widget> cardSummary() {
  List<Widget> cardWidgetList = [];
  List cards = cardData as List;
  for (var i = 0; i < cards.length; i++) {
    cardWidgetList.add(ItemCard(cards[i]));
  }

  return cardWidgetList;
}

class ItemCard extends StatelessWidget {
  final Map card;
  const ItemCard(this.card);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          child: GestureDetector(
            onTap: () => openCardModal(context, card),
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(width: 5, color: Colors.black),
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/cardImages/${card['name']}.png'),
                  scale: 2.5,
                  alignment: Alignment.bottomCenter,
                  fit: BoxFit.none,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: SizedBox(
              width: 100,
              height: 200,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  '${card['name']}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: "FrizQuadrata",
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Future<dynamic> openCardModal(BuildContext context, card) {
  return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            content: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text(card['name'],
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                      )),
                ),
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Image(
                      image: AssetImage(
                          './assets/images/cards/${card['name']}.png'),
                    ),
                  ),
                ),
                Container(
                  width: 250,
                  height: 110,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(width: 2, color: Colors.black),
                    color: Colors.white,
                  ),
                  child: Scrollbar(
                    thumbVisibility: true, //always show scrollbar
                    thickness: 10, //width of scrollbar
                    radius: Radius.circular(10),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            card['description'],
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontFamily: "RetroComputer",
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              card['flavor'],
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ));
}
