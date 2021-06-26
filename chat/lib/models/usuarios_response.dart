// To parse this JSON data, do
//
//     final usuariosRespose = usuariosResposeFromJson(jsonString);

import 'dart:convert';

import 'package:chat/models/usuarios.dart';

UsuariosRespose usuariosResposeFromJson(String str) =>
    UsuariosRespose.fromJson(json.decode(str));

String usuariosResposeToJson(UsuariosRespose data) =>
    json.encode(data.toJson());

class UsuariosRespose {
  UsuariosRespose({
    required this.ok,
    required this.usuarios,
  });

  bool ok;
  List<Usuario> usuarios;

  factory UsuariosRespose.fromJson(Map<String, dynamic> json) =>
      UsuariosRespose(
        ok: json["ok"],
        usuarios: List<Usuario>.from(
            json["usuarios"].map((x) => Usuario.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "usuarios": List<dynamic>.from(usuarios.map((x) => x.toJson())),
      };
}
