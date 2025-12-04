import 'package:flutter/material.dart';
import 'criar_tarefa.dart';
import 'detalhes_tarefa.dart';
import 'utilizador.dart';
import 'perfil.dart';

final List<Map<String, String>> tarefas = [
  {
    'titulo': 'Ir às compras',
    'descricao': 'Comprar frutas e legumes',
    'data': '2025-10-29',
    'feito': 'false',
  },
  {
    'titulo': 'Estudar Flutter',
    'descricao': 'Trabalhar na lista de tarefas',
    'data': '2025-10-30',
    'feito': 'false',
  },
];

class TarefasPage extends StatefulWidget {
  const TarefasPage({super.key});

  @override
  State<TarefasPage> createState() => _TarefasPageState();
}

class _TarefasPageState extends State<TarefasPage> {
  late TextEditingController _nomeUtilizadorController;
  @override
  void initState() {
    super.initState();
    _nomeUtilizadorController = TextEditingController(
      text: utilizador['nome'] ?? 'Utilizador',
    );
  }

  void removerTarefa(int index) {
    setState(() {
      tarefas.removeAt(index);
    });
  }

  // Cabeçalho com avatar e saudação
  Widget _header(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PerfilPage()),
            );

            // Atualiza o texto com o novo nome vindo do utilizador
            _nomeUtilizadorController.text = utilizador['nome'] ?? 'Utilizador';

            setState(() {});
          },
          child: const CircleAvatar(
            radius: 26,
            backgroundImage: AssetImage('assets/avatar.png'),
          ),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Olá, ${_nomeUtilizadorController.text}!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Aqui estão as tuas tarefas',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ],
        ),
      ],
    );
  }

  // Botão para criar nova tarefa
  Widget _buttonCriarTarefa(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CriarTarefaPage()),
          );
        },
        child: const Text(
          'Criar tarefa',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('As Tuas Tarefas')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            _header(context),
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
                SnackBar(
                  content: Text('Tarefa "${tarefa['titulo']}" removida'),
                ),
              );
            },
            child: Card(
              color: tarefa['feito'] == 'true'
                  ? Colors.green.shade50
                  : Colors.white,
              elevation: 1,
              shadowColor: Colors.black12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 10,
                ),

                leading: Checkbox(
                  value: tarefa['feito'] == 'true',
                  activeColor: Theme.of(context).colorScheme.primary,
                  onChanged: (value) {
                    tarefas[index]['feito'] = value.toString();
                    (context as Element).markNeedsBuild();
                  },
                ),

                title: Text(
                  tarefa['titulo'] ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary,
                    decoration: tarefa['feito'] == 'true'
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                subtitle: tarefa['data'] != null
                    ? Text(
                        tarefa['data']!,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      )
                    : null,

                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                  color: Colors.grey.shade600,
                ),

                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetalhesTarefaPage(
                        titulo: tarefa['titulo'] ?? '',
                        descricao: tarefa['descricao'] ?? '',
                        data: tarefa['data'] ?? '',
                      ),
                    ),
                  );

                  if (result != null && result is Map<String, String>) {
                    tarefas[index] = result;
                    (context as Element).markNeedsBuild();
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
