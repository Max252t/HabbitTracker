import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habbit_tracker/blocs/habits/habits_bloc.dart';
import 'package:habbit_tracker/data/habits_repository.dart';
import 'package:habbit_tracker/pages/ui/app/habits_list_page.dart';
import 'package:habbit_tracker/pages/ui/app/map_page.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;

  final _pages = const [
    HabitsListPage(),
    MapPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<HabitsRepository>(
      create: (_) => InMemoryHabitsRepository(),
      child: BlocProvider(
        create: (ctx) => HabitsBloc(repo: ctx.read<HabitsRepository>())
          ..add(const HabitsStarted()),
        child: Builder(
          builder: (context) {
            return Scaffold(
              extendBody: true,
              body: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/backround_sign.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SafeArea(
                  child: IndexedStack(
                    index: _index,
                    children: _pages,
                  ),
                ),
              ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: BottomNavigationBar(
                    currentIndex: _index,
                    onTap: (value) => setState(() => _index = value),
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: Colors.white.withValues(alpha: 0.92),
                    selectedItemColor: const Color(0xFF8E97FD),
                    unselectedItemColor: const Color(0xFF3F414E),
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.list_alt_rounded),
                        label: 'Список',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.map_outlined),
                        label: 'Карта',
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
