import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

class MysteryGateScreen extends StatefulWidget {
  final VoidCallback onUnlock;

  const MysteryGateScreen({super.key, required this.onUnlock});

  @override
  State<MysteryGateScreen> createState() => _MysteryGateScreenState();
}

class _MysteryGateScreenState extends State<MysteryGateScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _scaleAnimation;

  int _selectedCoverIndex = 0;

  final List<Map<String, String>> _coverOptions = [
    {
      'path': 'assets/images/candle_sequence.gif',
      'label': 'Birthday Cake 🎂',
    },
    {
      'path': 'assets/images/festive_collage.png',
      'label': 'Festive Collage 🌸',
    },
    {
      'path': 'assets/images/candle_storyboard.gif',
      'label': 'Celebration ✨',
    },
    {
      'path': 'assets/images/photo_4.png',
      'label': 'Sweet Smile 💖',
    },
    {
      'path': 'assets/images/photo_2.png',
      'label': 'Graceful 💛',
    },
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.96, end: 1.04).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentCover = _coverOptions[_selectedCoverIndex];

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image with dark luxury gradient overlay
          Image.asset(
            'assets/images/bg_bokeh_gold.jpg',
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF140224).withValues(alpha: 0.88),
                  const Color(0xFF260538).withValues(alpha: 0.82),
                  const Color(0xFF0F011B).withValues(alpha: 0.94),
                ],
              ),
            ),
          ),

          // Content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 680),
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(36),
                    border: Border.all(
                      color: const Color(0xFFFFD700).withValues(alpha: 0.55),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.65),
                        blurRadius: 40,
                        spreadRadius: 8,
                      ),
                      BoxShadow(
                        color: const Color(0xFFFF007F).withValues(alpha: 0.28),
                        blurRadius: 60,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Crown & Mystery Badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFD700).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: const Color(0xFFFFD700).withValues(alpha: 0.7),
                            width: 1.2,
                          ),
                        ),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.crown,
                                color: Color(0xFFFFD700),
                                size: 15,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'A ROYAL BIRTHDAY SURPRISE 🔐',
                                style: GoogleFonts.cinzel(
                                  color: const Color(0xFFFFD700),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      Text(
                        'SPECIALLY DEDICATED TO',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.cinzel(
                          color: Colors.white70,
                          fontSize: 16,
                          letterSpacing: 4,
                        ),
                      ),
                      const SizedBox(height: 6),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Pathan Munni',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.greatVibes(
                            color: const Color(0xFFFF8DA1),
                            fontSize: 64,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                color: const Color(0xFFFF007F).withValues(alpha: 0.8),
                                blurRadius: 30,
                              ),
                              const Shadow(
                                color: Color(0xFFFFD700),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Center Royal Birthday Portrait & Animation
                      Center(
                        child: Stack(
                          alignment: Alignment.center,
                          clipBehavior: Clip.none,
                          children: [
                            // Glowing Ambient Radial Shadow
                            Container(
                              width: 250,
                              height: 270,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(32),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFFF007F).withValues(alpha: 0.5),
                                    blurRadius: 50,
                                    spreadRadius: 8,
                                  ),
                                  BoxShadow(
                                    color: const Color(0xFFFFD700).withValues(alpha: 0.35),
                                    blurRadius: 35,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                            ),

                            // Background Fireworks Lottie
                            Lottie.asset(
                              'assets/lottie/fireworks.json',
                              width: 300,
                              height: 300,
                              repeat: true,
                            ),

                            // Royal Framed Photo Card (Festive Animated Cake or Collage)
                            Container(
                              width: 220,
                              height: 260,
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(28),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFFFD700),
                                    Color(0xFFFF007F),
                                    Color(0xFFFFE082),
                                    Color(0xFFFF4081),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                border: Border.all(
                                  color: const Color(0xFFFFD700),
                                  width: 2.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.65),
                                    blurRadius: 25,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(24),
                                child: Image.asset(
                                  currentCover['path']!,
                                  fit: BoxFit.cover,
                                  width: 212,
                                  height: 252,
                                ),
                              ),
                            ),

                            // Crown Badge on Top
                            Positioned(
                              top: -14,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1B0B2E),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0xFFFFD700),
                                    width: 1.8,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFFFFD700).withValues(alpha: 0.6),
                                      blurRadius: 14,
                                    ),
                                  ],
                                ),
                                child: const FaIcon(
                                  FontAwesomeIcons.crown,
                                  color: Color(0xFFFFD700),
                                  size: 16,
                                ),
                              ),
                            ),

                            // Birthday Queen Pill Badge on Bottom
                            Positioned(
                              bottom: -12,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Color(0xFFFF007F), Color(0xFFFF4081)],
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: const Color(0xFFFFD700),
                                    width: 1.5,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFFFF007F).withValues(alpha: 0.6),
                                      blurRadius: 14,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  '🎂 Birthday Queen ✨',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Cover Photo Switcher Chips
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 8,
                        runSpacing: 8,
                        children: List.generate(_coverOptions.length, (index) {
                          final isSelected = index == _selectedCoverIndex;
                          final option = _coverOptions[index];

                          return GestureDetector(
                            onTap: () => setState(() => _selectedCoverIndex = index),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFFFF007F).withValues(alpha: 0.35)
                                    : Colors.white.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: isSelected ? const Color(0xFFFFD700) : Colors.white12,
                                  width: isSelected ? 1.4 : 1,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (isSelected) ...[
                                    const FaIcon(
                                      FontAwesomeIcons.solidHeart,
                                      color: Color(0xFFFF2A6D),
                                      size: 10,
                                    ),
                                    const SizedBox(width: 6),
                                  ],
                                  Text(
                                    option['label']!,
                                    style: GoogleFonts.poppins(
                                      color: isSelected ? Colors.white : Colors.white70,
                                      fontSize: 11,
                                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),

                      const SizedBox(height: 18),

                      Text(
                        'Someone who deeply cherishes you has crafted an interactive celebration journey filled with personal memories, festive blessings, and unforgettable moments.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 14,
                          height: 1.6,
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Pulsing Unlock Surprise Button
                      ScaleTransition(
                        scale: _scaleAnimation,
                        child: Container(
                          width: double.infinity,
                          constraints: const BoxConstraints(maxWidth: 420),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFFF007F),
                                Color(0xFFFF5E36),
                                Color(0xFFFFAE33),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFFF007F).withValues(alpha: 0.6),
                                blurRadius: 30,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: ElevatedButton.icon(
                            onPressed: widget.onUnlock,
                            icon: const FaIcon(
                              FontAwesomeIcons.wandMagicSparkles,
                              color: Colors.white,
                              size: 18,
                            ),
                            label: Text(
                              'Unwrap The Grand Surprise ✨',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const FaIcon(
                            FontAwesomeIcons.music,
                            color: Color(0xFFFFD700),
                            size: 12,
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              'Turn on sound for the best musical surprise experience 🎵',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                color: Colors.white60,
                                fontSize: 11.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
