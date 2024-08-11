import 'package:flutter/material.dart';
import '../models/routine.dart';

class EditRoutinePage extends StatefulWidget {
  final Routine routine;
  final Function(Routine) onSave;

  const EditRoutinePage({
    Key? key,
    required this.routine,
    required this.onSave,
  }) : super(key: key);

  @override
  _EditRoutinePageState createState() => _EditRoutinePageState();
}

class _EditRoutinePageState extends State<EditRoutinePage> {
  final _formKey = GlobalKey<FormState>();
  late String _routineName;
  late List<bool> _selectedDays;
  DateTime? _startDate;
  DateTime? _endDate;

  final List<String> _days = ['월', '화', '수', '목', '금', '토', '일'];

  @override
  void initState() {
    super.initState();
    _routineName = widget.routine.title ?? '';
    _selectedDays = _days.map((day) => widget.routine.days?.contains(day) ?? false).toList();
    _startDate = widget.routine.startTime;
    _endDate = widget.routine.endTime;
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? (_startDate ?? DateTime.now()) : (_endDate ?? DateTime.now()),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          
        }
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
