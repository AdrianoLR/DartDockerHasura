import 'package:dart_backapp/src/app_module.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_modular/shelf_modular.dart';

void main(List<String> arguments) async {
  var server = await io.serve(Modular(module: AppModule()), '0.0.0.0', 4000);
  print('Server online: http://localhost:4000');
}
