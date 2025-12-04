import 'package:flutter/material.dart';
import 'utilizador.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  late TextEditingController _nomeController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: utilizador['nome'] ?? '');
    _emailController = TextEditingController(text: utilizador['email'] ?? '');
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _guardarAlteracoes() {
    setState(() {
      utilizador['nome'] = _nomeController.text;
      utilizador['email'] = _emailController.text;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Alterações guardadas com sucesso!'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Avatar
            const CircleAvatar(
              radius: 45,
              backgroundImage: AssetImage('assets/avatar.png'),
            ),

            const SizedBox(height: 30),

            // Campo Nome
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome',
                contentPadding: EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 12,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Campo Email
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                contentPadding: EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 12,
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Botão Guardar
            SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(
                onPressed: _guardarAlteracoes,
                child: const Text(
                  'Salvar Alterações',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
