import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/profile_card.dart';

const _canvasTop = Color(0xFFF1F2EC);
const _canvasBottom = Color(0xFFDEE3DB);

class ProfileCardPage extends StatelessWidget {
  const ProfileCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: _canvasBottom,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: Stack(
          children: [
            const Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [_canvasTop, _canvasBottom],
                  ),
                ),
              ),
            ),
            const Positioned.fill(
              child: IgnorePointer(child: CustomPaint(painter: _DotField())),
            ),
            SafeArea(
              child: LayoutBuilder(
                builder: (context, viewport) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 28,
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: (viewport.maxHeight - 56).clamp(
                          0.0,
                          double.infinity,
                        ),
                      ),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 412),
                          child: const ProfileCard(
                            key: Key('profile-card'),
                            name: 'Rahman\nAr Rafif',
                            role: 'Mahasiswa Informatika',
                            initials: 'RAR',
                            nim: '2210512037',
                            program: 'Informatika',
                            angkatan: '2022',
                            validUntil: 'Juni 2027',
                          ),
                        ),
                      ),
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

class _DotField extends CustomPainter {
  const _DotField();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0x1217352C);
    const spacing = 27.0;
    const radius = 0.85;

    for (double y = spacing / 2; y < size.height; y += spacing) {
      for (double x = spacing / 2; x < size.width; x += spacing) {
        canvas.drawCircle(Offset(x, y), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
