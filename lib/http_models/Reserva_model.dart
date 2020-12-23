class ReservaModel {
  String clientId;
  String eventId;
  int option;
  int howMany;
  String desciption;

  // constructor
  Creadora(String clientId, String eventId, int option, int howMany,
      String description) {
    this.clientId = clientId;
    this.eventId = eventId;
    this.option = option;
    this.howMany = howMany;
    this.desciption = description;
  }
}
