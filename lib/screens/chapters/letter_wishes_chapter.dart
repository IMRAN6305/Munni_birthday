import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import '../../models/memory_photo.dart';
import '../../widgets/wishes_section.dart';

class LetterWishesChapter extends StatefulWidget {
  final List<BirthdayWish> wishes;
  final Function(BirthdayWish) onWishAdded;
  final VoidCallback onCelebrate;
  final VoidCallback onRestartJourney;

  const LetterWishesChapter({
    super.key,
    required this.wishes,
    required this.onWishAdded,
    required this.onCelebrate,
    required this.onRestartJourney,
  });

  @override
  State<LetterWishesChapter> createState() => _LetterWishesChapterState();
}

class _LetterWishesChapterState extends State<LetterWishesChapter> {
  bool _letterOpened = false;

  void _openLetter() {
    setState(() => _letterOpened = true);
    widget.onCelebrate();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final isWide = screenWidth > 900;

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
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF4081).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: const Color(0xFFFF4081).withValues(alpha: 0.6),
                        ),
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.envelopeOpenText,
                              color: Color(0xFFFFD700),
                              size: 13,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'CHAPTER 4 • SECRET LETTER & GUESTBOOK VAULT 💌',
                              style: GoogleFonts.cinzel(
                                color: const Color(0xFFFFB3BA),
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
                    'WORDS WRITTEN FROM THE HEART',
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
                      'The Secret Love Letter',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.greatVibes(
                        color: const Color(0xFFFF8DA1),
                        fontSize: isWide ? 62 : 44,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Responsive 2-column on desktop, single column on mobile
                  if (isWide)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildSecretLetterCard()),
                        const SizedBox(width: 24),
                        Expanded(
                          child: WishesSection(
                            wishes: widget.wishes,
                            onWishAdded: widget.onWishAdded,
                          ),
                        ),
                      ],
                    )
                  else
                    Column(
                      children: [
                        _buildSecretLetterCard(),
                        const SizedBox(height: 20),
                        WishesSection(
                          wishes: widget.wishes,
                          onWishAdded: widget.onWishAdded,
                        ),
                      ],
                    ),

                  const SizedBox(height: 36),

                  // Replay Entire Journey Button
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E0B33).withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: const Color(0xFFFFD700).withValues(alpha: 0.6),
                        ),
                      ),
                      child: TextButton.icon(
                        onPressed: widget.onRestartJourney,
                        icon: const FaIcon(
                          FontAwesomeIcons.rotateRight,
                          color: Color(0xFFFFD700),
                          size: 15,
                        ),
                        label: Text(
                          'Replay The Surprise Journey From Beginning ↺',
                          style: GoogleFonts.poppins(
                            color: const Color(0xFFFFD700),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSecretLetterCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF380036), Color(0xFF190626)],
        ),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: const Color(0xFFFF4081).withValues(alpha: 0.5),
          width: 1.6,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF4081).withValues(alpha: 0.25),
            blurRadius: 25,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          if (!_letterOpened) ...[
            // Sealed State
            GestureDetector(
              onTap: _openLetter,
              child: Column(
                children: [
                  Lottie.asset(
                    'assets/lottie/envelope.json',
                    height: 200,
                    repeat: true,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'A Secret Sealed Envelope 💌',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.dancingScript(
                      color: const Color(0xFFFFD700),
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap the glowing envelope to break the seal and read your personal heartfelt birthday dedication!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: _openLetter,
                    icon: const FaIcon(
                      FontAwesomeIcons.envelopeOpen,
                      color: Colors.white,
                      size: 15,
                    ),
                    label: Text(
                      'Break Seal & Open Letter ✉️',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF2A6D),
                      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      elevation: 8,
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            // Opened Letter State
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const FaIcon(FontAwesomeIcons.solidHeart, color: Color(0xFFFF4081), size: 18),
                  const SizedBox(width: 10),
                  Text(
                    'Dearest Minni (Pathan Munni),',
                    style: GoogleFonts.dancingScript(
                      color: const Color(0xFFFFD700),
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const FaIcon(FontAwesomeIcons.solidHeart, color: Color(0xFFFF4081), size: 18),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: Colors.white12),
              ),
              child: Column(
                children: [
                  Text(
                    '“On this extraordinary day celebrating you, I want you to know how truly special and loved you are. Your presence lights up every moment, your laugh is contagious, and your kindness touches everyone around you. May this upcoming year be your happiest and most successful yet — filled with good health, accomplished ambitions, peaceful nights, and boundless blessings!”',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 14,
                      height: 1.7,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Stay Blessed, Stay Beautiful Forever ✨💖',
                    style: GoogleFonts.dancingScript(
                      color: const Color(0xFFFF8DA1),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            ElevatedButton.icon(
              onPressed: widget.onCelebrate,
              icon: const FaIcon(FontAwesomeIcons.champagneGlasses, color: Colors.white, size: 14),
              label: Text(
                'Celebrate With Confetti! 🎉',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF4081),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
