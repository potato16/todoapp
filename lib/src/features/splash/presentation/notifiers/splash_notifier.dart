import 'package:flutter_riverpod/flutter_riverpod.dart';

final spashNotifyProvider = FutureProvider<bool>((ref) async {
  final stepOne = ref.watch(stepOneProvider);
  await stepOne.fetch();
  return true;
});

final stepOneProvider = Provider((ref) => StepOne());

class StepOne {
  Future<void> fetch() async {
    return;
  }
}
