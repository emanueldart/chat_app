import 'package:chat/global/enviroment.dart';
import 'package:chat/models/mensajes_response.dart';
import 'package:chat/models/usuarios.dart';
import 'package:chat/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatService with ChangeNotifier {
  late Usuario usuarioPara;

  Future<List<Mensaje>> getChat(String usuarioID) async {
    final resp = await http
        .get(Uri.parse('${Enviroment.apiUrl}/mensajes/$usuarioID'), headers: {
      'Content-Type': 'application/json',
      'x-token': '${await AuthServices.getToken()}'
    });
    final mensajeResponse = mensajeResponseFromJson(resp.body);
    return mensajeResponse.mensajes;
  }
}
