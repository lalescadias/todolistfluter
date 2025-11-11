import 'package:flutter/material.dart';
import 'utilizador.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

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
        child: utilizador.isEmpty
            ? const Center(
                child: Text(
                  'Nenhum utilizador registado.',
                  style: TextStyle(fontSize: 18),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: const AssetImage('assets/avatar.png'),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Nome: ${utilizador['nome']}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Email: ${utilizador['email']}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Data de nascimento: ${utilizador['dataNascimento']}',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
      ),
    );
  }
}
