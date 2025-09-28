// 目標時間を管理するProvider
import 'package:flutter_riverpod/legacy.dart';

final goalTimeProvider = StateProvider<double>((ref) {
  return 2.0;
});