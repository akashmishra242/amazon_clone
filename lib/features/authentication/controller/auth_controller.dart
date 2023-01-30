// ignore_for_file: use_build_context_synchronously

import 'package:amazon_clone/features/authentication/screens/login_screen.dart';
import 'package:amazon_clone/features/authentication/service/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/user_model.dart';

final authControllerProvider = Provider((ref) {
  final authService = ref.watch(authServiceProvider);
  return AuthController(authService: authService, ref: ref);
});

final authControllerGetUsetDetails = FutureProvider(
  (ref) {
    final authController = ref.watch(authControllerProvider);
    return authController.getUserDetails();
  },
);

class AuthController {
  final AuthService authService;
  final ProviderRef ref;

  AuthController({required this.authService, required this.ref});

  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String fullname,
    required String phone,
  }) {
    authService.signUpUser(
        context: context,
        email: email,
        password: password,
        fullname: fullname,
        phone: phone);
  }

  Future<UserModel> signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) {
    return authService.signInUser(
        context: context, email: email, password: password);
  }

  Future<UserModel?> getUserDetails() async {
    return await authService.getUserDetails();
  }

  void logout({
    required BuildContext context,
  }) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString('x-auth-token', '');
    await sp.setString('user-id', '');

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
        (route) => false);
  }
}
