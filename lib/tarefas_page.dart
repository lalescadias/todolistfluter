import 'package:flutter/material.dart';
import 'criar_tarefa.dart';


final List<Map<String, String>> tarefas = [
  {
    'titulo': 'Ir às compras',
    'descricao': 'Comprar frutas e legumes',
    'data': '2025-10-29',
  },
  {
    'titulo': 'Estudar Flutter',
    'descricao': 'Trabalhar na lista de tarefas',
    'data': '2025-10-30',
  },
];

class TarefasPage extends StatefulWidget {
  const TarefasPage({super.key});

  @override
  State<TarefasPage> createState() => _TarefasPageState();
}

class _TarefasPageState extends State<TarefasPage> {

  void removerTarefa(int index) {
    setState(() {
      tarefas.removeAt(index);
    });
  }

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
            // Lista de tarefas
            ListaDeTarefas(tarefas: tarefas, onRemover: removerTarefa),
            _buttonCriarTarefa(context),
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

class ListaDeTarefas extends StatelessWidget {
  final List<Map<String, String>> tarefas;
  final Function(int) onRemover;

  const ListaDeTarefas({
    super.key,
    required this.tarefas,
    required this.onRemover,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: tarefas.length,
        itemBuilder: (context, index) {
          final tarefa = tarefas[index];
          return Dismissible(
            key: Key(tarefa['titulo'] ?? index.toString()), 
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              color: Colors.red,
              child: const Icon(Icons.delete, color: Colors.white, size: 28),
            ),
            onDismissed: (direction) {
              onRemover(index);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Tarefa "${tarefa['titulo']}" removida')),
              );
            },
            child: Card(
              elevation: 0,
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: ListTile(
                title: Text(
                  tarefa['titulo'] ?? '', 
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget _buttonCriarTarefa(BuildContext context) {
  return SizedBox(
    height: 40,
    width: 140,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF00D195),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const CriarTarefaPage()));
      },
      child: const Text(
        'Criar tarefa',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
  );
}