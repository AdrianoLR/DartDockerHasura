import 'package:dart_backapp/src/auth/auth_resource.dart';
import 'package:hasura_connect/hasura_connect.dart' hide Response;
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

class AppModule extends Module {
  List<Bind<Object>> get binds => [
        Bind.singleton(
            (i) => HasuraConnect('http://localhost:8080/v1/graphql', headers: {
                  'x-hasura-admin-secret': 'hasura',
                }))
      ];

  List<ModularRoute> get routes => [
        Route.get('/', () => Response.ok('Tudo funcionando')),
        Route.resource('/auth', resource: AuthResource()),
      ];
}
