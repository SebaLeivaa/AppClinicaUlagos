import 'package:flutter/material.dart';
import '../theme/colors.dart';

class OlvideMiClaveScreen extends StatelessWidget {
  const OlvideMiClaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: AppColors.blue_900,
        body: Text(
          'HOLAAA',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 20,
          ),
        ));
  }
}
