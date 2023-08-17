import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

import 'bloc/auth_cubit.dart';

class AuthorizationPage extends StatelessWidget {
  AuthorizationPage({super.key});

  final _sizeTextBlack = const TextStyle(fontSize: 20.0, color: Colors.black);
  final _sizeTextWhite = const TextStyle(fontSize: 20.0, color: Colors.white);

  final TextEditingController phone = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Авторизация'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 200.0,
            child: TextFormField(
              controller: phone,
              decoration: const InputDecoration(
                  labelText: "Телефон", border: OutlineInputBorder()),
              keyboardType: TextInputType.phone,
              style: _sizeTextBlack,
              inputFormatters: [MaskedInputFormatter('(###) ###-##-##')],
            ),
          ),
          Container(
            width: 200.0,
            padding: const EdgeInsets.only(top: 10.0),
            child: TextFormField(
              controller: password,
              decoration: const InputDecoration(
                  labelText: "Пароль", border: OutlineInputBorder()),
              obscureText: true,
              style: _sizeTextBlack,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: MaterialButton(
              color: Colors.blue,
              height: 50.0,
              minWidth: 150.0,
              onPressed: () async {
                /*if (await AuthCubit.auth(phone.text, password.text)) {
                  print('успех!');
                }*/
                if (await AuthCubit.checkInDB()){
                  print('Уже создан юзер');
                } else {
                  await AuthCubit.auth(phone.text, password.text);
                }
              },
              child: Text(
                "Авторизоваться",
                style: _sizeTextWhite,
              ),
            ),
          )
        ],
      )),
    );
  }
}
