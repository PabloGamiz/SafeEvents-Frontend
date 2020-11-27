class User {
  final int id;
  final String name;
  final bool isOnline;

  User({
    this.id,
    this.name,
    this.isOnline,
  });
}

// YOU - current user
final User currentUser = User(
  id: 0,
  name: 'Nick Fury',
  isOnline: true,
);

// USERS
final User ironMan = User(
  id: 1,
  name: 'Iron Man',
  isOnline: true,
);
final User captainAmerica = User(
  id: 2,
  name: 'Captain America',
  isOnline: true,
);
final User hulk = User(
  id: 3,
  name: 'Hulk',
  isOnline: false,
);
final User scarletWitch = User(
  id: 4,
  name: 'Scarlet Witch',
  isOnline: false,
);
final User spiderMan = User(
  id: 5,
  name: 'Spider Man',
  isOnline: true,
);
final User blackWindow = User(
  id: 6,
  name: 'Black Widow',
  isOnline: false,
);
final User thor = User(
  id: 7,
  name: 'Thor',
  isOnline: false,
);
final User captainMarvel = User(
  id: 8,
  name: 'Captain Marvel',
  isOnline: false,
);