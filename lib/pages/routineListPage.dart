import 'package:flutter/material.dart';
import 'package:routine_app/pages/editRoutinePage.dart';
import '../models/routine.dart';

class RoutineListPage extends StatefulWidget {
  final List<Routine> routines;
  final Function(Routine) onEdit;
  final Function(String) onDelete;

  const RoutineListPage({
    Key? key,
    required this.routines,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  _RoutineListPageState createState() => _RoutineListPageState();
}

class _RoutineListPageState extends State<RoutineListPage> {
  void _editRoutine(Routine routine) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditRoutinePage(
          routine: routine,
          onSave: (updatedRoutine) {
            widget.onEdit(updatedRoutine);
            setState(() {});
          }
        )
      )
    );
  }

  void _deleteRoutine(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            '루틴 삭제',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Container(
            width: 300,
            height: 50,
            child: const Text(
              '삭제한 루틴은 되돌릴 수 없습니다.\n정말 삭제하시겠습니까?',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          actions: [
            TextButton(
              child: const Text(
                '취소',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                '삭제',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.redAccent,
                ),
              ),
              onPressed: () {
                widget.onDelete(id);
                Navigator.of(context).pop();
                setState(() {});
              },
            ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('루틴 리스트'),
      ),
      body: ListView.builder(
        itemCount: widget.routines.length,
        itemBuilder: (context, index) {
          final routine = widget.routines[index];
          return ListTile(
            title: Text(routine.title ?? ''),
            subtitle: Text(
                '요일: ${routine.days?.join(', ')}\n시작일: ${routine.startTime?.toLocal().toString().split(' ')[0]}\n종료일: ${routine.endTime?.toLocal().toString().split(' ')[0]}'
            ),
            isThreeLine: true,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _editRoutine(routine),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _deleteRoutine(routine.id!),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
