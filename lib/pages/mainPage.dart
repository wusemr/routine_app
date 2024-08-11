import 'package:flutter/material.dart';
import 'addRoutinePage.dart';
import 'routineListPage.dart';
import '../models/routine.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Routine> routines = [];

  // 루틴 추가 콜백
  void _addRoutine(Routine newRoutine) {
    setState(() {
      routines.add(newRoutine);
    });
  }

  // 루틴 수정 콜백
  void _editRoutine(Routine updatedRoutine) {
    setState(() {
      int index = routines.indexWhere((r) => r.id == updatedRoutine.id);
      if (index != -1) {
        routines[index] = updatedRoutine;
      }
    });
  }

  // 루틴 삭제 콜백
  void _deleteRoutine(String id) {
    setState(() {
      routines.removeWhere((routine) => routine.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text("루틴 추가 페이지"),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddRoutinePage(
                      onAdd: _addRoutine,
                    ),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: const Text("루틴 목록 페이지"),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RoutineListPage(
                      routines: routines,
                      onEdit: _editRoutine,
                      onDelete: _deleteRoutine,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
