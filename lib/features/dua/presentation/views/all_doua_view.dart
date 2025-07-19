import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/features/dua/presentation/manger/cubit/all_dua_cubit_cubit.dart';
import 'package:islamic_app/features/dua/presentation/views/widgets/dua_item.dart';

class AllDuaView extends StatelessWidget {
  const AllDuaView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllDuaCubitCubit, AllDuaCubitState>(
      builder: (context, state) {
        if (state is AllDuaCubitLoaded) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Theme.of(context).colorScheme.primary,
              ),
              title: Text(
                state.azkarModel.category ?? '',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                itemCount: state.azkarModel.array!.length,
                itemBuilder: (context, index) {
                  log(state.azkarModel.array!.first.isFavorite.toString());
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: index == state.azkarModel.array!.length - 1
                          ? 24
                          : 16,
                    ),
                    child: DuaItem(azkarArray: state.azkarModel.array![index]),
                  );
                },
              ),
            ),
          );
        } else {
          return Scaffold(body: CircularProgressIndicator());
        }
      },
    );
  }
}
