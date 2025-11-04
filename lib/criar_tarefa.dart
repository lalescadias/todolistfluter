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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
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
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color(0xFFE9FBEF),
                labelText: 'Data da Tarefa',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,
              onTap: () => _selectdDate(context),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor selecione a data da tarefa';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buttonCriar(
                  context,
                  _tituloController.text,
                  _descricaoController.text,
                  _dataController.text,
                ),
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

Widget _titulo() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: const [
      Text(
        'Criar Tarefa',
        style: TextStyle(
          color: Color(0xFF00D195),
          fontSize: 32,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}

Widget _tituloDaTarefa(TextEditingController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Título da Tarefa',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      const SizedBox(height: 10),
      TextField(
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFE9FBEF),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    ],
  );
}

Widget _descricaoDaTarefa(TextEditingController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Descrição da Tarefa',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      const SizedBox(height: 10),
      TextField(
        controller: controller,
        maxLines: 3,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xFFE9FBEF),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    ],
  );
}

Widget _buttonCriar(
  BuildContext context,
  tituloTarefa,
  descricaoTarefa,
  dataYTarefa,
) {
  return SizedBox(
    height: 40,
    width: 140,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF00D195),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      onPressed: () {
        final titulo = tituloTarefa;
        final descricao = descricaoTarefa;
        final data = dataYTarefa;

        tarefas.add({'titulo': titulo, 'descricao': descricao, 'data': data});
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const TarefasPage()),
        );
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
        // voltar para pagina anterior
        Navigator.pop(context);
      },
      child: const Text(
        'Cancelar',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
  );
}
