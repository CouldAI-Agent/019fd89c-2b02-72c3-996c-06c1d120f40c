class Character {
  final String name;
  final String role;
  final String description;
  final bool isMainCharacter;
  final String imageUrl;

  const Character({
    required this.name,
    required this.role,
    this.description = '',
    this.isMainCharacter = false,
    this.imageUrl = '',
  });
}

class Family {
  final String name;
  final String houseName;
  final String description;
  final List<Character> members;
  final String houseColor;

  const Family({
    required this.name,
    required this.houseName,
    required this.description,
    required this.members,
    this.houseColor = '0xFF4A90E2',
  });
}
