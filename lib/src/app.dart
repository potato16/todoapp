import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'common/providers/theme_provider.dart';
import 'core/navigation/route_information_parser.dart';
import 'core/navigation/router_delegate.dart';

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final SeedRouterDelegate routerDelegate = watch(seedRouterDelegateProvider);
    final backButtonDispatcher =
        watch(backButtonDispatcherProvider(routerDelegate));
    final SeedRouteInformationParser routeInformationParser =
        watch(routeInformationParserProvider);
    return Consumer(
      builder: (BuildContext context,
          T Function<T>(ProviderBase<Object?, T>) watch, Widget? child) {
        final ThemeData theme = watch(themeProvider).state;
        return MaterialApp.router(
          routerDelegate: routerDelegate,
          routeInformationParser: routeInformationParser,
          debugShowCheckedModeBanner: false,
          backButtonDispatcher: backButtonDispatcher,
          theme: theme,
        );
      },
    );
  }
}

class SomethingWentWrongWidget extends StatelessWidget {
  const SomethingWentWrongWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
