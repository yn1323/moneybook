import 'package:moneybook/imports.dart';
import 'package:intl/intl.dart';

class DatePicker extends ConsumerStatefulWidget {
  DatePicker({Key? key, required this.controller, DateTime? initialDate})
      : super(key: key);

  final TextEditingController controller;
  final DateTime initialDate = DateTime.now();

  @override
  _DatePicker createState() => _DatePicker();
}

class _DatePicker extends ConsumerState<DatePicker> {
  final TextEditingController dateController = TextEditingController();
  DateFormat formatter = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    super.initState();
    widget.controller.text = formatter.format(widget.initialDate);
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: widget.initialDate,
        firstDate: DateTime(1990),
        lastDate: DateTime.now().add(const Duration(days: 360)));
    if (picked != null) {
      widget.controller.text = formatter.format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => selectDate(context),
      child: AbsorbPointer(
        child: TextFormField(
          controller: widget.controller,
          decoration: const InputDecoration(
            labelText: '日付',
            prefixIcon: Icon(Icons.today),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '日付を入力してください。';
            }
            return null;
          },
        ),
      ),
    );
  }
}
