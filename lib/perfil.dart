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
    // Inicializa com os valores atuais salvos
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
      const SnackBar(
        content: Text('Alterações guardadas com sucesso!'),
        backgroundColor: Color(0xFF00D195),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Perfil'),
        backgroundColor: const Color(0xFF00D195),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 45,
              backgroundImage: AssetImage('/avatar.png'),
            ),
            const SizedBox(height: 30),

            // Campo Nome
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(
                labelText: 'Nome',
                filled: true,
                fillColor: const Color(0xFFE9FBEF),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Campo Email
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                filled: true,
                fillColor: const Color(0xFFE9FBEF),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Botão Guardar
            SizedBox(
              height: 45,
              width: 180,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00D195),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: _guardarAlteracoes,
                child: const Text(
                  'Salvar Alterações',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
