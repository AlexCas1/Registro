import 'package:flutter/material.dart';
import '../Controllers/signup_controller.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final SignupController _controller = SignupController();

  // Paleta de colores extraída de tu imagen
  final Color bgColor = const Color(0xFFCBE0D3); // Fondo verde claro
  final Color cardColor = const Color(0xFF8BA18E); // Fondo de la tarjeta
  final Color inputColor = const Color(0xFFD4E6D8); // Fondo de los textfields
  final Color buttonColor = const Color(0xFF3F5445); // Color del botón
  final Color textColor = const Color(0xFF425646); // Color del texto oscuro
  final Color hintColor = const Color(0xFF8B9C8E); // Color del texto hint

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: 400, // Ancho fijo para parecerse a la imagen
              padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 50.0),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Form(
                key: _controller.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Icono de Perfil Superior
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: buttonColor,
                      child: const Icon(Icons.person_outline, size: 40, color: Colors.white),
                    ),
                    const SizedBox(height: 20),

                    // Títulos
                    Text(
                      'Crear Cuenta',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Únete a nuestra comunidad hoy',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: textColor.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(height: 35),

                    // Campos de Texto
                    _buildTextField(
                      label: 'Nombre Completo',
                      hint: 'Juan Pérez',
                      icon: Icons.person_outline,
                      controller: _controller.nameController,
                      validator: (value) => value!.isEmpty ? 'Ingresa tu nombre' : null,
                    ),
                    const SizedBox(height: 20),

                    _buildTextField(
                      label: 'Correo Electrónico',
                      hint: 'ejemplo@correo.com',
                      icon: Icons.mail_outline,
                      controller: _controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) return 'Ingresa tu correo';
                        if (!value.contains('@')) return 'Correo no válido';
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    ValueListenableBuilder<bool>(
                      valueListenable: _controller.isPasswordObscured,
                      builder: (context, isObscured, child) {
                        return _buildTextField(
                          label: 'Contraseña',
                          hint: '••••••••',
                          icon: Icons.lock_outline,
                          controller: _controller.passwordController,
                          isPassword: true,
                          isObscured: isObscured,
                          onToggleObscure: _controller.togglePasswordVisibility,
                          validator: (value) => value!.length < 6 ? 'Mínimo 6 caracteres' : null,
                        );
                      },
                    ),
                    const SizedBox(height: 20),

                    ValueListenableBuilder<bool>(
                      valueListenable: _controller.isConfirmPasswordObscured,
                      builder: (context, isObscured, child) {
                        return _buildTextField(
                          label: 'Confirmar Contraseña',
                          hint: '••••••••',
                          icon: Icons.lock_outline,
                          controller: _controller.confirmPasswordController,
                          isPassword: true,
                          isObscured: isObscured,
                          onToggleObscure: _controller.toggleConfirmPasswordVisibility,
                          validator: (value) {
                            if (value != _controller.passwordController.text) {
                              return 'Las contraseñas no coinciden';
                            }
                            return null;
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 35),

                    // Botón Registrarse
                    ValueListenableBuilder<bool>(
                      valueListenable: _controller.isLoading,
                      builder: (context, isLoading, child) {
                        return SizedBox(
                          height: 55,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: buttonColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              elevation: 0,
                            ),
                            onPressed: isLoading ? null : () => _controller.registrar(context),
                            child: isLoading
                                ? const CircularProgressIndicator(color: Colors.white)
                                : const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Registrarse',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 25),

                    // Footer Inicia sesión
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '¿Ya tienes cuenta? ',
                          style: TextStyle(color: textColor.withOpacity(0.8), fontSize: 13),
                        ),
                        InkWell(
                          onTap: () {
                            // Lógica para ir a login
                          },
                          child: Text(
                            'Inicia sesión',
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget reutilizable para los campos de texto
  Widget _buildTextField({
    required String label,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    bool isPassword = false,
    bool isObscured = false,
    VoidCallback? onToggleObscure,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: isObscured,
          validator: validator,
          keyboardType: keyboardType,
          style: TextStyle(color: textColor),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: hintColor),
            filled: true,
            fillColor: inputColor,
            prefixIcon: Icon(icon, color: hintColor),
            suffixIcon: isPassword
                ? IconButton(
              icon: Icon(
                isObscured ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                color: hintColor,
              ),
              onPressed: onToggleObscure,
            )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
          ),
        ),
      ],
    );
  }
}