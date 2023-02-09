final List<Map<String, dynamic>> cardData = [
  {
    'name': 'Chimera',
    'value': 340,
    'class': 'beast',
    'description':
        'The most valuable card in the game, along with the highest base stats. Can only be captured by the Slayer.',
    'flavor':
        'The Chimera is the most fearsome creature known... as of yet. Only Slayers and other Chimeras have tried to kill it. Trying to control it is likely even more dangerous.',
    'id': 1,
    'getAttack': (value, opponent) => value,
    'getDefense': (value, opponent) => value
  },
  {
    'name': 'Dragon',
    'value': 310,
    'class': 'beast',
    'description': 'Can only be captured by the Chimera and the Slayer.',
    'flavor':
        'A prideful, intelligent, and terrifying beast. Only a select few have been able to earn its respect.',
    'id': 2,
    'getAttack': (value, opponent) => value,
    'getDefense': (value, opponent) => value
  },
  {
    'name': 'Vampire',
    'value': 300,
    'class': 'undead',
    'description': 'Immortal: Cannot attack an undead defender.',
    'flavor':
        'Gifted with wisdom and strength but cursed with a cold immortality, the Vampire are keen to prevail against many foes, but are doomed to spend eternity in dreadful loneliness.',
    'id': 3,
    'getAttack': (value, opponent) => opponent['class'] == 'undead' ? 0 : value,
    'getDefense': (value, opponent) => value
  },
  {
    'name': 'Yeti',
    'value': 220,
    'class': 'beast',
    'description': 'The strongest beast that cannot be captured by the Slayer.',
    'flavor':
        'With the strength of a bear an the dexterity of a gorilla, the Yeti seems to enjoy reeking havoc in mountain villiages when it occasionally comes down from its mountain peak.',
    'id': 4,
    'getAttack': (value, opponent) => value,
    'getDefense': (value, opponent) => value
  },
  {
    'name': 'Lich',
    'value': 190,
    'class': 'undead',
    'description': 'The second-strongest undead contender.',
    'flavor':
        'The Lich wield unknown, dark, mysterious mystic arts in such a way that it almost seems that they share many of the intelligence and qualities of men, except for the heart; which they surely lack.',
    'id': 5,
    'getAttack': (value, opponent) => value,
    'getDefense': (value, opponent) => value
  },
  {
    'name': 'Witch',
    'value': 180,
    'class': 'magical',
    'description':
        'Hex: The player that captures the Witch takes her to their keep, the card they used to do so goes to the Witch-player\'s hand, and turn continues.',
    'flavor':
        "She always seems like she knows what's going to happen next. You can never be sure that you've bested her.",
    'id': 6,
    'getAttack': (value, opponent) => value,
    'getDefense': (value, opponent) => value
  },
  {
    'name': 'Lion',
    'value': 170,
    'class': 'beast',
    'description': 'Pounce: Lion\'s attack is raised by 150',
    'flavor':
        "A powerful beast. Easy enough to kill with enough preparation, but woe to those who it finds first.",
    'id': 7,
    'getAttack': (value, opponent) => value + 100,
    'getDefense': (value, opponent) => value
  },
  {
    'name': 'Guardian',
    'value': 150,
    'class': 'magical',
    'description': 'Warden: Guardian\'s defense is raised by 200',
    'flavor':
        'There seems to be a mystical force that amalgamates into a embodiment of a united will in the defense of the forest\'s life.',
    'id': 8,
    'getAttack': (value, opponent) => value,
    'getDefense': (value, opponent) => value + 200
  },
  {
    'name': 'Treeant',
    'value': 140,
    'class': 'magical',
    'description':
        'Downroot: When played on an empty field, its defense doubles.',
    'flavor':
        'Docile but strong creatures that are impossible to move when they take root in the forest.',
    'id': 9,
    'getAttack': (value, opponent) => value,
    'getDefense': (value, opponent) => opponent['id'] == -1 ? value * 2 : value
  },
  {
    'name': 'Druid',
    'value': 130,
    'class': 'magical',
    'description': 'Quell: Druid\'s defense raised by 200 against beasts.',
    'flavor':
        'It understands the will of the forest and easily subdues beasts that men would not dare to approach.',
    'id': 10,
    'getAttack': (value, opponent) => value,
    'getDefense': (value, opponent) =>
        opponent['class'] == 'beast' ? value + 200 : value,
  },
  {
    'name': 'Ghost',
    'value': 120,
    'class': 'undead',
    'description':
        'Possession: After capturing a human, Ghost\'s defense is then raised by that human\'s value.',
    'flavor': 'Things aren\'t always who they seem.',
    'id': 11,
    'getAttack': (value, opponent) => value,
    'getDefense': (value, opponent) => value
  },
  {
    'name': 'Hunter',
    'value': 110,
    'class': 'human',
    'description': 'Sure-Shot: Hunter\'s attack is 290 against beasts.',
    'flavor':
        'A bow, some arrows, and a lot of practice. It pays off, sometimes with your life.',
    'id': 12,
    'getAttack': (value, opponent) =>
        opponent['class'] == 'beast' ? value + 180 : value,
    'getDefense': (value, opponent) => value
  },
  {
    'name': 'Explorer',
    'value': 100,
    'class': 'human',
    'description':
        'Map: After Explorer captures, it returns to it\'s player\'s hand and turn continues.',
    'flavor':
        'Knowing where you\'re going isn\'t as important as knowing where you\'ve been.',
    'id': 13,
    'getAttack': (value, opponent) => value,
    'getDefense': (value, opponent) => value
  },
  {
    'name': 'Ghoul',
    'value': 90,
    'class': 'undead',
    'description': 'Captured by Priest.',
    'flavor':
        'Ghouls feast on fresh remains of dead men. Quite cowardly on their own; but as their numbers increase, their fear of the light diminishes.',
    'id': 14,
    'getAttack': (value, opponent) => value,
    'getDefense': (value, opponent) => value
  },
  {
    'name': 'Dwarf',
    'value': 80,
    'class': 'human',
    'description': 'Shield: Cannot be captured, forces the opponent to yield.',
    'flavor':
        'The finest armor in the land is forged by the Dwarves; and what more, they don\'t need half as much material!',
    'id': 15,
    'getAttack': (value, opponent) => value,
    'getDefense': (value, opponent) => 9999
  },
  {
    'name': 'Slayer',
    'value': 70,
    'class': 'human',
    'description':
        'Stealth: Slayer may capture beasts whose value is greater than 280.',
    'flavor':
        'Some slayers train their entire lives just to go on one hunt. Not that that was their plan.... ',
    'id': 16,
    'getAttack': (value, opponent) =>
        (opponent['class'] == 'beast' && opponent['value'] > 280)
            ? opponent['value'] + 10
            : value,
    'getDefense': (value, opponent) => value
  },
  {
    'name': 'Priest',
    'value': 60,
    'class': 'human',
    'description': 'Smite: Captures all undead.',
    'flavor':
        'What is done in the dark will be brought to the light. Judgment awaits us all.',
    'id': 17,
    'getAttack': (value, opponent) =>
        (opponent['class'] == 'undead') ? opponent['value'] + 10 : value,
    'getDefense': (value, opponent) => value
  },
  {
    'name': 'Alchemist',
    'value': 50,
    'class': 'human',
    'description': 'Poison: Captures all humans.',
    'flavor':
        'Careful study of chemicals reveals how truly fragile life really is.',
    'id': 18,
    'getAttack': (value, opponent) =>
        (opponent['class'] == 'human') ? 999 : value,
    'getDefense': (value, opponent) => value
  },
  {
    'name': 'Monkey',
    'value': 40,
    'class': 'beast',
    'description':
        'Nimble: Cannot be captured by humans. (Including the hunter)',
    'flavor':
        'If you haven\'t been able to find your keys for the fourth time this week and all of your fruit is disapearring quickly, it may have been the Monkey.',
    'id': 19,
    'getAttack': (value, opponent) => value,
    'getDefense': (value, opponent) =>
        (opponent['class'] == 'human') ? 999 : value,
  },
  {
    'name': 'Dog',
    'value': 30,
    'class': 'human',
    'description':
        'Pack: Dog\'s attack value increases by 20 for each card remaining in its player\'s hand.',
    'flavor':
        'The strength of the pack is the wolf, and the strength of the wolf is the pack. ',
    'id': 20,
    'getAttack': (value, opponent) => value,
    'getDefense': (value, opponent) => value
  },
  {
    'name': 'Skeleton',
    'value': 20,
    'class': 'undead',
    'description': 'Lesser undead.',
    'flavor': 'A house of cards with a sword.',
    'id': 21,
    'getAttack': (value, opponent) => value,
    'getDefense': (value, opponent) => value
  },
  {
    'name': 'Gnome',
    'value': 10,
    'class': 'magical',
    'description': 'Lesser magical creature.',
    'flavor':
        'Not much can be said about this peculiar and tiny species. They are very evasive and hard to study. One thing\'s for certain, you always find them where you don\'t want to.',
    'id': 22,
    'getAttack': (value, opponent) => value,
    'getDefense': (value, opponent) => value
  },
  {
    'name': 'Gargoyle',
    'value': 1,
    'class': 'undead',
    'description': 'Transform: Gargoyle\'s attack is raised by 150',
    'flavor':
        'Some don\'t even believe that they are sentient, but those who have been struck by them dont often live to see them turn back into their stone form either.',
    'id': 23,
    'getAttack': (value, opponent) => value + 150,
    'getDefense': (value, opponent) => value
  },
  {
    'name': 'Satyr',
    'value': 0,
    'class': 'magical',
    'description':
        'Charm: When a Satyr attacks, it always ties but remains in the field. It cannot be played as your last card. When scoring, it takes the value of the contender it tied with.',
    'flavor':
        'It plays a sweet and soothing tune that seems to move the hearts of all who hear it away from whatever they were doing before.',
    'id': 24,
    'getAttack': (value, opponent) => value,
    'getDefense': (value, opponent) => value
  },
];

final otherCards = [
  {
    'name': 'Placeholder',
    'value': 0,
    'class': '[class name]',
    'description': '[description]',
    'id': -1,
    'getAttack': (value, opponent) => 0,
    'getDefense': (value, opponent) => 0
  },
  {
    'name': 'Yield',
    'value': 0,
    'class': '[class name]',
    'description': '[description]',
    'id': -2,
    'getAttack': (value, opponent) => 0,
    'getDefense': (value, opponent) => 0
  }
];

final List<Map> opponentHandA = [
  cardData[0], //Chimera
  cardData[1], //Dragon
  cardData[2], //Vampire
  cardData[3], //Yeti
  cardData[4], //Lich
];

final List<Map> opponentHandB = [
  cardData[5], //Witch
  cardData[6], //Lion
  cardData[7], //Guardian
  cardData[8], //Treeant
  cardData[9], //Druid
];

final List<Map> opponentHandC = [
  cardData[10], //Ghost
  cardData[11], //Hunter
  cardData[12], //Explorer
  cardData[13], //Ghoul
  cardData[14], //Dwarf
];

final List<Map> opponentHandD = [
  cardData[15], //Slayer
  cardData[16], //Priest
  cardData[17], //Alchemist
  cardData[18], //Monkey
  cardData[19], //Dog
];

final List<Map> opponentHandE = [
  cardData[20], //Skeleton
  cardData[21], //Gnome
  cardData[22], //Gargoyle
  cardData[23], //Satyr
  cardData[0], //Chimera
];

final List<Map> opponentHandF = [
  // cardData[23], //Satyr
  // cardData[21], //Gnome

  // cardData[23], //Satyr
  // // cardData[5], //Witch
  cardData[12], //Explorer
  cardData[12], //Explorer
  // // cardData[8], //Treeant
  // cardData[10], //Ghost
];
