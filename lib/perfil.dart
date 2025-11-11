import 'package:flutter/material.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final _formKey = GlobalKey<FormState>();
  final _nome = TextEditingController();
  final _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          children: [
            _avatar(),
            SizedBox(width: 16),
            _saudacao(),
            const SizedBox(height: 20),
            _nomeField(_nome),
            const SizedBox(height: 20),
            _emailField(_email),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buttonSalvar(context, _formKey, _nome, _email),
                SizedBox(width: 20),
                _buttonCancelar(context),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _avatar() {
  return const CircleAvatar(
    radius: 25,
    backgroundImage: AssetImage('/avatar.png'),
  );
}

Widget _saudacao() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: const [
      Text(
        'Olá, José!',
        style: TextStyle(
          color: Color(0xFF00D195),
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 20),
      Text(
        'As Tuas Tarefas',
        style: TextStyle(
          color: Color(0xFF00D195),
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
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

Widget _buttonCancelar(BuildContext context) {
  return SizedBox(
    height: 40,
    width: 140,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text(
        'Cancelar',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
  );
}

Widget _buttonSalvar(
  BuildContext context,
  GlobalKey<FormState> formKey,
  TextEditingController nomeController,
  TextEditingController emailController,
) {
  return SizedBox(
    height: 40,
    width: 140,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF00D195),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      onPressed: () {
        if (formKey.currentState!.validate()) {
          Navigator.pop(context);
          // Aqui add logica para salvar os dados do perfil
        }
      },
      child: const Text(
        'Salvar',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
  );
}
