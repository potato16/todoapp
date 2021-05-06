import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/src/core/navigation/route_information_parser.dart';
import 'package:todo_app/src/core/navigation/router_delegate.dart';
import 'package:todo_app/src/features/splash/presentation/notifiers/splash_notifier.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //comment
    return Scaffold(
      body: Center(
        child: Consumer(builder: (context, watch, child) {
          final AsyncValue<bool> splashNotify = watch(spashNotifyProvider);
          return splashNotify.when(data: (bool value) {
            scheduleMicrotask(() {
              final pageManager = context.read(seedRouterDelegateProvider);
              if (value) {
                pageManager.addPage(const PageConfiguration.home());
              }
            });
            return Container();
          }, error: (Object error, StackTrace? stackTrace) {
            return const Text(
              'Something went wrong',
              style: TextStyle(
                color: Colors.red,
              ),
            );
          }, loading: () {
            return const CircularProgressIndicator();
          });
        }),
      ),
    );
  }
}
