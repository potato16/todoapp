import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/src/core/navigation/router_delegate.dart';
import 'package:todo_app/src/features/home/data/models/todo_model.dart';
import 'package:todo_app/src/features/home/presentation/notifiers/todo_business_provider.dart';

class TodoDetailsPage extends StatelessWidget {
  TodoDetailsPage({Key? key, this.id})
      : isCreateTask = id == null,
        super(key: key);
  final String? id;
  final bool isCreateTask;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Consumer(builder: (context, watch, child) {
            if (!isCreateTask) {
              final getTodo = watch(getTodoProvider(id!));
              return getTodo.when(
                  data: (data) {
                    return DetailsContentWidget(data: data);
                  },
                  loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                  error: (_, __) => const Center(
                          child: Text(
                        'Can not get this task',
                        style: TextStyle(color: Colors.red),
                      )));
            }
            return DetailsContentWidget();
          }),
        ),
      ),
    );
  }
}

class DetailsContentWidget extends StatefulWidget {
  const DetailsContentWidget({
    Key? key,
    this.data,
  }) : super(key: key);

  final Todo? data;

  @override
  _DetailsContentWidgetState createState() => _DetailsContentWidgetState();
}

class _DetailsContentWidgetState extends State<DetailsContentWidget> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  @override
  void initState() {
    titleController = TextEditingController(text: widget.data?.title ?? '');
    descriptionController =
        TextEditingController(text: widget.data?.description ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Center(
        child: Text(widget.data == null ? 'Create Task' : 'Task',
            style: Theme.of(context).textTheme.headline4),
      ),
      SizedBox(
        height: 24,
      ),
      Text(
        'Task title',
        style: Theme.of(context).textTheme.headline6,
      ),
      SizedBox(
        height: 8,
      ),
      TextField(controller: titleController),
      SizedBox(
        height: 24,
      ),
      Text(
        'Description',
        style: Theme.of(context).textTheme.headline6,
      ),
      SizedBox(
        height: 8,
      ),
      TextField(controller: descriptionController),
      SizedBox(
        height: 24,
      ),
      Text(
        'Task State',
        style: Theme.of(context).textTheme.headline6,
      ),
      Consumer(builder: (context, watch, child) {
        watch(todoBusinessProvider(widget.data));
        final notifier = watch(todoBusinessProvider(widget.data).notifier);
        return GestureDetector(
          onTap: () {
            notifier.updateStatus(!notifier.status);
          },
          child: Row(
            children: [
              Checkbox(
                  value: notifier.status,
                  onChanged: (value) {
                    notifier.updateStatus(value);
                  }),
              Text('Task is Done!')
            ],
          ),
        );
      }),
      const Spacer(),
      Row(
        children: [
          Expanded(
            child: ElevatedButton(
                onPressed: () {
                  final notifier =
                      context.read(todoBusinessProvider(widget.data).notifier);
                  if (widget.data == null) {
                    notifier
                        .addTodo(
                            title: titleController.text,
                            description: descriptionController.text)
                        .then((value) {
                      context.read(seedRouterDelegateProvider).popRoute();
                    });
                  } else {
                    notifier
                        .updateTodo(
                            title: titleController.text,
                            description: descriptionController.text)
                        .then((value) {
                      context.read(seedRouterDelegateProvider).popRoute();
                    });
                  }
                },
                child: Text(widget.data == null ? 'Create' : 'Update')),
          ),
          if (widget.data != null)
            IconButton(
                icon: Icon(
                  Icons.delete,
                ),
                onPressed: () {
                  final notifier =
                      context.read(todoBusinessProvider(widget.data).notifier);
                  notifier.deleteTodo().then((value) {
                    context.read(seedRouterDelegateProvider).popRoute();
                  });
                })
        ],
      ),
    ]);
  }
}
