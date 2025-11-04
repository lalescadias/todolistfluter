import 'package:flutter/material.dart';

class Registo extends StatefulWidget {
  const Registo({super.key});
  @override
  State<Registo> createState() => _RegistoState();
}

class _RegistoState extends State<Registo> {

  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _header(),
                  const SizedBox(height: 32),
                  _emailField(_email),
                  const SizedBox(height: 24),
                  _passwordField(_password),
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.center,
                    child: _loginButton(context, _formKey, _email, _password),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _emailField(TextEditingController controller) {
  return TextFormField(
    controller: controller,
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
      filled: true,
      fillColor: Color(0xFFE9FBEF),
      labelText: 'Email',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Por favor introduza o email';
      }
      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
        return 'Por favor introduza um email válido';
      }
      return null;
    },
  );
}

Widget _passwordField(TextEditingController controller) {
  return TextFormField(
    controller: controller,
    obscureText: true,
    decoration: InputDecoration(
      filled: true,
      fillColor: Color(0xFFE9FBEF),
      labelText: 'Password',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      suffixIcon: const Icon(Icons.visibility_off),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Por favor introduza a password';
      }
      if (value.length < 6) {
        return 'A password deve ter pelo menos 6 caracteres';
      }
      return null;
    },
  );
}

Widget _header() {
  return Column(
    children: [
      const SizedBox(height: 12),
      const Text(
        'Log In',
        style: TextStyle(
          color: Color(0xFF7DD6BF),
          fontSize: 26,
          fontWeight: FontWeight.w700,
        ),
      ),
      const SizedBox(height: 12),
      Transform.rotate(
        angle: -0.4,
        child: Image.asset('/logo.png', width: 120, height: 120),
      ),
    ],
  );
}

Widget _loginButton(
  BuildContext context,
  GlobalKey<FormState> formKey,
  TextEditingController emailController,
  TextEditingController passwordController,
) {
  return SizedBox(
    height: 40,
    width: 120,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF00D195),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      onPressed: () {
        if (formKey.currentState!.validate()) {
          // Processar login
        }
      },
      child: const Text(
        'Entrar',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
  );
}
