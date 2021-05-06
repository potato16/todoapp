import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/src/core/navigation/route_information_parser.dart';
import 'package:todo_app/src/core/navigation/router_delegate.dart';
import 'package:todo_app/src/features/home/data/models/todo_model.dart';
import 'package:todo_app/src/features/home/presentation/notifiers/todolist_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  // Check list of added services on local

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Icon(Icons.add),
            onPressed: () {
              context
                  .read(seedRouterDelegateProvider)
                  .addPage(PageConfiguration.addTodo());
            }),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Todo List', style: Theme.of(context).textTheme.headline4),
              Flexible(
                child: Consumer(
                  builder: (BuildContext context,
                      T Function<T>(ProviderBase<Object?, T>) watch,
                      Widget? child) {
                    final data = watch(todoListProvider);
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final item = data.elementAt(index);
                          return TodoItemWidget(item: item);
                        });
                  },
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class TodoItemWidget extends StatelessWidget {
  const TodoItemWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Todo item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context
            .read(seedRouterDelegateProvider)
            .addPage(PageConfiguration.details(item.id));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
        ),
        child: Container(
          padding: const EdgeInsets.fromLTRB(0, 8, 16, 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: item.isDone ? Colors.purple.shade200 : Colors.grey.shade200,
          ),
          child: Row(
            children: [
              Checkbox(value: item.isDone, onChanged: (value) {}),
              Text(
                item.title,
                style: TextStyle(
                    decoration:
                        item.isDone ? TextDecoration.lineThrough : null),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
