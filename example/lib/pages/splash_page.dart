
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:mainform/pages/my_page.dart';
import 'package:mainform/main.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    try {
      final PackageInfo info = await PackageInfo.fromPlatform();
      packageVersion = info.version;
    } catch (_) {}
    await Future<void>.delayed(const Duration(seconds: 1));
    if (mounted) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder<void>(
          pageBuilder: (_, __, ___) => const MyPage(),
          transitionsBuilder: (_, Animation<double> a, __, Widget child) {
            return FadeTransition(opacity: a, child: child);
          },
          transitionDuration: const Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).canvasColor,
      child: Center(
        child: Hero(
          tag: 'LOGO',
          child: Image.asset('assets/flutter_candies_logo.png', width: 150.0),
        ),
      ),
    );
  }
}
