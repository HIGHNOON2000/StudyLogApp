import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_log/application/goal_provider.dart';
import 'package:study_log/application/timer_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // timerProviderを購読して変更を検知
    final timerState = ref.watch(timerProvider);
    // TimerProviderのインスタンス取得
    final notifier = ref.read(timerProvider.notifier);

    final goalTime = ref.watch(goalTimeProvider);

    // Durationを時分秒にフォーマット
    final hours = timerState.duration.inHours.toString().padLeft(2, '0');
    final minutes = (timerState.duration.inMinutes % 60).toString().padLeft(
      2,
      '0',
    );
    final seconds = (timerState.duration.inSeconds % 60).toString().padLeft(
      2,
      '0',
    );

    final achievedInHours = timerState.duration.inSeconds / 3600;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // タイマー表示部分
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _timeCard(hours, '時'),
                _timeCard(minutes, '分'),
                _timeCard(seconds, '秒'),
              ],
            ),
            SizedBox(height: 48),
            // 開始ボタン
            ElevatedButton(
              onPressed: () => notifier.toggleTimer(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Text(timerState.isRunning ? '停止' : '開始'),
            ),
            const SizedBox(height: 24),
            // 今日の学習時間
            _todayLearningTimeCard(hours, minutes, seconds),
            const SizedBox(height: 24),
            // 目標までの時間
            _targetLearningTimeCard(achievedInHours, goalTime),
          ],
        ),
      ),
    );
  }

  // 時間表示ウィジェット
  Widget _timeCard(String value, String label) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Center(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  // 今日の学習時間ウィジェット
  Widget _todayLearningTimeCard(String hours, String minutes, String seconds) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '今日の学習時間',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
            Text(
              '$hours時間 $minutes分 $seconds秒',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 目標までの時間ウィジェット
  Widget _targetLearningTimeCard(double achieved, double total) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '本日のゴール',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  '${(achieved / total * 100).toInt()}%',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            LinearProgressIndicator(
              value: achieved / total,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
              minHeight: 12.0,
              borderRadius: BorderRadius.circular(16.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              '${achieved}h / ${total}h',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}
