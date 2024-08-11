import 'package:flutter/material.dart';
import 'dart:math';
import '../models/routine.dart';

class AddRoutinePage extends StatefulWidget {
  final Function(Routine) onAdd;

  const AddRoutinePage({super.key, required this.onAdd});

  @override
  State<AddRoutinePage> createState() => _AddRoutinePageState();
}

class _AddRoutinePageState extends State<AddRoutinePage> {
  final _formKey = GlobalKey<FormState>();  // 폼 상태 관리를 위한 키
  String _routineName = ''; // 루틴 이름 저장
  List<bool> _selectedDays = List.filled(7, false);
  DateTime? _startDate;
  DateTime? _endDate;

  final List<String> _days = ['월', '화', '수', '목', '금', '토', '일'];
  List<Routine> _routines = [];

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
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

  void _addRoutine() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      List<String> selectedDays = [];
      for (int i=0; i<_selectedDays.length; i++) {
        if (_selectedDays[i]) {
          selectedDays.add(_days[i]);
        }
      }

      final newRoutine = Routine(
        id: Random().nextInt(1000).toString(),
        title: _routineName,
        days: selectedDays,
        startTime: _startDate,
        endTime: _endDate,
      );

      setState(() {
        _routines.add(newRoutine);
      });

      widget.onAdd(newRoutine); // MainPage의 콜백 호출로 루틴 추가

      _formKey.currentState?.reset();
      _routineName = '';
      _selectedDays = List.filled(7, false);
      _startDate = null;
      _endDate = null;

      Navigator.pop(context); // 페이지 닫기
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("루틴 추가하기"),
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
                  decoration: const InputDecoration(labelText: "루틴 이름"),
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
                  "반복 요일",
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
                        }),
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
                          "시작일",
                          style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () => _selectDate(context, true),
                          child: Text(
                            _startDate == null
                                ? "날짜 선택"
                                : _startDate!.toLocal().toString().split(' ')[0],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "종료일",
                          style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold
                          ),
                        ),
                        TextButton(
                          onPressed: () => _selectDate(context, false),
                          child: Text(
                            _endDate == null
                                ? "날짜 선택"
                                : _endDate!.toLocal().toString().split(' ')[0],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: _addRoutine,
                    child: const Text('루틴 추가'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
