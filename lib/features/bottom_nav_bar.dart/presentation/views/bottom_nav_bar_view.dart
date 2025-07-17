import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:islamic_app/core/themes/colors_manger.dart';
import 'package:islamic_app/core/utils/assets.dart';
import 'package:islamic_app/features/home/presentation/views/home_view.dart';
import 'package:islamic_app/features/quran_audio/presentation/views/quran_audio.dart';
import 'package:islamic_app/features/settings/presentation/views/settings_view.dart';

class BottomNavBarView extends StatefulWidget {
  const BottomNavBarView({super.key});

  @override
  State<BottomNavBarView> createState() => _BottomNavBarViewState();
}

class _BottomNavBarViewState extends State<BottomNavBarView> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: [HomeView(), QuranAudioView(), SettingsView()],
      ),
      bottomNavigationBar: Directionality(
        textDirection: TextDirection.rtl,
        child: BottomNavigationBar(
          items: getItems(currentIndex),
          currentIndex: currentIndex,
          onTap: (value) {
            currentIndex = value;
            setState(() {});
          },
        ),
      ),
    );
  }
}

List<BottomNavigationBarItem> getItems(currentIndex) => [
  BottomNavigationBarItem(
    icon: SvgPicture.asset(
      Assets.svgsHome,
      width: 30,
      colorFilter: ColorFilter.mode(
        currentIndex == 0 ? ColorsManger.primary : Colors.grey,
        BlendMode.srcIn,
      ),
    ),
    label: 'الرئيسية',
  ),
  BottomNavigationBarItem(
    icon: Icon(FontAwesomeIcons.headphonesSimple),
    label: 'القرآن الكريم',
  ),
  BottomNavigationBarItem(
    icon: Icon(FontAwesomeIcons.gear),
    label: 'الإعدادات',
  ),
];
