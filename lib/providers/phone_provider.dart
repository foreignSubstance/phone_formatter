import 'package:flutter_riverpod/flutter_riverpod.dart';

final phoneProvider = StateProvider<String>((ref) => '');

final isPhoneValidProvider = Provider<bool>((ref) {
  final phone = ref.watch(phoneProvider);
  return phone.length == 14;
});
