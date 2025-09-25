import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingScreen extends ConsumerWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 32),
          const Text(
            '毎日の目標学習時間を設定',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 48),

          // 目標時間表示部分
          _StudyGoalValue(),
          // スライダー
        ],
      ),
    );
  }

  Widget _StudyGoalValue() {
    return Center(
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: const Color(0xFFF0F2F5),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.blue.withAlpha(26), width: 2.0),
        ),
      ),
    );
  }
}
