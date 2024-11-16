class User {
  final int id;
  final String name;
  final String imageUrl;
  final bool isOnline;

  User({
   required this.id,
   required this.name,
   required this.imageUrl,
   required this.isOnline,
  });
}

final User currentUser = User(
  id: 0,
  name: 'Zaid sad',
  imageUrl: 'assets/images/clinic.jpg',
  isOnline: true,
);

// USERS
final User ironMan = User(
  id: 1,
  name: 'diaa aqr',
  imageUrl: 'assets/images/doctor.jpg',
  isOnline: true,
);
final User captainAmerica = User(
  id: 2,
  name: 'ameer ahmad',
  imageUrl: 'assets/images/intro1.jpeg',
  isOnline: true,
);
final User hulk = User(
  id: 3,
  name: 'ziad',
  imageUrl: 'assets/images/patient.jpg',
  isOnline: false,
);
final User scarletWitch = User(
  id: 4,
  name: 'ahmad',
  imageUrl: 'assets/images/clinic.jpg',
  isOnline: false,
);
final User spiderMan = User(
  id: 5,
  name: 'ali',
  imageUrl: 'assets/images/doctor.jpg',
  isOnline: true,
);
final User blackWindow = User(
  id: 6,
  name: 'mira',
  imageUrl: 'assets/images/patient.jpg',
  isOnline: false,
);
final User thor = User(
  id: 7,
  name: 'masa',
  imageUrl: 'assets/images/intro1.jpeg',
  isOnline: false,
);
final User captainMarvel = User(
  id: 8,
  name: 'ata',
  imageUrl: 'assets/images/doctor.jpg',
  isOnline: false,
);
final User ahmadiyad= User(
  id: 9,
  name: 'ahmad iyad',
  imageUrl: 'assets/images/doctor.jpg',
  isOnline: false,
);