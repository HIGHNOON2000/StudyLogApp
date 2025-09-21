import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:study_log/presentation/home_screen.dart';

// 他の画面用のプレースホルダーウィジェット
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('履歴画面'));
  }
}

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('報告画面'));
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('設定画面'));
  }
}

// どのタブが選択されているかを管理するProvider
final selectedIndexProvider = StateProvider<int>((ref) {
  return 0;
});

class ShellScreen extends ConsumerWidget {
  const ShellScreen({super.key});

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    HistoryScreen(),
    ReportScreen(),
    SettingsScreen(),
  ];

  static const List<String> _appBarTitles = <String>[
    'Study Log',
    '履歴',
    '報告',
    '設定',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // selectedIndexProviderを購読
    final selectedIndex = ref.watch(selectedIndexProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitles[selectedIndex]),
        actions: selectedIndex == 0
            ? [
                IconButton(
                  icon: const Icon(Icons.settings, color: Colors.black),
                  // 設定ボタンクリックでタブを設定に切り替える
                  onPressed: () {
                    ref.read(selectedIndexProvider.notifier).state = 3;
                  },
                ),
              ]
            : null,
      ),
      body: _widgetOptions.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ホーム'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: '履歴'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: '報告'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: '設定'),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          ref.read(selectedIndexProvider.notifier).state = index;
        },
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
