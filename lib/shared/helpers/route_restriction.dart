import 'package:dating_app/networks/sharedpreference/sharedpreference.dart';
import 'package:dating_app/routes.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: Navigate.loginPage);

  @override
  Future<bool> canActivate(String path, ModularRoute router) async {
    int status = await getLoginStatus();
    // String userId = await getUserId();
    return status == 2;
  }
}

class AuthGuard1 extends RouteGuard {
  AuthGuard1() : super(redirectTo: Navigate.loginPage);

  @override
  Future<bool> canActivate(String path, ModularRoute router) async {
    int status = await getLoginStatus();
    // String userId = await getUserId();
    return status == 1;
  }
}
