import 'package:chat/pages/chat_page.dart';
import 'package:chat/pages/loading_page.dart';
import 'package:chat/pages/login_page.dart';
import 'package:chat/pages/register_page.dart';
import 'package:chat/pages/usuarios_page.dart';
import 'package:flutter/widgets.dart';

final Map<String, Widget Function(BuildContext)> apRoutes = {
  'usuarios': (_) => UsuariosPage(),
  'chat': (_) => ChatPage(),
  'register': (_) => RegisterPage(),
  'loading': (_) => LoadingPage(),
  'login': (_) => LoginPage(),
};
