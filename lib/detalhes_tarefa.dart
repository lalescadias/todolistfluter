import 'package:flutter/material.dart';

class DetalhesTarefaPage extends StatefulWidget {
  final String titulo;
  final String descricao;
  final String data;

  const DetalhesTarefaPage({
    super.key,
    required this.titulo,
    required this.descricao,
    required this.data,
  });

  @override
  State<DetalhesTarefaPage> createState() => _DetalhesTarefaPageState();
}

class _DetalhesTarefaPageState extends State<DetalhesTarefaPage> {
  DateTime? _selectedDate;

  late TextEditingController _tituloController;
  late TextEditingController _descricaoController;
  late TextEditingController _dataController;

  @override
  void initState() {
    super.initState();
    _tituloController = TextEditingController(text: widget.titulo);
    _descricaoController = TextEditingController(text: widget.descricao);
    _dataController = TextEditingController(text: widget.data);
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descricaoController.dispose();
    _dataController.dispose();
    super.dispose();
  }

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

            // Data da tarefa
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
                _buttonEditar(context),
                const SizedBox(width: 10),
                _buttonCancelar(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buttonEditar(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 140,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00D195),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        onPressed: () {
          final titulo = _tituloController.text.trim();
          final descricao = _descricaoController.text.trim();
          final data = _dataController.text.trim();

          // Devolve os dados editados para a página anterior
          Navigator.pop(context, {
            'titulo': titulo,
            'descricao': descricao,
            'data': data,
          });
        },
        child: const Text(
          'Editar tarefa',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
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
        'Detalhes da Tarefa',
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
