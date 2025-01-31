import 'package:brainly/providers/theme_provider.dart';
import 'package:brainly/themes/theme_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.maybePop(context);
            },
            icon: const Icon(Icons.clear),
          )
        ],
      ),
      body: Column(
        children: [
          Consumer<ThemeProvider>(
            // builder: (BuildContext context, value, Widget? child) {  },
            builder: (_, notifier, __) {
              bool _isSwitched = false;
              _isSwitched = notifier.isDark;
              return SwitchListTile(
                value: _isSwitched,
                onChanged: (value) {
                  ThemePreferences.saveTheme(isDark: _isSwitched);
                  Provider.of<ThemeProvider>(context, listen: false)
                      .setTheme(turnOn: _isSwitched);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
