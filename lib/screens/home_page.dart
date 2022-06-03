import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_notes_app/models/note.dart';
import 'package:hive_notes_app/screens/add_note_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Notes'),
      ),
      body: ValueListenableBuilder(
          valueListenable: Hive.box<Note>('notes').listenable(),
          builder: (context, Box<Note> box, _) {
            if (box.isEmpty) {
              return const Center(
                child: Text('You haven\'t added any notes yet!'),
              );
            }
            return buildNotes(box);
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddNotePage()));
        },
        child: const Icon(Icons.add),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue[700],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
      ),
    );
  }

  Widget buildNotes(Box<Note> box) {
    return GridView.builder(
        padding: const EdgeInsets.all(12.0),
        physics: const BouncingScrollPhysics(),
        itemCount: box.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          final note = box.getAt(index);
          return ListTile(
            contentPadding: const EdgeInsets.all(12.0),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
            tileColor: Colors.blue[700],
            onLongPress: () {
              setState(() {
                box.deleteAt(index);
              });
            },
            title: Text(
              note!.title,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                note.description,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        });
  }
}
