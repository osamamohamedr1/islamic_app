import 'package:flutter/material.dart';
import 'package:islamic_app/features/dua/presentation/views/widgets/dua_item.dart';

class AllDuaView extends StatelessWidget {
  const AllDuaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
        title: Text(
          'جوامع الدعاء',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(spacing: 16, children: [DuaItem(), DuaItem()]),
      ),
    );
  }
}
