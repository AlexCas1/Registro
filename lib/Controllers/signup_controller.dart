import 'package:flutter/material.dart';
import '../Database/database_helper.dart';

class SignupController {
  final formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final DatabaseHelper _dbHelper = DatabaseHelper();

  // Para manejar el estado de las contraseñas ocultas
  ValueNotifier<bool> isPasswordObscured = ValueNotifier<bool>(true);
  ValueNotifier<bool> isConfirmPasswordObscured = ValueNotifier<bool>(true);
  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  void togglePasswordVisibility() {
    isPasswordObscured.value = !isPasswordObscured.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordObscured.value = !isConfirmPasswordObscured.value;
  }

  Future<void> registrar(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;

      bool exito = await _dbHelper.registrarUsuario(
        nameController.text.trim(),
        emailController.text.trim(),
        passwordController.text, // En un entorno real, esto debería estar encriptado
      );

      isLoading.value = false;

      if (context.mounted) {
        if (exito) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('¡Cuenta creada exitosamente!')),
          );
          // Aquí puedes navegar a la pantalla de inicio de sesión
          // Navigator.pushReplacementNamed(context, '/login');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error al crear la cuenta. Intenta de nuevo.')),
          );
        }
      }
    }
  }

  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    isPasswordObscured.dispose();
    isConfirmPasswordObscured.dispose();
    isLoading.dispose();
  }
}