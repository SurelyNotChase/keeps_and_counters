import 'package:flutter/material.dart';
import 'constants.dart';
import 'ReferenceTab.dart';

Widget scores() {
  return const Align(
    alignment: Alignment.center,
    child: SingleChildScrollView(
      child: Text('Captures'),
    ),
  );
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
                border: Border.all(width: 5, color: Color(0x1F1F1F)),
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
            child: Container(
              width: 100,
              height: 200,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  '${card['name']}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: "FrizQuadrata",
                    color: Color(0x1F1F1F),
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
          const Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Text('Card Info',
                  style: TextStyle(
                    color: Colors.white,
                  )),
            ),
          ),
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Container(
                width: 250,
                height: 250,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(width: 5, color: Color(0x1F1F1F)),
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/cardImages/${card['name']}.png'),
                    scale: 1.5,
                    alignment: Alignment.bottomCenter,
                    fit: BoxFit.none,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 250,
            height: 130,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(width: 5, color: Color(0x1F1F1F)),
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: Text(
                '${card['name']} (${card['class']})\n Value: ${card['value']} \n'
                '${card['description']}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: "RetroComputer",
                  color: Color(0x1F1F1F),
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Close",
                    style: TextStyle(
                      fontFamily: "FrizQuadrata",
                      color: Color(0x1F1F1F),
                      fontSize: 16,
                    ),
                  )),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
        ],
      ),
      backgroundColor: const Color(0xFF686868),
    ),
  );
}
