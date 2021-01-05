import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:safeevents/http_models/ClientInfoModel.dart';

Future<ClientInfoMod> fetchClient(int id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String stringValue = prefs.getString('cookie');
  var uri = Uri.http('10.4.41.148:8080', '/clientinfo');
  var body;
  if (id != 0) {
    body = jsonEncode({"id": id, "cookie": stringValue});
  } else {
    body = jsonEncode({"id": 0, "cookie": stringValue});
  }
  final response = await http.put(
    uri,
    body: body,
  );
  if (response.statusCode == 200) {
    return clientInfoModFromJson(response.body);
  } else {
    throw Exception('Failed to load client info');
  }
}

Future<ClientInfoMod> fetchLocalClient(int id) async {
  return clientInfoModFromJson(json.encode(testClient));
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
        "taken": 87,
        "price": 0,
        "checkInDate": "2020-11-29T11:11:36.55+01:00",
        "closureDate": "2020-11-29T11:11:36.55+01:00",
        "location":
            "Passeig Olímpic, 5-7, 08038 Barcelona, Spain--41.363371699999995;2.152593",
        "feedbacks": null,
        "services": null,
        "createdAt": "2020-12-14T17:42:24.721+01:00",
        "updatedAt": "2020-12-17T17:39:03.174+01:00",
        "image":
            "https://i.pinimg.com/originals/12/46/9c/12469c8a50bcb6e344589c43eb7db72c.jpg",
        "tipus": "Altres",
        "mesures": ""
      },
      {
        "id": 7,
        "title": "ElHectorLatino",
        "description": "Its an event for example",
        "capacity": 15000,
        "taken": 0,
        "price": 0,
        "checkInDate": "2020-11-29T11:11:36.55+01:00",
        "closureDate": "2020-11-29T11:11:36.55+01:00",
        "location": "Barcelona",
        "feedbacks": null,
        "services": null,
        "createdAt": "2020-12-17T17:28:18.051+01:00",
        "updatedAt": "2020-12-17T17:28:18.051+01:00",
        "image": "",
        "tipus": "",
        "mesures": ""
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
        "option": 1,
        "qr_code": "nYe_xRBDjyTzNL6Iq18OVK98aqOCvILIQPwPw_QDMuM=",
        "createdAt": "2020-12-14T17:43:10.248+01:00",
        "check_in": null,
        "client_id": 1
      },
      {
        "id": 2,
        "description": "testing",
        "event_id": 1,
        "assistant_id": 1,
        "option": 1,
        "qr_code": "X3262uY7nAZRaPNhFFSiXKJ5Eia1uT6GPC7iHNNwo1U=",
        "createdAt": "2020-12-14T17:43:10.255+01:00",
        "check_in": null,
        "client_id": 1
      },
      {
        "id": 3,
        "description": "testing",
        "event_id": 1,
        "assistant_id": 1,
        "option": 1,
        "qr_code": "5Gjb1XkMra2De9QJc9tcMAeeyuzkRQ8lJvxg8yF4Z_0=",
        "createdAt": "2020-12-14T17:43:10.264+01:00",
        "check_in": null,
        "client_id": 1
      },
      {
        "id": 4,
        "description": "testing",
        "event_id": 1,
        "assistant_id": 1,
        "option": 1,
        "qr_code": "kaVIXa2__XBeWFIRkuDaF11bpif6aQv06aiBPK2FaAk=",
        "createdAt": "2020-12-14T17:43:10.27+01:00",
        "check_in": null,
        "client_id": 1
      },
      {
        "id": 5,
        "description": "testing",
        "event_id": 1,
        "assistant_id": 1,
        "option": 1,
        "qr_code": "NdESgCjXuXnhc_ccjF0oX126brR54sr3-TDK8k7D7vQ=",
        "createdAt": "2020-12-14T17:43:10.276+01:00",
        "check_in": null,
        "client_id": 1
      },
      {
        "id": 6,
        "description": "testing",
        "event_id": 1,
        "assistant_id": 1,
        "option": 1,
        "qr_code": "h0DJG_5qc1E8mubqDRV_mMPGA0dyNFnZ82YaJH899js=",
        "createdAt": "2020-12-14T17:43:10.282+01:00",
        "check_in": null,
        "client_id": 1
      },
      {
        "id": 7,
        "description": "testing",
        "event_id": 1,
        "assistant_id": 1,
        "option": 1,
        "qr_code": "tMhSudoX6iaznnOcldwtxdVbnxS99UbjdhPw8XGXsjQ=",
        "createdAt": "2020-12-14T17:43:10.288+01:00",
        "check_in": null,
        "client_id": 1
      },
      {
        "id": 8,
        "description": "testing",
        "event_id": 1,
        "assistant_id": 1,
        "option": 1,
        "qr_code": "ym5dcOBF4Ikspov1RrbGS-z2mNLKgxQlBAA7mKgO4_I=",
        "createdAt": "2020-12-14T17:43:10.296+01:00",
        "check_in": null,
        "client_id": 1
      },
      {
        "id": 9,
        "description": "testing",
        "event_id": 1,
        "assistant_id": 1,
        "option": 1,
        "qr_code": "ATiMqi6HcneugNbxOLchjTShu3GEwJaRNtLjQO7eUiA=",
        "createdAt": "2020-12-14T17:43:10.301+01:00",
        "check_in": null,
        "client_id": 1
      },
      {
        "id": 10,
        "description": "testing",
        "event_id": 1,
        "assistant_id": 1,
        "option": 1,
        "qr_code": "HPg6NZPjDd-Xmv0tP8ylAW4eNaov8dzFz3OUEQseRFE=",
        "createdAt": "2020-12-14T17:43:10.308+01:00",
        "check_in": null,
        "client_id": 1
      },
      {
        "id": 11,
        "description": "testing",
        "event_id": 1,
        "assistant_id": 1,
        "option": 1,
        "qr_code": "HKCTeL_kcdd7lhmOeP1Str-TsCRXS-aJV0ILy7oQ3f8=",
        "createdAt": "2020-12-14T17:43:10.314+01:00",
        "check_in": null,
        "client_id": 1
      },
      {
        "id": 12,
        "description": "testing",
        "event_id": 1,
        "assistant_id": 1,
        "option": 1,
        "qr_code": "5ItfVmXgBxNFVZUqYisIVzWWuBg3MD9rpbOUQ-4RC8s=",
        "createdAt": "2020-12-14T17:43:10.321+01:00",
        "check_in": null,
        "client_id": 1
      },
      {
        "id": 13,
        "description": "testing",
        "event_id": 1,
        "assistant_id": 1,
        "option": 1,
        "qr_code": "OzJ8ALmvpXKu2sIi_TE4Jz6oMsu56_rxkKu-ci8Gews=",
        "createdAt": "2020-12-14T17:43:10.327+01:00",
        "check_in": null,
        "client_id": 1
      },
      {
        "id": 14,
        "description": "testing",
        "event_id": 1,
        "assistant_id": 1,
        "option": 1,
        "qr_code": "WBl6GuNhE5yglI_uOq_h_r4WDbZUWx4ROvu1FRn1fRE=",
        "createdAt": "2020-12-14T17:43:10.333+01:00",
        "check_in": null,
        "client_id": 1
      },
      {
        "id": 15,
        "description": "testing",
        "event_id": 1,
        "assistant_id": 1,
        "option": 1,
        "qr_code": "bk79I7Fpd5pEEsGIrekM4kpzQuGFq6Ye8s2vuI2QlSk=",
        "createdAt": "2020-12-14T17:43:10.339+01:00",
        "check_in": null,
        "client_id": 1
      },
      {
        "id": 16,
        "description": "testing",
        "event_id": 1,
        "assistant_id": 1,
        "option": 1,
        "qr_code": "Y2-uTjpxSAlmM63DJN0rAG6EZVNQnsbBXkkQ6gAIfCQ=",
        "createdAt": "2020-12-14T17:43:10.346+01:00",
        "check_in": null,
        "client_id": 1
      },
      {
        "id": 17,
        "description": "testing",
        "event_id": 1,
        "assistant_id": 1,
        "option": 1,
        "qr_code": "FC0SD9_HlhSAvhDmT7if6keBaEYm0UUhuc6sPWxnDp4=",
        "createdAt": "2020-12-14T17:43:10.353+01:00",
        "check_in": null,
        "client_id": 1
      },
      {
        "id": 18,
        "description": "testing",
        "event_id": 1,
        "assistant_id": 1,
        "option": 1,
        "qr_code": "Ab4KkDSbqjQdlma9n1hJ28Scc_UZrqLxd6dtaRGA7mw=",
        "createdAt": "2020-12-14T17:43:10.36+01:00",
        "check_in": null,
        "client_id": 1
      },
      {
        "id": 19,
        "description": "testing",
        "event_id": 1,
        "assistant_id": 1,
        "option": 1,
        "qr_code": "BuOTEZnwhv3rO-0l8DsGH5z_Nq_Hg9yTZF86aJ0BbvY=",
        "createdAt": "2020-12-14T17:43:10.366+01:00",
        "check_in": null,
        "client_id": 1
      },
      {
        "id": 20,
        "description": "testing",
        "event_id": 1,
        "assistant_id": 1,
        "option": 1,
        "qr_code": "m7ZIAO2ScP3lEI4TP1Pezj-7dwvbKrv5FS1Ky2FfBO0=",
        "createdAt": "2020-12-14T17:43:10.373+01:00",
        "check_in": null,
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
      "taken": 87,
      "price": 0,
      "checkInDate": "2020-11-29T11:11:36.55+01:00",
      "closureDate": "2020-11-29T11:11:36.55+01:00",
      "location":
          "Passeig Olímpic, 5-7, 08038 Barcelona, Spain--41.363371699999995;2.152593",
      "feedbacks": null,
      "services": null,
      "createdAt": "2020-12-14T17:42:24.721+01:00",
      "updatedAt": "2020-12-17T17:39:03.174+01:00",
      "image":
          "https://i.pinimg.com/originals/12/46/9c/12469c8a50bcb6e344589c43eb7db72c.jpg",
      "tipus": "Altres",
      "mesures": ""
    },
    {
      "id": 7,
      "title": "ElHectorLatino",
      "description": "Its an event for example",
      "capacity": 15000,
      "taken": 0,
      "price": 0,
      "checkInDate": "2020-11-29T11:11:36.55+01:00",
      "closureDate": "2020-11-29T11:11:36.55+01:00",
      "location": "Barcelona",
      "feedbacks": null,
      "services": null,
      "createdAt": "2020-12-17T17:28:18.051+01:00",
      "updatedAt": "2020-12-17T17:28:18.051+01:00",
      "image": "",
      "tipus": "",
      "mesures": ""
    }
  ]
};

var testClient2 = {
  "id": 2,
  "email": "alex.rodriguez.sanchez@estudiantat.upc.edu",
  "organize": {
    "id": 2,
    "organizes": [
      {
        "id": 2,
        "title": "Lakers-Celtics",
        "description": "Ganan los celtics seguro",
        "capacity": 1000,
        "taken": 0,
        "price": 500000000,
        "checkInDate": "2024-12-01T17:01:10+01:00",
        "closureDate": "2024-12-01T17:01:10+01:00",
        "location":
            "100 Legends Way, Boston, MA 02114, \r\nEstados Unidos--42.36710512725245;-71.06182061609607",
        "feedbacks": null,
        "services": null,
        "createdAt": "2020-12-14T18:26:24.506+01:00",
        "updatedAt": "2020-12-14T18:26:24.506+01:00",
        "image":
            "https://upload.wikimedia.org/wikipedia/commons/thumb/5/55/Celtics_game_versus_the_Timberwolves%2C_February%2C_1_2009.jpg/300px-Celtics_game_versus_the_Timberwolves%2C_February%2C_1_2009.jpg",
        "tipus": "Esports",
        "mesures": ""
      }
    ]
  },
  "assist": null,
  "favs": null
};
