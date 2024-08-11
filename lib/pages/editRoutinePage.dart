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
          _endDate = picked;
        }
      });
    }
  }

  void _saveRoutine() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      List<String> selectedDays = [];
      for (int i=0; i<_selectedDays.length; i++) {
        if (_selectedDays[i]) {
          selectedDays.add(_days[i]);
        }
      }

      final updateRoutine = Routine(
        id: widget.routine.id,
        title: _routineName,
        days: selectedDays,
        startTime: _startDate,
        endTime: _endDate,
      );

      widget.onSave(updateRoutine);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('루틴 수정'),
        elevation: 0.1,
        backgroundColor: Colors.white70,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  initialValue: _routineName,
                  decoration: const InputDecoration(labelText: '루틴 이름'),
                  keyboardType: TextInputType.name,
                  onSaved: (value) {
                    _routineName = value ?? '';
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '루틴 이름을 입력하세요';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  '반복 요일',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    _days.length,
                    (index) => Column(
                      children: [
                        Checkbox(
                          value: _selectedDays[index],
                          onChanged: (bool? value) {
                            setState(() {
                              _selectedDays[index] = value!;
                            });
                          },
                        ),
                        Text(_days[index]),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '시작일',
                          style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () => _selectDate(context, true),
                          child: Text(
                            _startDate == null
                                ? '날짜 선택'
                                : _startDate!.toLocal().toString().split(' ')[0],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '종료일',
                          style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () => _selectDate(context, false),
                          child: Text(
                            _endDate == null
                                ? '날짜 선택'
                                : _endDate!.toLocal().toString().split(' ')[0],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saveRoutine,
                  child: const Text('루틴 수정하기'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
