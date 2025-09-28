import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_log/application/goal_provider.dart';

class SettingScreen extends ConsumerWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goalTime = ref.watch(goalTimeProvider);
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
          _studyGoalValue(goalTime),
          const SizedBox(height: 64.0),

          // スライダー
          _sliderGoalValue(context, ref),
        ],
      ),
    );
  }

  //学習目標時間
  Widget _studyGoalValue(double goal) {
    return Center(
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: const Color(0xFFF0F2F5),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.blue.withAlpha(26), width: 2.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              goal.toInt().toString(),
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const Text(
              '時間',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  // 学習目標スライダー
  Widget _sliderGoalValue(BuildContext context, WidgetRef ref) {
    final goalTime = ref.watch(goalTimeProvider);
    final notifier = ref.read(goalTimeProvider.notifier);

    return Row(
      children: [
        _buttonGoalIconButton(Icons.remove, () {
          if (goalTime > 1) {
            notifier.state = goalTime - 1;
          }
        }),
        // スライダー本体
        Expanded(
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              thumbColor: Colors.blue, // スライダーのつまみの色
              activeTrackColor: Colors.blue, // つまみより左側のトラックの色
              inactiveTrackColor: Colors.grey[300], // つまみより右側のトラックの色
              trackHeight: 6.0,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
              overlayShape: SliderComponentShape.noOverlay,
            ),
            child: Slider(
              value: goalTime,
              min: 1, // 最小値
              max: 12, // 最大値 (仮に12時間に設定)
              divisions: 11, // 整数のみを選択できるように設定 (12 - 1 = 11)
              onChanged: (double newValue) {
                notifier.state = newValue;
              },
            ),
          ),
        ),
        _buttonGoalIconButton(Icons.add, () {
          if (goalTime < 12) {
            notifier.state = goalTime + 1;
          }
        }),
      ],
    );
  }

  // スライダーアイコンボタン
  Widget _buttonGoalIconButton(IconData icon, VoidCallback onPressed) {
    return Container(
      width: 48,
      height: 48,
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F2F5),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.withAlpha(26), width: 2.0),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.black),
        onPressed: onPressed,
      ),
    );
  }
}
