import 'package:flutter/material.dart';
import 'package:todolist/registo.dart';
import 'package:todolist/tarefas_page.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  Widget _emailField(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(labelText: 'Email'),
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
      decoration: const InputDecoration(labelText: 'Palavra-Passe'),

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
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const TarefasPage()),
            );
          }
        },
        child: const Text(
          'Entrar',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _footer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        bottom: 8,
      ), // espaçamento do rodapé
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Ainda não tem conta? ',
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
          GestureDetector(
            onTap: () {
              // navega para página de registo
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const Registo()),
              );
            },
            child: const Text(
              'Registrar',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF00D195), // mesma cor do botão
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

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
                  _footer(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
