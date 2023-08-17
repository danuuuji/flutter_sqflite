import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:uuid/uuid.dart';

const String idStrucEdinici = '937a5809-51a2-11e7-abe3-00237da8a880';
const String apiAdress = 'sok.tomskneft.ru';
const String apiLogin = 'MobileClient';
const String apiPass = 'gA0do1ry';
const String apiKey = '86476cb1-558e-4684-a621-fujedb269968';
//const String userToken = 'ED56169797C2FC0D183356A129F94C31';
const String userToken = '';
const String url = 'https://sok.tomskneft.ru';
const String serviceName = '/MobService/hs/api/v3';

class HttpRequest {
  static String logPassBase64 =
      base64.encode(utf8.encode('$apiLogin:$apiPass'));

  static Future<String> get(String method) async {
    final response = await http.Client()
        .get(Uri.parse('$url/$serviceName/$method'), headers: {
      'usertoken': userToken,
      'ApiKey': apiKey,
      'Host': apiAdress,
      'Authorization': 'Basic $logPassBase64',
      'Content-Type': 'application/json'
    });
    return utf8.decode(response.bodyBytes);
  }

  static FutureOr<Response> post(
      String method, Map<String, String> params) async {
    const notificationId = Uuid();

    Map<String, String> body = {
      'Request_id': notificationId.v4(),
      'club_id': idStrucEdinici
    };

    for (String key in params.keys) {
      body[key] = params[key]!;
    }

    final response = await http.post(Uri.parse('$url/$serviceName/$method'),
        headers: {
          'usertoken': userToken,
          'ApiKey': apiKey,
          'Host': apiAdress,
          'Authorization': 'Basic $logPassBase64',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(body));
    return response;
  }
}
