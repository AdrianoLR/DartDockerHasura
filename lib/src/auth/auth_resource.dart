import 'dart:async';
import 'dart:convert';

import 'package:hasura_connect/hasura_connect.dart' hide Response, Request;
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';
import 'package:corsac_jwt/corsac_jwt.dart';

class AuthResource extends Resource {
  final builder = JWTBuilder();

  @override
  List<Route> get routes => [Route.post('/login', _login)];

  FutureOr<Response> _login(
      Request request, Injector injector, ModularArguments args) async {
    final connect = injector.get<HasuraConnect>();
    final response =
        await connect.query(_loginDocumnet, variables: args.data['input']);

    if (response.isEmpty) {
      final responseError = {'mesage': 'falha na autenticação'};
      return Response.forbidden(jsonEncode(responseError));
    }

    final usersList = response['data']['users'] as List;
    final users = usersList.first;
    final secrectKey = "akdfhoadghoaiwehfapieiehfp1i30rhapdifh1093hjfidapidhf";

    builder
      ..expiresAt = DateTime.now().add(Duration(minutes: 3))
      ..setClaim('https://hasura.io/jwt/claims', {
        'x-hasura-allowed-roles': ["editor", "user", "mod"],
        'x-hasura-default-role': users['default_role'],
        'x-hasura-user-id': '${users['id']}',
        'x-hasura-org-id': '${users['id_company']}',
      })
      ..getToken(); // returns token without signature

    var signer = JWTHmacSha256Signer(secrectKey);
    var signedToken = builder.getSignedToken(signer);

    final result = {
      'accessToken': signedToken.toString(),
      'refreshToken': 'blablabalblab212124',
      'expireIn': Duration(minutes: 3).inSeconds
    };

    return Response.ok(jsonEncode(result));
  }
}

const _loginDocumnet = r'''
query Login($email: String!, $password: String!, $id_company: Int!) {
  users(where: {email: {_eq: $email}, password: {_eq: $password}, id_company: {_eq: $id_company}}) {
    id
    id_company
    default_role
  }
}
 ''';
