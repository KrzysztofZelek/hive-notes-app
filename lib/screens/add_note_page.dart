import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_notes_app/models/note.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({Key? key}) : super(key: key);

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note details'),
      ),
      body: Container(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey,
          child: Column(
            children: [
              const Center(
                child: Text(
                  'Specify note details',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              buildTitle(),
              const SizedBox(height: 10.0),
              buildDescription(),
              const SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  final isValid = formKey.currentState!.validate();
                  if (isValid) {
                    Box<Note> box = Hive.box<Note>('notes');

                    box.add(Note(title: title, description: description));
                    Navigator.of(context).pop();
                  }
                },
                child: const Center(
                  child: Text(
                    'Add note',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDescription() {
    return TextFormField(
      decoration: const InputDecoration(
          label: Text('Add note description'), border: OutlineInputBorder()),
      validator: (value) {
        if (value != null && value.length < 2) {
          return 'Enter at least 2 characters';
        } else {
          return null;
        }
      },
      onChanged: (value) {
        description = value;
      },
    );
  }

  Widget buildTitle() {
    return TextFormField(
      decoration: const InputDecoration(
        label: Text('Add note title'),
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value != null && value.length < 2) {
          return 'Enter at least 2 characters';
        } else {
          return null;
        }
      },
      onChanged: (value) {
        title = value;
      },
    );
  }
}
