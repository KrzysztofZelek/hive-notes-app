import 'package:flutter/material.dart';

import 'package:hive_notes_app/models/note.dart';

class EditNotePage extends StatefulWidget {
  const EditNotePage({Key? key, required this.note}) : super(key: key);

  final Note note;

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  void editNote(Note note, String title, String description) {
    note.title = title;
    note.description = description;

    note.save();
  }

  final formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note details'),
      ),
      body: SingleChildScrollView(
        child: Container(
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
                      editNote(widget.note, title, description);

                      Navigator.of(context).pop();
                    }
                  },
                  child: const Center(
                    child: Text(
                      'Edit note',
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
      ),
    );
  }

  Widget buildDescription() {
    return TextFormField(
      initialValue: widget.note.description,
      decoration: const InputDecoration(
        label: Text('Add note description'),
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value != null && value.length < 2) {
          return 'Enter at least 2 characters';
        }
        if (value != null && value == widget.note.description) {
          return 'Modify your description before moving forward!';
        }
        return null;
      },
      onChanged: (value) {
        description = value;
      },
    );
  }

  Widget buildTitle() {
    return TextFormField(
      initialValue: widget.note.title,
      decoration: const InputDecoration(
        label: Text('Add note title'),
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value != null && value.length < 2) {
          return 'Enter at least 2 characters';
        }
        if (value != null && value == widget.note.title) {
          return 'Modify your title before moving forward!';
        }
        return null;
      },
      onChanged: (value) {
        title = value;
      },
    );
  }
}
