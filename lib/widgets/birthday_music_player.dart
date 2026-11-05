import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:audioplayers/audioplayers.dart';

class BirthdayMusicPlayer extends StatefulWidget {
  final bool autoStart;
  final bool isCompact;

  const BirthdayMusicPlayer({
    super.key,
    this.autoStart = false,
    this.isCompact = false,
  });

  @override
  State<BirthdayMusicPlayer> createState() => BirthdayMusicPlayerState();
}

class BirthdayMusicPlayerState extends State<BirthdayMusicPlayer>
    with SingleTickerProviderStateMixin {
  late AudioPlayer _audioPlayer;
  late AnimationController _rotationController;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();

    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    );

    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (mounted) {
        setState(() {
          _isPlaying = state == PlayerState.playing;
          if (_isPlaying) {
            _rotationController.repeat();
          } else {
            _rotationController.stop();
          }
        });
      }
    });

    _audioPlayer.setReleaseMode(ReleaseMode.loop);

    if (widget.autoStart) {
      playMusic();
    }
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> playMusic() async {
    try {
      await _audioPlayer.play(AssetSource('audio/birthday_song.mp3'));
      if (mounted) {
        setState(() {
          _isPlaying = true;
          _rotationController.repeat();
        });
      }
    } catch (e) {
      debugPrint('Audio playback note: $e');
    }
  }

  Future<void> togglePlay() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await playMusic();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isCompact) {
      // Mobile-optimized Compact Spinning Disc Player (Zero clutter!)
      return GestureDetector(
        onTap: togglePlay,
        child: Container(
          width: 42,
          height: 42,
          alignment: Alignment.center,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              // Spinning Vinyl Disc
              RotationTransition(
                turns: _rotationController,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const RadialGradient(
                      colors: [
                        Color(0xFFFFD700),
                        Color(0xFF2B0A3D),
                        Colors.black,
                      ],
                    ),
                    border: Border.all(color: const Color(0xFFFFD700), width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: _isPlaying
                            ? const Color(0xFFFF007F).withValues(alpha: 0.6)
                            : Colors.black54,
                        blurRadius: _isPlaying ? 12 : 6,
                        spreadRadius: _isPlaying ? 1 : 0,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Container(
                      width: 15,
                      height: 15,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/images/photo_1.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Corner Play / Pause badge
              Positioned(
                right: -2,
                bottom: -2,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: _isPlaying ? const Color(0xFFFF2A6D) : const Color(0xFFFFD700),
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFF1B0B2E), width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.4),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: FaIcon(
                    _isPlaying ? FontAwesomeIcons.pause : FontAwesomeIcons.play,
                    color: _isPlaying ? Colors.white : Colors.black87,
                    size: 8,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Full Desktop Luxury Music Player
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1E0B33).withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: const Color(0xFFFFD700).withValues(alpha: 0.5),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF4081).withValues(alpha: 0.3),
            blurRadius: 16,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Spinning Vinyl Record
          GestureDetector(
            onTap: togglePlay,
            child: RotationTransition(
              turns: _rotationController,
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const RadialGradient(
                    colors: [
                      Color(0xFFFFD700),
                      Color(0xFF2B0A3D),
                      Colors.black,
                    ],
                  ),
                  border: Border.all(color: const Color(0xFFFFD700), width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFFD700).withValues(alpha: 0.4),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Center(
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/images/photo_1.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Song Info & Equalizer
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    'Happy Birthday Song',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const FaIcon(
                    FontAwesomeIcons.music,
                    color: Color(0xFFFFD700),
                    size: 11,
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  Text(
                    _isPlaying ? 'Playing Birthday Melody 🎶' : 'Tap to Play Birthday Music',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFFFF8DA1),
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 6),
                  if (_isPlaying) _buildEqualizer(),
                ],
              ),
            ],
          ),

          const SizedBox(width: 12),

          // Play / Pause Button
          IconButton(
            onPressed: togglePlay,
            tooltip: _isPlaying ? 'Pause Music' : 'Play Music',
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFFF2A6D),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFF2A6D).withValues(alpha: 0.5),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: FaIcon(
                _isPlaying ? FontAwesomeIcons.pause : FontAwesomeIcons.play,
                color: Colors.white,
                size: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEqualizer() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(4, (index) {
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 4.0, end: 14.0),
          duration: Duration(milliseconds: 300 + (index * 120)),
          builder: (context, val, child) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 1.2),
              width: 2.5,
              height: _isPlaying ? val : 3.0,
              decoration: BoxDecoration(
                color: const Color(0xFFFFD700),
                borderRadius: BorderRadius.circular(2),
              ),
            );
          },
        );
      }),
    );
  }
}
