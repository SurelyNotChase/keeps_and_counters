import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class RulesTab extends StatefulWidget {
  const RulesTab({super.key});

  @override
  State<RulesTab> createState() => _RulesTabState();
}

class _RulesTabState extends State<RulesTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/cardBack.png"),
                  opacity: 0.5,
                  fit: BoxFit.contain),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: RichText(
                    text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: const <TextSpan>[
                      TextSpan(
                          text: "Gameplay\n\n",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      TextSpan(
                          text:
                              "The game is played with a deck of 24 unique cards, with values ranging from 0 to 340.\n\n"),
                      TextSpan(
                          text:
                              "Players pick 5 of these cards to form their deck before the game starts.\n\n"),
                      TextSpan(
                          text: "The game starts with an empty field.\n\n"),
                      TextSpan(
                          text:
                              "On each turn, a player may play a card from their hand onto the field. The card must have a higher attack than the card currently on the field to capture it.\n\n"),
                      TextSpan(
                          text:
                              "If the attack value of a card is equal to the defense value of the card in the field, it can result in a tie. When a tie occurs, both players take their own cards into their keep.\n\n"),
                      TextSpan(
                          text:
                              "If a player has no valid options to contest the card in the field, they must 'yield' their turn. When a player yields, the card in the field goes into their opponent's keep and they then may play a card from their hand onto the empty field.\n\n"),
                      TextSpan(
                          text:
                              "In the end of the game, the player with the higher point total of cards in their keep wins.\n\n"),
                      TextSpan(
                          text: "\nCard Values\n\n",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      TextSpan(
                          text:
                              "Every card has a 'value' and that value by default is both its attack and defense. Some cards have unique abilities that increase their attack or defense values under certain circumstances.\n\n"),
                      TextSpan(
                          text:
                              "Each card also has a 'class'. There are 4 class types; human, beast, magical, and undead. Some cards abilities are contingent upon classes of other cards.\n\n"),
                      TextSpan(
                          text:
                              "For example: The card, 'Lion' has a value of 170. Its attack and defense value would be 170, but it has an ability called 'Pounce' which increases its attack, so it can capture cards valued up to 270. However, lion can be captured by cards whose attack value is above 170.\n\n"),
                      TextSpan(
                          text:
                              "In the end of the game, when scoring is counted, only the original card values are used (except for the Satyr), not the attack or defense values.\n\n"),
                      TextSpan(
                          text:
                              "Card values range from 0 to 340 in this version of the game.\n\n"),
                      TextSpan(
                          text: "\nGame End\n\n",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                              TextSpan(
                          text:
                              "The game ends when either player plays their last card onto the field.\n\n"),
                    ])),
              ),
            )));
  }
}
