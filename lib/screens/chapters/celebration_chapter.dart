import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

class CelebrationChapter extends StatefulWidget {
  final VoidCallback onCelebrate;
  final VoidCallback onNextChapter;

  const CelebrationChapter({
    super.key,
    required this.onCelebrate,
    required this.onNextChapter,
  });

  @override
  State<CelebrationChapter> createState() => _CelebrationChapterState();
}

class _CelebrationChapterState extends State<CelebrationChapter> {
  bool _candlesBlown = false;

  void _blowCandles() {
    setState(() => _candlesBlown = true);
    widget.onCelebrate();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF2B0938),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
          side: const BorderSide(color: Color(0xFFFFD700), width: 1.8),
        ),
        title: Column(
          children: [
            Lottie.asset('assets/lottie/fireworks.json', height: 90, repeat: true),
            Text(
              '✨ Wish Sent to the Universe! ✨',
              textAlign: TextAlign.center,
              style: GoogleFonts.dancingScript(
                color: const Color(0xFFFFD700),
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Text(
          'Your birthday prayer has been received, Munni! May every day of this year shower you with laughter, blooming happiness, glowing good health, and success beyond your wildest dreams! 💖🎂🎉',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 14,
            height: 1.6,
          ),
        ),
        actions: [
          Center(
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.of(ctx).pop();
                widget.onNextChapter();
              },
              icon: const FaIcon(FontAwesomeIcons.images, color: Colors.white, size: 14),
              label: Text(
                'Explore Memory Lane 📸➜',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF2A6D),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 860;

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
                              FontAwesomeIcons.champagneGlasses,
                              color: Color(0xFFFFD700),
                              size: 14,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'CHAPTER 1 • THE GRAND ROYAL CELEBRATION 🎂',
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

                  // Calligraphy Title
                  Text(
                    'HAPPY BIRTHDAY TO OUR QUEEN',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cinzel(
                      color: const Color(0xFFFFD700),
                      fontSize: isWide ? 18 : 14,
                      letterSpacing: 4,
                    ),
                  ),
                  const SizedBox(height: 4),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Pathan Munni',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.greatVibes(
                        color: const Color(0xFFFF8DA1),
                        fontSize: isWide ? 68 : 50,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: const Color(0xFFFF007F).withValues(alpha: 0.7),
                            blurRadius: 30,
                          ),
                          const Shadow(
                            color: Color(0xFFFFD700),
                            blurRadius: 15,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Content Layout (Responsive 2-column on desktop, single column on mobile)
                  if (isWide)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildCakeLottieCard()),
                        const SizedBox(width: 24),
                        Expanded(child: _buildCandleBlowingCard()),
                      ],
                    )
                  else
                    Column(
                      children: [
                        _buildCakeLottieCard(),
                        const SizedBox(height: 20),
                        _buildCandleBlowingCard(),
                      ],
                    ),

                  const SizedBox(height: 32),

                  // Next Chapter Forward Banner
                  _buildNextChapterBanner(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCakeLottieCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF38084A), Color(0xFF6B117B)],
        ),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: const Color(0xFFFFD700).withValues(alpha: 0.5),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6B117B).withValues(alpha: 0.4),
            blurRadius: 25,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Lottie.asset(
                'assets/lottie/fireworks.json',
                height: 180,
                repeat: true,
              ),
              Lottie.asset(
                'assets/lottie/cake.json',
                height: 170,
                repeat: true,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Sweet Moments & Royal Celebration 👑',
            textAlign: TextAlign.center,
            style: GoogleFonts.playfairDisplay(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '“Wishing you a day as sunny as your smile, as warm as your heart, and as wonderful as you are to everyone in your life.”',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: Colors.white70,
              fontSize: 13,
              height: 1.5,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            runSpacing: 8,
            children: [
              _buildFeaturePill(FontAwesomeIcons.cakeCandles, 'Delicious Cake'),
              _buildFeaturePill(FontAwesomeIcons.music, 'Festive Beats'),
              _buildFeaturePill(FontAwesomeIcons.heart, 'Lots of Love'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturePill(FaIconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(icon, color: const Color(0xFFFFD700), size: 10),
          const SizedBox(width: 5),
          Text(
            label,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 10.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCandleBlowingCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF220935),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: const Color(0xFFFF69B4).withValues(alpha: 0.5),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.45),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const FaIcon(
                FontAwesomeIcons.cakeCandles,
                color: Color(0xFFFFD700),
                size: 18,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Blow The Candles & Make a Wish',
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.playfairDisplay(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Animated Candle Blowing GIF Sequence
          Container(
            height: 310,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/candle_sequence.gif',
                    fit: BoxFit.cover,
                  ),
                  if (_candlesBlown)
                    Container(
                      color: Colors.black.withValues(alpha: 0.4),
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.75),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: const Color(0xFFFFD700),
                              width: 1.5,
                            ),
                          ),
                          child: Text(
                            '🎉 Happy Birthday Minni! 🎉',
                            style: GoogleFonts.dancingScript(
                              color: const Color(0xFFFFD700),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Blow Candles Button
          ElevatedButton.icon(
            onPressed: _blowCandles,
            icon: FaIcon(
              _candlesBlown ? FontAwesomeIcons.rotateRight : FontAwesomeIcons.wandMagicSparkles,
              color: Colors.white,
              size: 15,
            ),
            label: Text(
              _candlesBlown ? 'Make Another Wish 🎂' : 'Blow Candles & Make a Wish 🎂✨',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF2A6D),
              minimumSize: const Size(double.infinity, 52),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
              elevation: 8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNextChapterBanner() {
    return GestureDetector(
      onTap: widget.onNextChapter,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF833AB4), Color(0xFFFD1D1D), Color(0xFFFCB045)],
          ),
          borderRadius: BorderRadius.circular(26),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFD1D1D).withValues(alpha: 0.4),
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
                    'Chapter 2: Memory Lane & Photo Reels 📸',
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
              child: FaIcon(FontAwesomeIcons.arrowRight, color: Color(0xFFFD1D1D), size: 16),
            ),
          ],
        ),
      ),
    );
  }
}
