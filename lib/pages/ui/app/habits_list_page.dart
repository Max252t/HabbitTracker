import 'package:flutter/material.dart';

class HabitsListPage extends StatelessWidget {
  const HabitsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Напоминалки',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF8E97FD),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Добавление напоминалки: скоро')),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.92),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: Color(0xFF3F414E)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Здесь будет список напоминалок. Каждая: название, время/даты, радиус и статус.',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: const Color(0xFF3F414E)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Expanded(
              child: ListView.separated(
                itemCount: 3,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.92),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: ListTile(
                      title: Text(
                        'Пример напоминалки #${index + 1}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: const Color(0xFF3F414E),
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      subtitle: Text(
                        'Время: 18:00 • Радиус: 150м • Статус: активна',
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(color: const Color(0xFF3F414E)),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline),
                        color: const Color(0xFF3F414E),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Удаление: скоро')),
                          );
                        },
                      ),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Редактирование: скоро')),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
