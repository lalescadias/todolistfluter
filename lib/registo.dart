import 'package:flutter/material.dart';
import 'package:todolist/login.dart';

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
                    child: _registarButton(context, _formKey, _email, _password),
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

Widget _nomeField(TextEditingController controller) {
  return TextFormField(
    controller: controller,
    keyboardType: TextInputType.name,
    decoration: InputDecoration(
      filled: true,
      fillColor: Color(0xFFE9FBEF),
      labelText: 'Nome',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Por favor introduza o nome';
      }
      return null;
    },
  );
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
      Transform.rotate(
        angle: -0.4,
        child: Image.asset('/logo.png', width: 120, height: 120),
      ),
      const SizedBox(height: 12),
      const Text(
        '    Cria A \nTua Conta',
        style: TextStyle(
          color: Color.fromARGB(255, 5, 7, 7),
          fontSize:48,
          fontWeight: FontWeight.w300, 
          letterSpacing: -1,
        ),
      ),
      
    ],
  );
}

Widget _registarButton(
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
          // Processar registo  
        }
      },
      child: const Text(
        'Registar',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
  );
}

Widget _footer(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 20, bottom: 8), // espaçamento do rodapé
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Já tem conta? ',
          style: TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
        GestureDetector(
          onTap: () {
            // navega para página de login
             Navigator.push(context, MaterialPageRoute(builder: (_) => const Login()));
          },
          child: const Text(
            'Entrar',
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
