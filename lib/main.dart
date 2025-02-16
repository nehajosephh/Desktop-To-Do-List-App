import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  // Configure window options
  WindowOptions windowOptions = const WindowOptions(
    size: Size(350, 500),
    center: true,
    backgroundColor: Colors.transparent,
    alwaysOnTop: true,
    titleBarStyle: TitleBarStyle.hidden,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
    await windowManager.setPreventClose(true);
    await windowManager.setAsFrameless();
  });

  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.pinkAccent,
        fontFamily: 'DancingScript',
      ),
      home: const ToDoListScreen(),
    );
  }
}

class ToDoListScreen extends StatefulWidget {
  const ToDoListScreen({super.key});

  @override
  _ToDoListScreenState createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  final TextEditingController _taskController = TextEditingController();
  final List<String> _tasks = [];

  void _addTask() {
    if (_taskController.text.isNotEmpty) {
      setState(() {
        _tasks.add(_taskController.text);
        _taskController.clear();
        _updateClosePrevention();
      });
    }
  }

  void _removeTask(int index) {
    setState(() {
      _tasks.removeAt(index);
      _updateClosePrevention();
    });
  }

  void _updateClosePrevention() async {
    if (_tasks.isEmpty) {
      await windowManager.setPreventClose(false);
    } else {
      await windowManager.setPreventClose(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Column(
        children: [
          const SizedBox(height: 20),

          // Drag title bar
          GestureDetector(
            onPanUpdate: (details) async {
              Offset position = await windowManager.getPosition();
              await windowManager.setPosition(
                Offset(position.dx + details.delta.dx, position.dy + details.delta.dy),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              color: Colors.pinkAccent,
              child: const Center(
                child: Text(
                  "To-Do List",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ),

          // Input field
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _taskController,
              decoration: InputDecoration(
                labelText: "New Task",
                labelStyle: const TextStyle(color: Colors.pink),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.pinkAccent),
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.pink),
                  borderRadius: BorderRadius.circular(20),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add, color: Colors.pink),
                  onPressed: _addTask,
                ),
              ),
              onSubmitted: (_) => _addTask(),
            ),
          ),

          // Task list
          Expanded(
            child: _tasks.isEmpty
                ? const Center(
                    child: Text(
                      "No tasks! Add one to get started.",
                      style: TextStyle(color: Colors.pinkAccent, fontSize: 18),
                    ),
                  )
                : ListView.builder(
                    itemCount: _tasks.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          title: Text(
                            _tasks[index],
                            style: const TextStyle(fontSize: 18),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _removeTask(index),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}