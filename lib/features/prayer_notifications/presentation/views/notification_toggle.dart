import 'package:flutter/material.dart';
import 'package:islamic_app/core/functions/notification_prefresnces.dart';
import 'package:islamic_app/features/settings/presentation/views/widgets/setting_item.dart';

class NotificationToggle extends StatefulWidget {
  const NotificationToggle({super.key});

  @override
  _NotificationToggleState createState() => _NotificationToggleState();
}

class _NotificationToggleState extends State<NotificationToggle> {
  bool _enabled = true;

  @override
  void initState() {
    super.initState();
    NotificationPrefs.isEnabled().then(
      (value) => setState(() {
        _enabled = value;
      }),
    );
  }

  void _toggle(bool value) async {
    setState(() => _enabled = value);
    await NotificationPrefs.setEnabled(value);
  }

  @override
  Widget build(BuildContext context) {
    return SettingItem(
      title: 'اشعارات الصلاة',
      widget: Switch(value: _enabled, onChanged: _toggle),
    );
  }
}
