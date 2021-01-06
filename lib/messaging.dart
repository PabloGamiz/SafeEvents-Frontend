import 'dart:convert';

import 'package:http/http.dart';
import 'package:meta/meta.dart';

class Messaging {
  static final Client client = Client();

  static const String serverKey =
      "AAAAIcIoa_E:APA91bH-BNxc6NKcBPFhy3_GV-6z8dbnBYbqRenQ8qFBbD9qJpJ_VpfoigT3j2eFw-peGdSq6pQFJCKOT8VXrRzGFWBqSEa9kcAwECheBFUOI8s8FFGJeBTILHyCqnGBc8XQjTkammfE";

  static Future<Response> sendToTopic(
          {@required String title,
          @required String body,
          @required String topic}) =>
      sendTo(title: title, body: body, token: '/topic/$topic');

  static Future<Response> sendTo({
    @required String title,
    @required String body,
    @required String token,
  }) =>
      client.post('https://fcm.googleapis.com/fcm/send',
          body: json.encode(
            <String, dynamic>{
              'notification': <String, dynamic>{'body': body, 'title': title},
              'priority': 'high',
              'data': <String, dynamic>{
                'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                'id': '1',
                'status': 'done'
              },
              'to': token,
            },
          ),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'key=$serverKey',
          });
}
