import 'package:flutter/material.dart';
import 'package:todolist/login.dart';
import 'utilizador.dart';

class Registo extends StatefulWidget {
  const Registo({super.key});
  @override
  State<Registo> createState() => _RegistoState();
}

class _RegistoState extends State<Registo> {
  final _formKey = GlobalKey<FormState>();
  final _nome = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

// Campo de nome
  Widget _nomeField(TextEditingController controller) {
  return TextFormField(
    controller: controller,
    keyboardType: TextInputType.name,
    decoration: const InputDecoration(labelText: 'Nome'),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Por favor introduza o nome';
      }
      return null;
    },
  );
}

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

// Cabeçalho da página de registo
Widget _header() {
  return Column(
    children: [
      const SizedBox(height: 20),

      SizedBox(
        width: 180,
        height: 180,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            'assets/logo.png',
            fit: BoxFit.contain,
          ),
        ),
      ),

      const SizedBox(height: 24),

      const Text(
        'Cria a tua conta',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0xFF2E7D32),
          fontSize: 26,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
        ),
      ),

      const SizedBox(height: 8),

      const Text(
        'Preenche os teus dados para começar',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black54,
          fontSize: 14,
        ),
      ),
    ],
  );
}

// Botão de registo
Widget _registarButton(
  BuildContext context,
  GlobalKey<FormState> formKey,
  TextEditingController emailController,
  TextEditingController nomeController,
  TextEditingController passwordController,
) {
  return SizedBox(
  
    child: ElevatedButton(
      onPressed: () {
        if (formKey.currentState!.validate()) {
          utilizador['nome'] = nomeController.text;
          utilizador['email'] = emailController.text;

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const Login()),
          );
        }
      },
      child: const Text(
        'Registar',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
    ),
  );
}

// Rodapé da página de registo
Widget _footer(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 28, bottom: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Já tem conta?',
          style: TextStyle(fontSize: 14, color: Colors.black87),
        ),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const Login()),
            );
          },
          child: Text(
            'Entrar',
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
                  _nomeField(_nome),
                  const SizedBox(height: 24),
                  _emailField(_email),
                  const SizedBox(height: 24),
                  _passwordField(_password),
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.center,
                    child: _registarButton(
                      context,
                      _formKey,
                      _email,
                      _nome,
                      _password,
                    ),
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






