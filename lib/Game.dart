import 'package:flutter/material.dart';
import 'constants.dart';
import 'dart:math';

// ignore: must_be_immutable
class PlayGame extends StatefulWidget {
  late List<Map> hand;
  late List<Map> opponentHand = createRandomHand();
  // late List<Map> opponentHand = opponentHandF;

  Map playCard = {};
  PlayGame({Key? key, required this.hand}) : super(key: key);
  @override
  State<PlayGame> createState() => _PlayGameState();

  List<Map> createRandomHand() {
    List<int> randoNumbers = [];
    List<Map> opponentHand = [];
    int counter = 0;
    final maxIterations = 100;
    while (randoNumbers.length < hand.length && counter < maxIterations) {
      int rando = Random().nextInt(cardData.length);
      if (!randoNumbers.contains(rando)) {
        randoNumbers.add(rando);
        opponentHand.add(cardData[rando]);
      }
      counter++;
    }
    return opponentHand;
  }
}

class _PlayGameState extends State<PlayGame> {
  bool playerTurn = true;
  String barText = 'Keeps & Counters';
  Color barColor = Colors.blue;
  bool treeantIsRooted = false;
  int ghostPossession = 0;
  // Map attackingCard = otherCards[0];
  Map defendingCard = otherCards[0];
  List<Map> playerKeep = [otherCards[0]];
  List<Map> opponentkeep = [otherCards[0]];

  void _changeTurn() {
    setState(() {
      //set turn color

      //remove Yield option
      removeMapWithName(widget.hand, -2);

      //remove placeholders
      removeMapWithName(widget.opponentHand, -1);

      playerTurn = !playerTurn;
      barColor = playerTurn ? Colors.blue : Colors.red;

      if (defendingCard['id'] == -1) {
        if ((widget.hand.any((map) => map['name'] == 'Satyr') &&
                widget.hand.length == 1) &&
            playerTurn) {
          widget.hand.clear();
        } else if ((widget.opponentHand.any((map) => map['name'] == 'Satyr') &&
                widget.opponentHand.length == 1) &&
            !playerTurn) {
          widget.opponentHand.clear();
        }
      }

      if (playerTurn) {
        bool hasContendingCard = widget.hand.any((card) =>
            card.containsKey('value') &&
            (_canCapture(card, defendingCard, widget.hand) ||
                _ties(card, defendingCard) ||
                card['name'] == 'Satyr'));
        if (!hasContendingCard && widget.hand.isNotEmpty) {
          widget.hand.add(otherCards[1]);
        }
      } else {

          _opponentPlayCard();

      }

      _gameEnd();
    });
  }

  bool _canCapture(attacker, defender, attackerHand) {
    bool canCapture = false;

    num attackerAttackValue =
        attacker['getAttack'](attacker['value'], defender);
    num defenderDefenseValue =
        defender['getDefense'](defender['value'], attacker);

    //MODIFIERS

    //Treeant's 'Root' ability
    if (treeantIsRooted && defendingCard['name'] == 'Treeant') {
      defenderDefenseValue *= 2;
    }
    //Dog's 'Pack' Ability
    if (attacker['name'] == 'Dog') {
      attackerAttackValue += (20 * attackerHand.length - 1);
    }

    //Ghost's 'Possession' Ability (Using Possessed Human)
    if (defender['name'] == 'Ghost') {
      defenderDefenseValue += ghostPossession;
    }

    //CAPTURE DETERMINED
    canCapture = attackerAttackValue > defenderDefenseValue;

    //SIDE-EFFECTS
    //Ghost's 'Possession' Ability (Possessing Captured Human)
    if (attacker['name'] == 'Ghost' && canCapture) {
      if (defender['class'] == 'human') {
        ghostPossession = defendingCard['value'];
      } else {
        ghostPossession = 0;
      }
    }

    return canCapture;
  }

  bool _ties(attacker, defender) {
    bool canTie = false;

    num attackerAttackValue =
        attacker['getAttack'](attacker['value'], defender);
    num defenderDefenseValue =
        defender['getDefense'](defender['value'], attacker);

    //Treeant's 'Downroot' Bonus
    if (treeantIsRooted && defendingCard['name'] == 'Treeant') {
      defenderDefenseValue *= 2;
    }

    //Ghost's 'Possession' Ability (Using Possessed Human)
    if (defender['name'] == 'Ghost') {
      defenderDefenseValue += ghostPossession;
    }

    canTie = attackerAttackValue == defenderDefenseValue;

    return canTie;
  }

  void _playCard(Map attackingCard, attackerHand, defenderHand, int attacker) {
    setState(() {
      //End game when one hand is empty and the field is empty
      if ((widget.hand.isEmpty || widget.opponentHand.isEmpty) &&
          defendingCard['id'] == -1) {
        //end game
        barText = 'Game Over';
        barColor = Colors.black54;
        openEndGameModal(context);
        // Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
      } else {
        //Encounter cases...
        if (attackingCard['id'] > 0) {
          //SATYR
          if (attackingCard['name'] == 'Satyr') {
            //Field must be populated for Satyr to attack
            if (defendingCard['id'] >= 0) {
              //attacking card is removed from the attacker's hand
              List<Map> smallerHand =
                  removeMapWithName(attackerHand, attackingCard['id']);
              attacker == 1
                  ? widget.hand = smallerHand
                  : widget.opponentHand = smallerHand;

              //CHARM
              attackingCard['value'] = defendingCard['value'];

              //send attacking card's back to their own keeps (no captures are made)
              if (attacker == 1) {
                // playerKeep.add(attackingCard);
                opponentkeep.add(defendingCard);
              } else {
                playerKeep.add(defendingCard);
                // opponentkeep.add(attackingCard);
              }

              //update bar text
              barText =
                  '${attackingCard['name']} charmed ${defendingCard['name']}';

              //defending card is removed and replaced with the otherCards[0] (empty field)
              defendingCard = attackingCard;

              //switch turn
              _changeTurn();
            } else {
              barText = 'No Charm target!';
            }
          } else
          //value is higher (capture)
          if (_canCapture(attackingCard, defendingCard, attackerHand)) {
            //attacking card is removed from the attacker's hand
            List<Map> smallerHand =
                removeMapWithName(attackerHand, attackingCard['id']);
            attacker == 1
                ? widget.hand = smallerHand
                : widget.opponentHand = smallerHand;

            //contribute to score of appropriate player (1 is first player)
            attacker == 1
                ? playerKeep.add(defendingCard)
                : opponentkeep.add(defendingCard);

            //update bar text
            barText = defendingCard['id'] == -1
                ? attackingCard['name']
                : '${attackingCard['name']} captures ${defendingCard['name']}';

            //see if Treeant roots;
            treeantIsRooted = (attackingCard['name'] == 'Treeant' &&
                    defendingCard['id'] == -1)
                ? true
                : false;

            //update defender for next turn
            //if the defender was a Witch, attacker goes to defender's hand
            if (defendingCard['name'] == 'Witch') {
              defenderHand.add(attackingCard);
              //placeholder
              defendingCard = otherCards[0];
            } else if (attackingCard['name'] == 'Explorer') {
              //explorer in empty field
              if (defendingCard['id'] == -1) {
                //attacker becomes new defender
                defendingCard = attackingCard;
              } else
              //explorer capturing
              {
                attackerHand.add(attackingCard);
                //placeholder
                defendingCard = otherCards[0];
              }
            } else {
              //otherwise attacker becomes new defender
              defendingCard = attackingCard;
            }
            //switch turn
            _changeTurn();
          }
          //value is equal (tie)
          else if (_ties(attackingCard, defendingCard)) {
            //attacking card is removed from the attacker's hand
            List<Map> smallerHand =
                removeMapWithName(attackerHand, attackingCard['id']);
            attacker == 1
                ? widget.hand = smallerHand
                : widget.opponentHand = smallerHand;

            //send cards back to their own keeps (no captures are made)
            if (attacker == 1) {
              playerKeep.add(attackingCard);
              opponentkeep.add(defendingCard);
            } else {
              playerKeep.add(defendingCard);
              opponentkeep.add(attackingCard);
            }

            //update bar text
            barText = '${attackingCard['name']} tied ${defendingCard['name']}';

            //defending card is removed and replaced with the otherCards[0] (empty field)
            defendingCard = otherCards[0];

            //switch turn
            _changeTurn();

            if (!playerTurn) {
              _opponentPlayCard();
            }
          }
          //value is lower (cannot contest)
          else {
            barText = '${attackingCard['name']} cannot contest';
          }
        } else
        //Yields...
        if (attackingCard['id'] == -2) {
          _yield();
          removeMapWithName(widget.hand, -2);
        }
        //remove placeholders from keeps
        if (playerKeep.length > 1) {
          removeMapWithName(playerKeep, -1);
        }
        if (opponentkeep.length > 1) {
          removeMapWithName(opponentkeep, -1);
        }
      }
    });
  }

  void _gameEnd() {
    if (((widget.hand.isEmpty || widget.opponentHand.isEmpty) &&
            defendingCard['id'] == -1) ||
        (widget.hand.isEmpty && widget.opponentHand.isEmpty)) {
      //end game
      barText = 'Game Over';
      barColor = Colors.black54;

      //remove placeholders from keeps
      removeMapWithName(playerKeep, -1);
      removeMapWithName(opponentkeep, -1);

      Future.delayed(Duration(seconds: 2), () {
        openEndGameModal(context);
      });

      // Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
    }
  }

  void _yield() {
    barText = 'Yield';
    setState(() {
      if (playerTurn) {
        opponentkeep.add(defendingCard);
      } else {
        playerKeep.add(defendingCard);
      }
    });
    defendingCard = otherCards[0];
    if (!playerTurn) {
      _opponentPlayCard();
    }
    // _changeTurn();
  }

  void _opponentPlayCard() {
    bool containsSatyr =
        widget.opponentHand.any((map) => map['name'] == 'Satyr');

    bool hasContendingCard = widget.opponentHand.any((card) =>
        card.containsKey('value') &&
        (_canCapture(card, defendingCard, widget.opponentHand) ||
            _ties(card, defendingCard) ||
            card['name'] == 'Satyr'));

    if (hasContendingCard) {
      List<Map> possiblePlays = widget.opponentHand
          .where((card) =>
              (_canCapture(card, defendingCard, widget.opponentHand) ||
                  _ties(card, defendingCard) ||
                  (card['name'] == 'Satyr') && card['id'] != -2))
          .toList();
      int randomIndex = new Random().nextInt(possiblePlays.length);

      Future.delayed(Duration(seconds: 2), () {
        _playCard(
            possiblePlays[randomIndex], widget.opponentHand, widget.hand, 0);
      });
    } else if (defendingCard['id'] != -1) {
      Future.delayed(Duration(seconds: 2), () {
        _yield();
      });
    } else {
      _gameEnd();
    }
  }

  List<Map> removeMapWithName(List<Map<dynamic, dynamic>> maps, int id) {
    for (int i = 0; i < maps.length; i++) {
      if (maps[i]['id'] == id) {
        maps.removeAt(i);
        break;
      }
    }
    return maps;
  }

  String getKeepTotal(keep) {
    String totalString = '0';
    int total = keep.fold(0, (prev, item) => prev + item['value']);

    totalString = total.toString();
    return totalString;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(barText),
        backgroundColor: barColor,
      ),
      body: WillPopScope(
        onWillPop: () async => false,
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background.jpg"),
                fit: BoxFit.fitHeight),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: widget.opponentHand
                        .toList()
                        .map((handCard) => const Padding(
                              padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                              child: Image(
                                image: AssetImage('assets/images/Back.png'),
                                height: 70,
                              ),
                            ))
                        .toList(),
                  ),
                ),
                SizedBox(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Column(
                            children: [
                              Text(
                                style: shadowText(),
                                getKeepTotal(opponentkeep),
                              ),
                              Stack(
                                children: opponentkeep
                                    .toList()
                                    .asMap()
                                    .map((index, keepCard) => MapEntry(
                                          index,
                                          GestureDetector(
                                            onTap: () {
                                              // access the current index using 'index'
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 10.0 * index, 10, 10),
                                              child: Image(
                                                image: AssetImage(
                                                    'assets/images/cards/${keepCard["name"]}.png'),
                                                height: 100,
                                              ),
                                            ),
                                          ),
                                        ))
                                    .values
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Image(
                            image: AssetImage(
                                'assets/images/cards/${defendingCard['name']}.png'),
                            height: 220,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Column(
                            children: [
                              Text(
                                  style: shadowText(),
                                  getKeepTotal(playerKeep)),
                              Stack(
                                children: playerKeep
                                    .toList()
                                    .asMap()
                                    .map((index, keepCard) => MapEntry(
                                          index,
                                          GestureDetector(
                                            onTap: () {
                                              // access the current index using 'index'
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 10.0 * index, 10, 10),
                                              child: Image(
                                                image: AssetImage(
                                                    'assets/images/cards/${keepCard["name"]}.png'),
                                                height: 100,
                                              ),
                                            ),
                                          ),
                                        ))
                                    .values
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: widget.hand
                        .toList()
                        .map((handCard) => GestureDetector(
                              onTap: () {
                                if (playerTurn) {
                                  _playCard(handCard, widget.hand,
                                      widget.opponentHand, 1);
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Image(
                                  image: AssetImage(
                                      'assets/images/cards/${handCard["name"]}.png'),
                                  height: 220,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextStyle shadowText() {
    return const TextStyle(
      color: Colors.white,
      fontSize: 18,
      shadows: [
        Shadow(
          blurRadius: 10.0,
          color: Colors.black,
          offset: Offset(0, 0),
        ),
      ],
    );
  }

  Future<dynamic> openEndGameModal(BuildContext context) {
    num playerTotal = playerKeep.fold(0, (prev, item) => prev + item['value']);
    num opponentTotal =
        opponentkeep.fold(0, (prev, item) => prev + item['value']);
    String matchResult;

    if (playerTotal != opponentTotal) {
      if (playerTotal > opponentTotal) {
        matchResult = "You won!";
      } else {
        matchResult = "You lost.";
      }
    } else {
      matchResult = "Tie!";
    }

    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              backgroundColor: Color.fromRGBO(255, 255, 255, 0.7),
              content: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Text(matchResult,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Your keep score: ${playerTotal}"),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: playerKeep
                          .toList()
                          .map((handCard) => GestureDetector(
                                onTap: () {
                                  if (playerTurn) {
                                    _playCard(handCard, widget.hand,
                                        widget.opponentHand, 1);
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Image(
                                    image: AssetImage(
                                        'assets/images/cards/${handCard["name"]}.png'),
                                    height: 150,
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Opponent keep score: ${opponentTotal}"),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: opponentkeep
                          .toList()
                          .map((handCard) => GestureDetector(
                                onTap: () {
                                  if (playerTurn) {
                                    _playCard(handCard, widget.hand,
                                        widget.opponentHand, 1);
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Image(
                                    image: AssetImage(
                                        'assets/images/cards/${handCard["name"]}.png'),
                                    height: 150,
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.popUntil(context,
                              ModalRoute.withName(Navigator.defaultRouteName));
                        },
                        child: const Text('Return')),
                  ),
                ],
              ),
            )).then((value) => Navigator.popUntil(
        context, ModalRoute.withName(Navigator.defaultRouteName)));
  }
}
