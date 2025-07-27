import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/features/choose_location/data/models/user_location_model.dart';
import 'package:islamic_app/features/choose_location/presentation/manger/cubit/user_location_cubit.dart';
import 'package:islamic_app/features/choose_location/presentation/views/widgets/choose_location_button.dart';
import 'package:islamic_app/features/choose_location/presentation/views/widgets/user_location_item.dart';

class ChooseLocationView extends StatefulWidget {
  const ChooseLocationView({super.key});

  @override
  State<ChooseLocationView> createState() => _ChooseLocationViewState();
}

class _ChooseLocationViewState extends State<ChooseLocationView> {
  UserLocationModel? _selectedLocation;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'اختر موقعك',
              style: theme.textTheme.titleMedium!.copyWith(fontSize: 22),
            ),
            Text(
              'اختر اقرب موقع لك لحساب مواقيت الصلاة',
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          BlocBuilder<UserLocationCubit, UserLocationState>(
            builder: (context, state) {
              if (state is LocationLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is LocationLoaded) {
                final cities = state.cities;
                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                  itemCount: cities.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final city = cities[index];
                    final isSelected =
                        _selectedLocation?.arabicName == city.arabicName;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedLocation = city;
                        });
                      },
                      child: UserLocationItem(
                        isSelected: isSelected,
                        theme: theme,
                        city: city,
                      ),
                    );
                  },
                );
              } else {
                return const Center(child: Text('حدث خطأ أثناء تحميل المدن'));
              }
            },
          ),

          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: ChooseLocationButton(
              theme: theme,
              selectedLocation: _selectedLocation,
            ),
          ),
        ],
      ),
    );
  }
}
