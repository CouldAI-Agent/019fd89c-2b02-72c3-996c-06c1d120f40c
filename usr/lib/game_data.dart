import 'models.dart';

const Character nannu = Character(
  name: 'Nannu',
  role: 'Protagonist',
  description: 'The main character navigating this open world.',
  isMainCharacter: true,
);

final List<Family> gameFamilies = [
  const Family(
    name: 'Sharma Family (Main)',
    houseName: 'Sharma Residence',
    description: 'The central hub of our hero.',
    houseColor: '0xFF2E7D32', // Green
    members: [
      Character(name: 'Mummy', role: 'Mother'),
      Character(name: 'Papa', role: 'Father'),
      Character(name: 'Mannu', role: 'Sibling'),
      nannu,
      Character(name: 'Babu', role: 'Youngest Sibling'),
    ],
  ),
  const Family(
    name: 'Extended Sharma Family',
    houseName: 'Mama Ji Estate',
    description: 'A bustling house full of relatives and chaos.',
    houseColor: '0xFF1565C0', // Blue
    members: [
      Character(name: 'Bade Mama ji', role: 'Elder Uncle'),
      Character(name: 'Badi Mami', role: 'Elder Aunt'),
      Character(name: 'Diwakar', role: 'Cousin'),
      Character(name: 'Simmo', role: 'Cousin'),
      Character(name: 'Jyoti', role: 'Cousin'),
      Character(name: 'Chote Mama ji', role: 'Younger Uncle'),
      Character(name: 'Noni', role: 'Cousin'),
      Character(name: 'Laddu', role: 'Youngest Cousin'),
    ],
  ),
  const Family(
    name: 'Bhature Family',
    houseName: 'Vamp Lair',
    description: 'Home of the oversized vamps plotting their next move.',
    houseColor: '0xFFC62828', // Red
    members: [
      Character(name: 'Paddo', role: 'Oversized Vamp'),
      Character(name: 'Neha', role: 'Oversized Vamp'),
      Character(name: 'Ekta', role: 'Oversized Vamp'),
    ],
  ),
];
