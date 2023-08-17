import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../utils/database_helper.dart';
import '../../service/api_request.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static Future<bool> checkInDB() async {

    DBProvider dbProvider = DBProvider();
    //Database? db = await DBProvider().database;

    User? responseDB = await dbProvider.getUser(1);

    if (responseDB != null ) {
      return true;
    } else {
      return false;
    }

    dbProvider.close();
  }

  static Future<bool> auth(String phone, String password) async {
    //const bool bool_yes = false;

    phone = '7$phone';

    phone = phone.replaceAll('(', '');
    phone = phone.replaceAll(')', '');
    phone = phone.replaceAll('-', '');
    phone = phone.replaceAll(' ', '');
    var response = await HttpRequest.post(
        'auth_client', {'phone': phone, 'password': password});
    if (response.statusCode == 200) {
      var responseToBody = response.bodyBytes;
      var responseUtf8 = utf8.decode(responseToBody);
      var responseJson = json.decode(responseUtf8);


      DBProvider dbProvider = DBProvider();
      //dbProvider.open(path);
      Map<String, dynamic> mapUser = {
        columLogin: phone,
        columnPassword: password,
        columnId: 1,
        columnToken: responseJson['data']['user_token']
      };

      User user = User.fromMap(mapUser);

      dbProvider.insert(user);
      dbProvider.close();

      return true;
    } else {
      return false;
    }
  }
}
