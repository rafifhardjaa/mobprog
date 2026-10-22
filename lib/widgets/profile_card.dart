import 'package:flutter/material.dart';

const _cream = Color(0xFFF4F1E6);
const _muted = Color(0xFF9FB5A8);
const _soft = Color(0xFFC6D3C9);
const _brass = Color(0xFFD7A65B);
const _hairline = Color(0x1FF4F1E6);
const _sealInk = Color(0xFF18352C);
const _cardTop = Color(0xFF17362C);
const _cardBottom = Color(0xFF0D211B);

class ProfileCard extends StatefulWidget {
  const ProfileCard({
    super.key,
    required this.name,
    required this.role,
    required this.initials,
    required this.nim,
    required this.program,
    required this.angkatan,
    required this.validUntil,
  });

  final String name;
  final String role;
  final String initials;
  final String nim;
  final String program;
  final String angkatan;
  final String validUntil;

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey _surfaceKey = GlobalKey();
  final ValueNotifier<Offset> _tilt = ValueNotifier(Offset.zero);

  late final AnimationController _entrance;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;
  late final Animation<double> _sealScale;

  bool _started = false;

  @override
  void initState() {
    super.initState();
    _entrance = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 850),
    );
    _fade = CurvedAnimation(
      parent: _entrance,
      curve: const Interval(0, 0.55, curve: Curves.easeOut),
    );
    _slide = Tween(begin: const Offset(0, 0.055), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _entrance,
        curve: const Interval(0, 0.8, curve: Curves.easeOutCubic),
      ),
    );
    _sealScale = Tween(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(
        parent: _entrance,
        curve: const Interval(0.32, 1, curve: Curves.easeOutBack),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;

    if (MediaQuery.of(context).disableAnimations) {
      _entrance.value = 1;
    } else {
      _entrance.forward();
    }
  }

  @override
  void dispose() {
    _entrance.dispose();
    _tilt.dispose();
    super.dispose();
  }

  void _handlePointerMove(PointerMoveEvent event) {
    if (MediaQuery.of(context).disableAnimations) return;

    final box = _surfaceKey.currentContext?.findRenderObject();
    if (box is! RenderBox || !box.hasSize) return;

    final local = box.globalToLocal(event.position);
    final dx = (local.dx / box.size.width * 2 - 1).clamp(-1.0, 1.0);
    final dy = (local.dy / box.size.height * 2 - 1).clamp(-1.0, 1.0);
    _tilt.value = Offset(dx.toDouble(), dy.toDouble());
  }

  void _resetTilt() {
    _tilt.value = Offset.zero;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final nameSize = (constraints.maxWidth * 0.1)
            .clamp(33.0, 42.0)
            .toDouble();

        return FadeTransition(
          opacity: _fade,
          child: SlideTransition(
            position: _slide,
            child: Listener(
              onPointerMove: _handlePointerMove,
              onPointerUp: (_) => _resetTilt(),
              onPointerCancel: (_) => _resetTilt(),
              child: RepaintBoundary(
                child: Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: ValueListenableBuilder<Offset>(
                    valueListenable: _tilt,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        _buildSurface(nameSize),
                        Positioned(
                          top: -18,
                          right: 24,
                          child: ScaleTransition(
                            scale: _sealScale,
                            child: _Seal(initials: widget.initials),
                          ),
                        ),
                      ],
                    ),
                    builder: (context, tilt, child) {
                      return TweenAnimationBuilder<Offset>(
                        tween: Tween<Offset>(begin: Offset.zero, end: tilt),
                        duration: const Duration(milliseconds: 180),
                        curve: Curves.easeOutCubic,
                        child: child,
                        builder: (context, value, child) {
                          final matrix = Matrix4.identity()
                            ..setEntry(3, 2, 0.0014)
                            ..rotateX(-value.dy * 0.055)
                            ..rotateY(value.dx * 0.07);

                          return Transform(
                            transform: matrix,
                            alignment: Alignment.center,
                            child: child,
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSurface(double nameSize) {
    return Container(
      key: _surfaceKey,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_cardTop, _cardBottom],
        ),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.09),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0A1B16).withValues(alpha: 0.34),
            blurRadius: 52,
            spreadRadius: -12,
            offset: const Offset(0, 28),
          ),
          BoxShadow(
            color: const Color(0xFF0A1B16).withValues(alpha: 0.12),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: const Alignment(-0.9, -1.1),
                    radius: 1.25,
                    colors: [
                      Colors.white.withValues(alpha: 0.055),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 34,
            right: 34,
            child: Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0),
                    Colors.white.withValues(alpha: 0.26),
                    Colors.white.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(26, 25, 26, 22),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kartu anggota',
                  style: _sans(10, weight: 640, color: _muted, spacing: 1.9),
                ),
                const SizedBox(height: 16),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.name,
                    style: _display(
                      nameSize,
                      weight: 570,
                      height: 0.99,
                      spacing: -0.7,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  widget.role,
                  style: _sans(13, weight: 500, color: _soft, spacing: 0.1),
                ),
                const SizedBox(height: 22),
                Container(height: 1, color: _hairline),
                _InfoRow(label: 'NIM', value: widget.nim),
                _InfoRow(label: 'Program studi', value: widget.program),
                _InfoRow(
                  label: 'Angkatan',
                  value: widget.angkatan,
                  showDivider: false,
                ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Berlaku hingga',
                            style: _sans(
                              9,
                              weight: 600,
                              color: _muted,
                              spacing: 1.3,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            widget.validUntil,
                            style: _sans(12.5, weight: 550, color: _cream),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    const ExcludeSemantics(
                      child: SizedBox(
                        width: 104,
                        height: 26,
                        child: CustomPaint(painter: _Barcode()),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
    this.showDivider = true,
  });

  final String label;
  final String value;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 11),
      decoration: showDivider
          ? const BoxDecoration(
              border: Border(bottom: BorderSide(color: _hairline)),
            )
          : null,
      child: Row(
        children: [
          Text(
            label,
            style: _sans(10.5, weight: 600, color: _muted, spacing: 1.05),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: _sans(
                13,
                weight: 540,
                color: _cream,
                features: const [FontFeature.tabularFigures()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Seal extends StatelessWidget {
  const _Seal({required this.initials});

  final String initials;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _sealInk,
        border: Border.all(color: _brass.withValues(alpha: 0.62), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0A1B16).withValues(alpha: 0.32),
            blurRadius: 20,
            spreadRadius: -2,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Center(
        child: Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: _brass.withValues(alpha: 0.22)),
          ),
          child: Center(
            child: Text(
              initials,
              style: _display(17, weight: 620, color: _brass, spacing: 1.8),
            ),
          ),
        ),
      ),
    );
  }
}

class _Barcode extends CustomPainter {
  const _Barcode();

  static const _pattern = [
    2.0,
    1.0,
    1.5,
    3.0,
    1.0,
    2.0,
    1.0,
    1.0,
    2.5,
    1.0,
    1.0,
    2.0,
    3.5,
    1.0,
    2.0,
    1.0,
    1.5,
    2.0,
    1.0,
    3.0,
    1.0,
    1.5,
    2.5,
    1.0,
    2.0,
    1.0,
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = _cream.withValues(alpha: 0.34);
    var x = 0.0;

    for (var i = 0; i < _pattern.length && x < size.width; i++) {
      final width = _pattern[i];
      final height = size.height * (0.62 + ((i * 37) % 9) / 25);
      canvas.drawRect(
        Rect.fromLTWH(x, size.height - height, width, height),
        paint,
      );
      x += width + 2;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

TextStyle _sans(
  double size, {
  double weight = 500,
  Color color = _cream,
  double spacing = 0,
  List<FontFeature>? features,
}) {
  return TextStyle(
    fontFamily: 'Manrope',
    fontSize: size,
    height: 1.35,
    letterSpacing: spacing,
    color: color,
    fontFeatures: features,
    fontVariations: [FontVariation('wght', weight)],
  );
}

TextStyle _display(
  double size, {
  double weight = 560,
  Color color = _cream,
  double spacing = 0,
  double height = 1.1,
}) {
  return TextStyle(
    fontFamily: 'Fraunces',
    fontSize: size,
    height: height,
    letterSpacing: spacing,
    color: color,
    fontVariations: [
      FontVariation('wght', weight),
      const FontVariation('opsz', 48),
    ],
  );
}
