import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:confetti/confetti.dart';
import '../models/memory_photo.dart';
import '../widgets/birthday_music_player.dart';
import 'mystery_gate_screen.dart';
import 'chapters/celebration_chapter.dart';
import 'chapters/memories_chapter.dart';
import 'chapters/collage_chapter.dart';
import 'chapters/letter_wishes_chapter.dart';

class BirthdayHomeScreen extends StatefulWidget {
  const BirthdayHomeScreen({super.key});

  @override
  State<BirthdayHomeScreen> createState() => _BirthdayHomeScreenState();
}

class _BirthdayHomeScreenState extends State<BirthdayHomeScreen> {
  late ConfettiController _confettiController;
  late PageController _pageController;
  final GlobalKey<BirthdayMusicPlayerState> _musicKey =
      GlobalKey<BirthdayMusicPlayerState>();

  bool _isUnlocked = false;
  int _currentChapter = 0;

  late List<MemoryPhoto> _photos;
  late List<BirthdayWish> _wishes;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 4),
    );
    _pageController = PageController(initialPage: 0);

    _photos = [
      MemoryPhoto(
        id: '1',
        imagePath: 'assets/images/photo_1.png',
        title: 'Radiant Sunshine 🌸',
        caption: 'A bright, peaceful smile that brings happiness to everyone.',
        tag: 'Sweet Smile',
        likes: 135,
      ),
      MemoryPhoto(
        id: '2',
        imagePath: 'assets/images/photo_2.png',
        title: 'Vibrant & Graceful 💛',
        caption: 'Bringing charm, brightness, and warmth to every moment.',
        tag: 'Grace',
        likes: 118,
      ),
      MemoryPhoto(
        id: '3',
        imagePath: 'assets/images/photo_3.png',
        title: 'Elegance in Maroon 💫',
        caption: 'Traditional elegance and timeless beauty.',
        tag: 'Elegance',
        likes: 142,
      ),
      MemoryPhoto(
        id: '4',
        imagePath: 'assets/images/photo_4.png',
        title: 'Cherished Moments 💖',
        caption: 'A sweet smile that speaks kindness and happiness.',
        tag: 'Cherished',
        likes: 109,
      ),
      MemoryPhoto(
        id: '5',
        imagePath: 'assets/images/photo_5.png',
        title: 'Timeless Charm 🌺',
        caption: 'May peace and joy always illuminate your life.',
        tag: 'Charm',
        likes: 126,
      ),
      MemoryPhoto(
        id: '6',
        imagePath: 'assets/images/candle_storyboard.gif',
        title: 'Candle Light Celebration 🎂',
        caption: 'Surrounded by celebration lights, cake, and sweet hopes.',
        tag: 'Cake Time',
        likes: 180,
      ),
    ];

    _wishes = [
      BirthdayWish(
        sender: 'Best Friend',
        message:
            'Happy Birthday Minni! Wishing you endless happiness, good health, and smiles every single day!',
        time: 'Today',
        avatarEmoji: '🌸',
      ),
      BirthdayWish(
        sender: 'Family & Loved Ones',
        message:
            'May all your dreams come true and may this year bring you closer to all your aspirations. Stay blessed!',
        time: 'Today',
        avatarEmoji: '✨',
      ),
      BirthdayWish(
        sender: 'Special Well Wisher',
        message:
            'To the sweetest person, have a fantastic birthday filled with sweet memories, cake, and joy! 🎂🎉',
        time: 'Today',
        avatarEmoji: '💖',
      ),
    ];
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _triggerConfetti() {
    _confettiController.play();
  }

  void _goToChapter(int index) {
    setState(() => _currentChapter = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeInOutCubic,
    );
  }

  void _nextChapter() {
    if (_currentChapter < 3) {
      _goToChapter(_currentChapter + 1);
      _triggerConfetti();
    }
  }

  void _unlockSurprise() {
    setState(() => _isUnlocked = true);
    _triggerConfetti();
    // Auto start music after unboxing
    Future.delayed(const Duration(milliseconds: 400), () {
      _musicKey.currentState?.playMusic();
    });
  }

  void _restartJourney() {
    setState(() {
      _isUnlocked = false;
      _currentChapter = 0;
    });
    _pageController.jumpToPage(0);
  }

  @override
  Widget build(BuildContext context) {
    if (!_isUnlocked) {
      return MysteryGateScreen(onUnlock: _unlockSurprise);
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final isWide = screenWidth > 900;

        return Scaffold(
          backgroundColor: const Color(0xFF13091E),
          body: Stack(
            fit: StackFit.expand,
            children: [
              // Background Image with dark luxury gradient overlay
              Image.asset(
                'assets/images/bg_celebration.jpg',
                fit: BoxFit.cover,
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xFF1C072E).withValues(alpha: 0.92),
                      const Color(0xFF28073D).withValues(alpha: 0.88),
                      const Color(0xFF10021C).withValues(alpha: 0.96),
                    ],
                  ),
                ),
              ),

              // Main App Content
              SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    // Responsive Top Luxury Navbar
                    _buildTopHeader(isWide),

                    // Chapter Pages
                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: (idx) =>
                            setState(() => _currentChapter = idx),
                        physics: const BouncingScrollPhysics(),
                        children: [
                          CelebrationChapter(
                            onCelebrate: _triggerConfetti,
                            onNextChapter: _nextChapter,
                          ),
                          MemoriesChapter(
                            photos: _photos,
                            onCelebrate: _triggerConfetti,
                            onNextChapter: _nextChapter,
                          ),
                          CollageChapter(
                            onCelebrate: _triggerConfetti,
                            onNextChapter: _nextChapter,
                          ),
                          LetterWishesChapter(
                            wishes: _wishes,
                            onWishAdded: (wish) {
                              setState(() => _wishes.insert(0, wish));
                              _triggerConfetti();
                            },
                            onCelebrate: _triggerConfetti,
                            onRestartJourney: _restartJourney,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Confetti Overlay
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirection: pi / 2,
                  maxBlastForce: 20,
                  minBlastForce: 6,
                  emissionFrequency: 0.08,
                  numberOfParticles: 50,
                  gravity: 0.2,
                  colors: const [
                    Color(0xFFFF1493),
                    Color(0xFFFFD700),
                    Color(0xFF00FFFF),
                    Color(0xFFBA55D3),
                    Color(0xFFFF69B4),
                    Colors.white,
                  ],
                ),
              ),

              // Floating Bottom Navigation Dock (Optimized for Mobile/Tablet or Desktop Quick Navigation)
              Positioned(
                left: isWide ? 40 : 16,
                right: isWide ? 40 : 16,
                bottom: 16,
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 700),
                    child: _buildBottomNavigationDock(isWide),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Responsive Top Luxury Navbar
  Widget _buildTopHeader(bool isWide) {
    if (!isWide) {
      return _buildMobileHeader();
    }
    return _buildDesktopHeader();
  }

  // Mobile Top Navbar (Clean, Uncluttered, Beautiful!)
  Widget _buildMobileHeader() {
    final chapterNames = [
      'Chapter 1 • Celebration 🎂',
      'Chapter 2 • Memory Lane 📸',
      'Chapter 3 • Royal Tribute 🌸',
      'Chapter 4 • Secret Letter 💌',
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 6, 14, 6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          color: const Color(0xFF1B0B2E).withValues(alpha: 0.95),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: const Color(0xFFFFD700).withValues(alpha: 0.45),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Avatar with glowing gradient ring
            Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFFFF007F), Color(0xFFFFD700)],
                ),
              ),
              child: const CircleAvatar(
                radius: 19,
                backgroundImage: AssetImage('assets/images/photo_1.png'),
              ),
            ),
            const SizedBox(width: 10),

            // Queen Name & Chapter Title (Full space, never squashed!)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Pathan Munni 👑',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.greatVibes(
                      color: const Color(0xFFFFD700),
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: const Color(0xFFFF007F).withValues(alpha: 0.6),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    chapterNames[_currentChapter],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      color: const Color(0xFFFFB3BA),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // Compact Spinning Vinyl Record Player (Tap to play/pause!)
            BirthdayMusicPlayer(
              key: _musicKey,
              autoStart: false,
              isCompact: true,
            ),

            const SizedBox(width: 6),

            // Confetti Shower Button
            GestureDetector(
              onTap: _triggerConfetti,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF007F), Color(0xFFFF5E36)],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF007F).withValues(alpha: 0.5),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: const Center(
                  child: FaIcon(
                    FontAwesomeIcons.wandMagicSparkles,
                    color: Colors.white,
                    size: 13,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 4),

            // Lock Mystery Button
            IconButton(
              onPressed: _restartJourney,
              tooltip: 'Lock Mystery Vault',
              icon: const FaIcon(
                FontAwesomeIcons.lock,
                color: Colors.white38,
                size: 13,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 28, minHeight: 32),
            ),
          ],
        ),
      ),
    );
  }

  // Desktop Luxury Top Navbar
  Widget _buildDesktopHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF1B0B2E).withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: const Color(0xFFFFD700).withValues(alpha: 0.4),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            // Avatar with gold border
            Container(
              padding: const EdgeInsets.all(2.5),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFFFF69B4), Color(0xFFFFD700)],
                ),
              ),
              child: const CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/images/photo_1.png'),
              ),
            ),
            const SizedBox(width: 14),

            // Queen Name
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Pathan Munni\'s Birthday 👑',
                    style: GoogleFonts.greatVibes(
                      color: const Color(0xFFFFD700),
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Chapter ${_currentChapter + 1} of 4 • Royal Celebration Experience',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      color: const Color(0xFFFFB3BA),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            // Embedded Birthday Music Player
            BirthdayMusicPlayer(
              key: _musicKey,
              autoStart: false,
              isCompact: false,
            ),

            const SizedBox(width: 14),

            // Quick Lock Journey Button
            IconButton(
              icon: const FaIcon(
                FontAwesomeIcons.lock,
                color: Colors.white60,
                size: 16,
              ),
              tooltip: 'Lock Mystery Vault',
              onPressed: _restartJourney,
            ),

            // Confetti Cannon Button
            IconButton(
              onPressed: _triggerConfetti,
              tooltip: 'Shoot Confetti!',
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF4081).withValues(alpha: 0.3),
                  shape: BoxShape.circle,
                ),
                child: const FaIcon(
                  FontAwesomeIcons.wandMagicSparkles,
                  color: Color(0xFFFFD700),
                  size: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Floating Bottom Navigation Dock
  Widget _buildBottomNavigationDock(bool isWide) {
    final navItems = [
      {'icon': FontAwesomeIcons.cakeCandles, 'label': 'Celebrate'},
      {'icon': FontAwesomeIcons.images, 'label': 'Memories'},
      {'icon': FontAwesomeIcons.crown, 'label': 'Tribute'},
      {'icon': FontAwesomeIcons.envelopeOpenText, 'label': 'Secret Vault'},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1B0B2E).withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(35),
        border: Border.all(
          color: const Color(0xFFFFD700).withValues(alpha: 0.5),
          width: 1.4,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.65),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: const Color(0xFFFF2A6D).withValues(alpha: 0.3),
            blurRadius: 25,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(navItems.length, (index) {
          final isSelected = _currentChapter == index;
          final item = navItems[index];

          return GestureDetector(
            onTap: () => _goToChapter(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              padding: EdgeInsets.symmetric(
                horizontal: isSelected ? 18 : 10,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFFFF2A6D).withValues(alpha: 0.35)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFFFF2A6D)
                      : Colors.transparent,
                  width: 1.2,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FaIcon(
                    item['icon'] as FaIconData,
                    color: isSelected
                        ? const Color(0xFFFFD700)
                        : Colors.white60,
                    size: 16,
                  ),
                  if (isSelected) ...[
                    const SizedBox(width: 8),
                    Text(
                      item['label'] as String,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 12.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
