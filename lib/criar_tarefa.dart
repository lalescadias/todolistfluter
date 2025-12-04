import 'package:flutter/material.dart';
import 'tarefas_page.dart';

class CriarTarefaPage extends StatefulWidget {
  const CriarTarefaPage({super.key});

  @override
  State<CriarTarefaPage> createState() => _CriarTarefaPageState();
}

class _CriarTarefaPageState extends State<CriarTarefaPage> {
  final _tituloController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _dataController = TextEditingController();
  DateTime? _selectedDate;
  

  Future<void> _selectdDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dataController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }
//titulo
Widget _titulo() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: const [
      Text(
        'Criar Tarefa',
        style: TextStyle(
          color: Color(0xFF2E7D32),
          fontSize: 26,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}

Widget _tituloDaTarefa(TextEditingController controller) {
  return TextField(
    controller: controller,
    decoration: const InputDecoration(
      labelText: 'Título da Tarefa',
      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
    ),
  );
}

Widget _descricaoDaTarefa(TextEditingController controller) {
  return TextField(
    controller: controller,
    maxLines: 3,
    decoration: const InputDecoration(
      labelText: 'Descrição da Tarefa',
      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
    ),
  );
}

Widget _buttonCancelar(BuildContext context) {
  return SizedBox(
    height: 40,
    width: 140,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey.shade400,
        foregroundColor: Colors.white,
      ),

      onPressed: () => Navigator.pop(context),
       child: const Text(
        'Cancelar',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
  );
}


Widget _buttonCriar(BuildContext context) {
  return SizedBox(
    width: 140,
    height: 40,
    child: ElevatedButton(
      onPressed: () {
        final titulo = _tituloController.text;
        final descricao = _descricaoController.text;
        final data = _dataController.text;

        tarefas.add({'titulo': titulo, 'descricao': descricao, 'data': data});

        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const TarefasPage()),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            _titulo(),
            const SizedBox(height: 40),
            _tituloDaTarefa(_tituloController),
            const SizedBox(height: 20),
            _descricaoDaTarefa(_descricaoController),
            const SizedBox(height: 20),

            //data da tarefa
            TextFormField(
              controller: _dataController,
              readOnly: true,
              onTap: () => _selectdDate(context),
              decoration: const InputDecoration(
                labelText: 'Data da Tarefa',
                suffixIcon: Icon(Icons.calendar_today),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 12,
                ),
              ),
            ),

            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buttonCriar(context),
                const SizedBox(width: 10),
                _buttonCancelar(context),
              ],
            ),
          ],
        ),
      ),
    );
  }
}








