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
  late PageController _pageController;
  @override
  void initState() {
    _pageController = PageController(initialPage: currentIndex);
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(controller: _pageController, children: getViews()),
      bottomNavigationBar: Directionality(
        textDirection: TextDirection.rtl,
        child: BottomNavigationBar(
          items: getItems(currentIndex),
          currentIndex: currentIndex,
          onTap: _onItemTapped,
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

List<Widget> getViews() => [
  const HomeView(),
  const QuranAudioView(),
  const SettingsView(),
];
