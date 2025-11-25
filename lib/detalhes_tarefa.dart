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
        _dataController.text =
            "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _titulo(context),
            const SizedBox(height: 30),

            _input(
              controller: _tituloController,
              label: 'Título da Tarefa',
            ),

            const SizedBox(height: 20),

            _input(
              controller: _descricaoController,
              label: 'Descrição da Tarefa',
              maxLines: 3,
            ),

            const SizedBox(height: 20),

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

            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buttonSalvar(context),
                const SizedBox(width: 12),
                _buttonCancelar(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // HEADER
  Widget _titulo(BuildContext context) {
    return Text(
      'Detalhes da Tarefa',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontSize: 26,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  // 
  Widget _input({
    required TextEditingController controller,
    required String label,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      ),
    );
  }

  // SALVAR
  Widget _buttonSalvar(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 40,
      child: ElevatedButton(
        onPressed: () {
          final titulo = _tituloController.text.trim();
          final descricao = _descricaoController.text.trim();
          final data = _dataController.text.trim();

          Navigator.pop(context, {
            'titulo': titulo,
            'descricao': descricao,
            'data': data,
          });
        },
        child: const Text(
          'Salvar',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // CANCELAR
  Widget _buttonCancelar(BuildContext context) {
    return SizedBox(
      width: 140,
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey.shade400,
          foregroundColor: Colors.white,
        ),
        onPressed: () => Navigator.pop(context),
        child: const Text(
          'Cancelar',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
