import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_it/pages/home/cubit/homepage_cubit.dart';

class HomePage extends StatelessWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomepageCubit, HomepageState>(builder: (context, state) {
      final itemModels = state.items;
      if (state.errorMessage.isNotEmpty) {
        return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/images/background.jpg'),
            ),
          ),
          child: Center(
            child: Container(
              margin: const EdgeInsets.all(100),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/post.jpg',
                  ),
                ),
              ),
              child: const AutoSizeText(
                'Coś poszło nie tak',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 72,
                ),
              ),
            ),
          ),
        );
      }

      if (state.isLoading == true) {
        return const Center(child: CircularProgressIndicator());
      }
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
                      context.read<HomepageCubit>().add(controller.text);
                      Navigator.of(context).pop();
                      controller.clear();
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
              for (final itemModel in itemModels) ...[
                Dismissible(
                  direction: DismissDirection.down,
                  key: ValueKey(itemModel.id),
                  onDismissed: (direction) {
                    context.read<HomepageCubit>().delete(itemModel.id);
                  },
                  child: CardContent(
                    itemModel.note,
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
          maxLines: 5,
          overflow: TextOverflow.clip,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 72, fontStyle: FontStyle.italic),
        ),
      ),
    );
  }
}
