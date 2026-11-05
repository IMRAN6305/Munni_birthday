import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:confetti/confetti.dart';

class GiftBoxDialog extends StatefulWidget {
  final VoidCallback onCelebrate;

  const GiftBoxDialog({super.key, required this.onCelebrate});

  @override
  State<GiftBoxDialog> createState() => _GiftBoxDialogState();
}

class _GiftBoxDialogState extends State<GiftBoxDialog>
    with SingleTickerProviderStateMixin {
  bool _isOpen = false;
  late AnimationController _boxAnimController;
  late Animation<double> _bounceAnimation;
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _boxAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _bounceAnimation = Tween<double>(begin: -6.0, end: 6.0).animate(
      CurvedAnimation(
        parent: _boxAnimController,
        curve: Curves.easeInOut,
      ),
    );

    _confettiController =
        ConfettiController(duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    _boxAnimController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  void _openGift() {
    if (_isOpen) return;
    setState(() => _isOpen = true);
    _boxAnimController.stop();
    _confettiController.play();
    widget.onCelebrate();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF380036),
                Color(0xFF0CBABA),
              ],
            ),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: const Color(0xFFFFD700).withValues(alpha: 0.6),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.6),
                blurRadius: 35,
                spreadRadius: 4,
              ),
            ],
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Confetti burst from gift
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirectionality: BlastDirectionality.explosive,
                  maxBlastForce: 25,
                  minBlastForce: 8,
                  emissionFrequency: 0.05,
                  numberOfParticles: 35,
                  gravity: 0.15,
                  colors: const [
                    Colors.pinkAccent,
                    Colors.amber,
                    Colors.cyanAccent,
                    Colors.purpleAccent,
                    Colors.white,
                  ],
                ),
              ),

              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Close button
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white70),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),

                  if (!_isOpen) ...[
                    // Closed Gift Box state
                    Text(
                      '🎁 A Special Gift For You! 🎁',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.dancingScript(
                        color: const Color(0xFFFFD700),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Someone has sent you a surprise message wrapped with lots of love!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Bouncing Gift Box Icon
                    AnimatedBuilder(
                      animation: _bounceAnimation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, _bounceAnimation.value),
                          child: child,
                        );
                      },
                      child: GestureDetector(
                        onTap: _openGift,
                        child: Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const RadialGradient(
                              colors: [
                                Color(0xFFFF4081),
                                Color(0xFFC51162),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFFF4081).withValues(alpha: 0.6),
                                blurRadius: 30,
                                spreadRadius: 4,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.card_giftcard,
                            color: Colors.white,
                            size: 80,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),

                    ElevatedButton.icon(
                      onPressed: _openGift,
                      icon: const Icon(Icons.touch_app, color: Colors.black87),
                      label: Text(
                        'Tap to Open Gift 🎁',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontSize: 15,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFD700),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        elevation: 8,
                      ),
                    ),
                    const SizedBox(height: 10),
                  ] else ...[
                    // Opened Gift Box state
                    const Icon(
                      Icons.celebration,
                      color: Color(0xFFFFD700),
                      size: 44,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Happy Birthday Minni! 🎂',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.dancingScript(
                        color: const Color(0xFFFFE57F),
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.35),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            '"On this beautiful day, may your heart be filled with boundless joy, peace, and warmth. You are an incredible person whose smile brightens every day. May all the dreams you hold close to your heart blossom into reality. Stay blessed, stay smiling, and have the most unforgettable birthday ever!"',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 13.5,
                              fontStyle: FontStyle.italic,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.favorite,
                                  color: Color(0xFFFF4081), size: 18),
                              const SizedBox(width: 8),
                              Text(
                                'With all best wishes & love ❤️',
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFFFFB3BA),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        _confettiController.play();
                        widget.onCelebrate();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF4081),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      child: Text(
                        'Celebrate More! 🎉',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

