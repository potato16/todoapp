import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final routeInformationParserProvider =
    Provider((ref) => SeedRouteInformationParser());

class SeedRouteInformationParser
    extends RouteInformationParser<PageConfiguration> {
  @override
  Future<PageConfiguration> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location ?? '');

    if (uri.pathSegments.isEmpty) {
      return const PageConfiguration.splash();
    }

    switch (uri.pathSegments.first) {
      case 'add_todo':
        return const PageConfiguration.addTodo();
      case 'details':
        if (uri.pathSegments.length == 2) {
          return PageConfiguration.details(uri.pathSegments.elementAt(1),
              state: routeInformation.state);
        } else {
          return const PageConfiguration.home();
        }
      case 'home':
        return const PageConfiguration.home();
      default:
        return const PageConfiguration.home();
    }
  }

  @override
  RouteInformation? restoreRouteInformation(PageConfiguration configuration) {
    return RouteInformation(
      location: configuration.path,
      state: configuration.state,
    );
  }
}

class PageConfiguration extends Equatable {
  const PageConfiguration({required this.path, this.state});

  const PageConfiguration.splash({this.state}) : path = '/';
  const PageConfiguration.home({this.state}) : path = '/home';
  const PageConfiguration.addTodo({this.state}) : path = '/add_todo';
  const PageConfiguration.details(String id, {this.state})
      : path = '/details/$id';

  final String path;
  final Object? state;

  @override
  List<Object?> get props => [path, state];
}
