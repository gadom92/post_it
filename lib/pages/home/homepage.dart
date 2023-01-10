import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('notes').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Coś poszło nie tak'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final documents = snapshot.data!.docs;

          return Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.brown[400],
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: Colors.yellow[200],
                    title: const Text(
                      'Dodaj notatkę',
                      style: TextStyle(color: Colors.black),
                    ),
                    content: TextField(
                      controller: controller,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Anuluj',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          FirebaseFirestore.instance.collection('notes').add(
                                ({
                                  'note': controller.text,
                                }),
                              );
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Dodaj',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: const Icon(Icons.note_alt),
            ),
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/background.jpg'),
                ),
              ),
              child: GridView.count(
                crossAxisCount: 2,
                children: [
                  for (final document in documents) ...[
                    Dismissible(
                      direction: DismissDirection.down,
                      key: ValueKey(document.id),
                      onDismissed: (direction) {
                        FirebaseFirestore.instance
                            .collection('notes')
                            .doc(document.id)
                            .delete();
                      },
                      child: CardContent(
                        document['note'],
                      ),
                    ),
                  ]
                ],
              ),
            ),
          );
        });
  }
}

class CardContent extends StatelessWidget {
  const CardContent(
    this.note, {
    Key? key,
  }) : super(key: key);

  final String note;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25),
      padding: const EdgeInsets.all(25),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/post.jpg'),
        ),
      ),
      child: Center(
        child: AutoSizeText(
          note,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 72, fontStyle: FontStyle.italic),
        ),
      ),
    );
  }
}
