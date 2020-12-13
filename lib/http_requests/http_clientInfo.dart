import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:safeevents/http_models/ClientInfoModel.dart';

Future<ClientInfoMod> fetchClient(int id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String stringValue = prefs.getString('cookie');
  var uri = Uri.http('10.4.41.148:9090', '/clientInfo/');
  var body;
  if (id != 0) {
    body = {"id": id, "cookie": stringValue};
  } else {
    body = {"id": 0, "cookie": stringValue};
  }
  final response = await http.put(
    uri,
    body: body,
  );
  if (response.statusCode == 200) {
    return clientInfoModFromJson(response.body);
  } else {
    throw Exception('Failed to load album');
  }
}

Future<ClientInfoMod> fetchLocalClient(int id) async {
  return clientInfoModFromJson(json.encode(testClient2));
}

var testClient = {
  "id": 1,
  "email": "testing@gmail.com",
  "organize": {
    "id": 1,
    "organizes": [
      {
        "id": 1,
        "title": "EventExample - Demo",
        "description": "Its an event for example",
        "capacity": 15000,
        "taken": 35,
        "price": 0,
        "checkInDate": "2020-11-29T11:11:36.55+01:00",
        "closureDate": "2020-11-29T11:11:36.55+01:00",
        "location": "Barcelona",
        "feedbacks": null,
        "services": null,
        "createdAt": "2020-12-09T16:21:26.799+01:00",
        "updatedAt": "2020-12-09T17:42:21.627+01:00",
        "image": "",
        "tipus": ""
      }
    ]
  },
  "assists": {
    "id": 1,
    "purchased": [
      {
        "id": 1,
        "description": "testing",
        "event_id": 1,
        "assistant_id": 1,
        "option": 0,
        "qr_code": null,
        "createdAt": "2020-12-09T16:21:45.085+01:00",
        "client_id": 1
      },
      {
        "id": 2,
        "description": "testing",
        "event_id": 1,
        "assistant_id": 1,
        "option": 0,
        "qr_code": null,
        "createdAt": "2020-12-09T16:21:45.095+01:00",
        "client_id": 1
      },
      {
        "id": 3,
        "description": "testing",
        "event_id": 1,
        "assistant_id": 1,
        "option": 0,
        "qr_code": null,
        "createdAt": "2020-12-09T16:21:45.106+01:00",
        "client_id": 1
      },
      {
        "id": 4,
        "description": "testing",
        "event_id": 1,
        "assistant_id": 1,
        "option": 0,
        "qr_code": null,
        "createdAt": "2020-12-09T16:21:45.147+01:00",
        "client_id": 1
      },
      {
        "id": 5,
        "description": "testing",
        "event_id": 1,
        "assistant_id": 1,
        "option": 0,
        "qr_code": null,
        "createdAt": "2020-12-09T16:21:45.155+01:00",
        "client_id": 1
      },
      {
        "id": 6,
        "description": "testing",
        "event_id": 1,
        "assistant_id": 1,
        "option": 0,
        "qr_code": null,
        "createdAt": "2020-12-09T16:21:45.162+01:00",
        "client_id": 1
      },
      {
        "id": 7,
        "description": "testing",
        "event_id": 1,
        "assistant_id": 1,
        "option": 0,
        "qr_code": null,
        "createdAt": "2020-12-09T16:21:45.169+01:00",
        "client_id": 1
      },
      {
        "id": 8,
        "description": "testing",
        "event_id": 1,
        "assistant_id": 1,
        "option": 0,
        "qr_code": null,
        "createdAt": "2020-12-09T16:21:45.181+01:00",
        "client_id": 1
      },
      {
        "id": 9,
        "description": "testing",
        "event_id": 1,
        "assistant_id": 1,
        "option": 0,
        "qr_code": null,
        "createdAt": "2020-12-09T16:21:45.189+01:00",
        "client_id": 1
      },
      {
        "id": 10,
        "description": "testing",
        "event_id": 1,
        "assistant_id": 1,
        "option": 0,
        "qr_code": null,
        "createdAt": "2020-12-09T16:21:45.202+01:00",
        "client_id": 1
      },
      {
        "id": 11,
        "description": "testing",
        "event_id": 1,
        "assistant_id": 1,
        "option": 1,
        "qr_code": "C9K3ugBK13xV0hn6Gr9YkBlIb-oC1Z9dBv9QUcJCnhw=",
        "createdAt": "2020-12-09T16:21:50.569+01:00",
        "client_id": 1
      },
      {
        "id": 12,
        "description": "testing",
        "event_id": 1,
        "assistant_id": 1,
        "option": 1,
        "qr_code": "OeHFV94-RA2LjrnDVIihqJjuTMKzFlgPyZgNn_pzx0I=",
        "createdAt": "2020-12-09T16:21:50.579+01:00",
        "client_id": 1
      },
      {
        "id": 13,
        "description": "testing",
        "event_id": 1,
        "assistant_id": 1,
        "option": 1,
        "qr_code": "1IEpp6Y-vVsgv0_NcfR36lN6T-Q-EPrB5DI8q4XpK7Y=",
        "createdAt": "2020-12-09T16:21:50.587+01:00",
        "client_id": 1
      },
      {
        "id": 14,
        "description": "testing",
        "event_id": 1,
        "assistant_id": 1,
        "option": 1,
        "qr_code": "5KOUBPHGVqL7b2aFj8Iz09FtSVqUfhOc4IzN-GAmKnw=",
        "createdAt": "2020-12-09T16:21:50.594+01:00",
        "client_id": 1
      },
      {
        "id": 15,
        "description": "testing",
        "event_id": 1,
        "assistant_id": 1,
        "option": 1,
        "qr_code": "8Mb8jPc2ziPyU-aGm_HfY9Ao3A1CgPH28GK6VjbIPl0=",
        "createdAt": "2020-12-09T16:21:50.602+01:00",
        "client_id": 1
      },
      {
        "id": 16,
        "description": "testing",
        "event_id": 1,
        "assistant_id": 1,
        "option": 1,
        "qr_code": "O3sAmKwgiKGC5PsMuCIkcOrtrv-VrxQ19Or9Nzjc6b4=",
        "createdAt": "2020-12-09T16:21:50.61+01:00",
        "client_id": 1
      },
      {
        "id": 17,
        "description": "testing",
        "event_id": 1,
        "assistant_id": 1,
        "option": 1,
        "qr_code": "okWBxWbkXQxL2LfzhTElxGorF66sKTRe_a4MOFap-tQ=",
        "createdAt": "2020-12-09T16:21:50.618+01:00",
        "client_id": 1
      },
      {
        "id": 18,
        "description": "testing",
        "event_id": 1,
        "assistant_id": 1,
        "option": 1,
        "qr_code": "3y-GUwsIdtuEOjrYfO0vaZnuwFlUSseNlMRvWl7KiDw=",
        "createdAt": "2020-12-09T16:21:50.626+01:00",
        "client_id": 1
      },
      {
        "id": 19,
        "description": "testing",
        "event_id": 1,
        "assistant_id": 1,
        "option": 1,
        "qr_code": "6jeFx9GudUofwCe7-XBwxX61qHjPe7Ij6aO6MwxPy48=",
        "createdAt": "2020-12-09T16:21:50.634+01:00",
        "client_id": 1
      },
      {
        "id": 20,
        "description": "testing",
        "event_id": 1,
        "assistant_id": 1,
        "option": 1,
        "qr_code": "Wgo3GhMcOMONJO61G89S2RjxmH2vK9J1osW9iGEm5fY=",
        "createdAt": "2020-12-09T16:21:50.642+01:00",
        "client_id": 1
      },
      {
        "id": 21,
        "description": "testing",
        "event_id": 1,
        "assistant_id": 1,
        "option": 0,
        "qr_code": null,
        "createdAt": "2020-12-09T16:22:37.741+01:00",
        "client_id": 1
      },
      {
        "id": 22,
        "description": "testing",
        "event_id": 1,
        "assistant_id": 1,
        "option": 0,
        "qr_code": null,
        "createdAt": "2020-12-09T16:22:37.754+01:00",
        "client_id": 1
      },
      {
        "id": 23,
        "description": "testing",
        "event_id": 1,
        "assistant_id": 1,
        "option": 0,
        "qr_code": null,
        "createdAt": "2020-12-09T16:22:37.772+01:00",
        "client_id": 1
      },
      {
        "id": 24,
        "description": "testing",
        "event_id": 1,
        "assistant_id": 1,
        "option": 0,
        "qr_code": null,
        "createdAt": "2020-12-09T16:22:37.784+01:00",
        "client_id": 1
      },
      {
        "id": 25,
        "description": "testing",
        "event_id": 1,
        "assistant_id": 1,
        "option": 0,
        "qr_code": null,
        "createdAt": "2020-12-09T16:22:37.796+01:00",
        "client_id": 1
      }
    ]
  },
  "favs": [
    {
      "id": 1,
      "title": "EventExample - Demo",
      "description": "Its an event for example",
      "capacity": 15000,
      "taken": 35,
      "price": 0,
      "checkInDate": "2020-11-29T11:11:36.55+01:00",
      "closureDate": "2020-11-29T11:11:36.55+01:00",
      "location": "Barcelona",
      "feedbacks": null,
      "services": null,
      "createdAt": "2020-12-09T16:21:26.799+01:00",
      "updatedAt": "2020-12-09T17:42:21.627+01:00",
      "image": "",
      "tipus": ""
    }
  ]
};

var testClient2 = {
  "id": 1,
  "email": "testing@gmail.com",
  "organizer": {
    "id": 1,
    "organizes": [
      {
        "cookie": "",
        "id": 0,
        "title": "EventExample - Demo",
        "description": "Its an event for example",
        "capacity": 15000,
        "organizers": "",
        "checkInDate": "2020-11-29T11:11:36.55+01:00",
        "closureDate": "2020-11-29T11:11:36.55+01:00",
        "price": 0,
        "location": "Barcelona",
        "services": null,
        "image": "",
        "tipus": "",
        "Faved": false,
        "Taken": 35
      },
      {
        "cookie": "",
        "id": 0,
        "title": "Kiko Rivera on Tour",
        "description": "A quemar el Palau",
        "capacity": 10,
        "organizers": "",
        "checkInDate": "2024-12-01T18:01:10+01:00",
        "closureDate": "2024-12-01T18:01:10+01:00",
        "price": 5000,
        "location": "Palau San Jorge",
        "services": null,
        "image":
            "https://t0.gstatic.com/images?q=tbn:ANd9GcRr7G1QfG8LzmZ8dSJ22t3x51JuPf5JvPvV0DVMjwljCN1CQyMM_ytwSBboIUd6",
        "tipus": "",
        "Faved": false,
        "Taken": 0
      }
    ]
  }
};
