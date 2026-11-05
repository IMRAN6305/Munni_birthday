import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import '../../models/memory_photo.dart';
import '../../widgets/photo_detail_dialog.dart';

class CollageChapter extends StatelessWidget {
  final VoidCallback onCelebrate;
  final VoidCallback onNextChapter;

  const CollageChapter({
    super.key,
    required this.onCelebrate,
    required this.onNextChapter,
  });

  void _openCollageZoom(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => PhotoDetailDialog(
        photo: MemoryPhoto(
          id: 'collage',
          imagePath: 'assets/images/festive_collage.png',
          title: 'Special Birthday Collage 🎂',
          caption:
              '“May all your dreams come true, May happiness always surround you, and may you achieve all your goals. Wishing you a very Happy Birthday! Stay Happy, Stay Blessed! 💖”',
          tag: 'Royal Card',
          likes: 312,
        ),
        onLikeToggled: onCelebrate,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final isWide = screenWidth > 880;

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.fromLTRB(
            isWide ? 32 : 16,
            16,
            isWide ? 32 : 16,
            100,
          ),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Chapter Header Badge
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFD700).withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: const Color(0xFFFFD700).withValues(alpha: 0.7),
                        ),
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.award,
                              color: Color(0xFFFFD700),
                              size: 13,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'CHAPTER 3 • THE GRAND FESTIVE TRIBUTE 🌸',
                              style: GoogleFonts.cinzel(
                                color: const Color(0xFFFFE082),
                                fontSize: 11.5,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    'ROYAL BIRTHDAY DEDICATION',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cinzel(
                      color: const Color(0xFFFFD700),
                      fontSize: 16,
                      letterSpacing: 4,
                    ),
                  ),
                  const SizedBox(height: 4),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'The Queen\'s Festive Collage',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.greatVibes(
                        color: const Color(0xFFFF8DA1),
                        fontSize: isWide ? 62 : 44,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Grand Golden Framed Card
                  Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF2C103F), Color(0xFF4A1054)],
                      ),
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(
                        color: const Color(0xFFFFD700),
                        width: 2.2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFFD700).withValues(alpha: 0.3),
                          blurRadius: 35,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Top Bar
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          child: Row(
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.crown,
                                color: Color(0xFFFFD700),
                                size: 18,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'Created With Heartfelt Love For Pathan Munni',
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.cinzel(
                                    color: Colors.white,
                                    fontSize: isWide ? 15 : 12.5,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () => _openCollageZoom(context),
                                tooltip: 'Expand Full Screen',
                                icon: const FaIcon(
                                  FontAwesomeIcons.expand,
                                  color: Color(0xFFFFD700),
                                  size: 16,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Collage Image
                        GestureDetector(
                          onTap: () => _openCollageZoom(context),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            constraints: BoxConstraints(
                              maxHeight: isWide ? 650 : 420,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.6),
                                  blurRadius: 25,
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  Image.asset(
                                    'assets/images/festive_collage.png',
                                    fit: BoxFit.contain,
                                    width: double.infinity,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(12),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withValues(
                                        alpha: 0.75,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: Colors.white24),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const FaIcon(
                                          FontAwesomeIcons.magnifyingGlassPlus,
                                          color: Colors.white,
                                          size: 12,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          'Tap to Zoom',
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Blessing text & Poem
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            children: [
                              Text(
                                '“May all your dreams come true, May happiness always surround you, and may you achieve all your goals. Wishing you a very Happy Birthday! Stay Happy, Stay Blessed!”',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.dancingScript(
                                  color: const Color(0xFFFFE57F),
                                  fontSize: isWide ? 22 : 18,
                                  fontWeight: FontWeight.bold,
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(height: 16),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Lottie.asset(
                                      'assets/lottie/fireworks.json',
                                      height: 44,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      'With Deepest Blessings, Love & Joy ❤️',
                                      style: GoogleFonts.cinzel(
                                        color: const Color(0xFFFFB3BA),
                                        fontSize: 12.5,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Next Chapter Forward Banner
                  GestureDetector(
                    onTap: onNextChapter,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 20,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF8E24AA),
                            Color(0xFFD81B60),
                            Color(0xFFFF8F00),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(26),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xFFD81B60,
                            ).withValues(alpha: 0.4),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'CONTINUE THE SURPRISE JOURNEY',
                                  style: GoogleFonts.cinzel(
                                    color: Colors.white70,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                                Text(
                                  'Chapter 4: The Secret Letter & Wishes Vault 💌',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          const CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 20,
                            child: FaIcon(
                              FontAwesomeIcons.arrowRight,
                              color: Color(0xFFD81B60),
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
