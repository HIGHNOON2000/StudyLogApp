import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimerState {
  final Duration duration;
  final bool isRunning;

  // タイマー状態初期処理
  const TimerState({this.duration = Duration.zero, this.isRunning = false});

  // 新しいインスタンスを生成する
  // Riverpodのwatchは別のインスタンスに変わったことを検知して再描画を行うため
  TimerState copyWith({Duration? duration, bool? isRunning}) {
    return TimerState(
      duration: duration ?? this.duration,
      isRunning: isRunning ?? this.isRunning,
    );
  }
}

// タイマーの状態を管理するNotifier
class TimerNotifier extends Notifier<TimerState> {
  Timer? _timer;

  // buildイベントは生成時に一度だけ呼び出されるもの
  @override
  TimerState build() {
    // Notifierが破棄されるときにタイマーもキャンセルする
    ref.onDispose(() {
      _timer?.cancel();
    });
    // 初期状態を返す
    return const TimerState();
  }

  // タイマーの開始・停止を切り替える
  void toggleTimer() {
    if (state.isRunning) {
      _stopTimer();
    } else {
      _startTimer();
    }
  }

  // タイマーの開始
  void _startTimer() {
    if (state.isRunning) return;

    state = state.copyWith(isRunning: true);
    // 一秒ごとに処理を繰り返す
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      state = state.copyWith(
        duration: state.duration + const Duration(seconds: 1),
      );
    });
  }

  // タイマーの停止
  void _stopTimer() {
    _timer?.cancel();
    state = state.copyWith(isRunning: false);
  }

  // タイマーのリセット
  void resetTimer() {
    _stopTimer();
    // 初期状態に戻す
    state = const TimerState();
  }
}

// タイマーの状態を管理するProvider
final timerProvider = NotifierProvider<TimerNotifier, TimerState>(
  // new == () => TimerNotifier()と同等の機能
  TimerNotifier.new,
);
