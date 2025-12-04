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

// Campo de email
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
// Campo de palavra-passe
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
// Cabeçalho da página de login
  Widget _header() {
    return Column(
      children: [
        const SizedBox(height: 20),

        const Text(
          'Bem-vindo',
          style: TextStyle(
            color: Color(0xFF2E7D32),
            fontSize: 26,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Aceda à sua conta para continuar',
          style: TextStyle(color: Colors.black54, fontSize: 14),
        ),

        const SizedBox(height: 24),

  // Logo da aplicação
        SizedBox(
          width: 240,
          height: 240,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/logo.png', // caminho da logo
              fit: BoxFit.contain,
            ),
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }

// Botão de login
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
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
// Rodapé com link para registo
  Widget _footer(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 28),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Ainda não tem conta?',
          style: TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const Registo()),
            );
          },
          child: Text(
            'Registar-se',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.primary, 
              decoration: TextDecoration.underline,         
              decorationThickness: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// Construção do widget de login
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
