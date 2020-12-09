class Client {
  final String clientname;
  final String email;
  final bool verified;
  final events;

  Client({this.clientname, this.email, this.verified, this.events});

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      clientname: json['username'],
      email: json['email'],
      verified: json['verified'] == 'true',
      events: json['events'],
    );
  }
}
