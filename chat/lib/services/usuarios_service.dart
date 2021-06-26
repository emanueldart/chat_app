import 'package:chat/global/enviroment.dart';
import 'package:chat/models/usuarios.dart';
import 'package:chat/models/usuarios_response.dart';
import 'package:chat/services/auth_services.dart';
import 'package:http/http.dart' as http;

class UsuariosService {
  Future<List<Usuario>> getUsuarios() async {
    try {
      final resp = await http.get(
        Uri.parse('${Enviroment.apiUrl}/usuarios'),
        headers: {
          'Content-Type': 'application/json',
          'x-token': "${await AuthServices.getToken()}"
        },
      );
      //mapeo la respuesta
      final usuariosRespose = usuariosResposeFromJson(resp.body);
      return usuariosRespose.usuarios;
    } catch (e) {
      return [];
    }
  }
}
