import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import '../../models/memory_photo.dart';
import '../../widgets/photo_detail_dialog.dart';

class MemoriesChapter extends StatefulWidget {
  final List<MemoryPhoto> photos;
  final VoidCallback onCelebrate;
  final VoidCallback onNextChapter;

  const MemoriesChapter({
    super.key,
    required this.photos,
    required this.onCelebrate,
    required this.onNextChapter,
  });

  @override
  State<MemoriesChapter> createState() => _MemoriesChapterState();
}

class _MemoriesChapterState extends State<MemoriesChapter> {
  int _activeStoryIndex = 0;

  void _openDetail(MemoryPhoto photo) {
    showDialog(
      context: context,
      builder: (_) => PhotoDetailDialog(
        photo: photo,
        onLikeToggled: () {
          setState(() {
            photo.isLiked = !photo.isLiked;
            photo.likes += photo.isLiked ? 1 : -1;
          });
          widget.onCelebrate();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final int crossAxisCount = screenWidth > 1000
            ? 3
            : screenWidth > 640
                ? 2
                : 2;

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.fromLTRB(
            screenWidth > 860 ? 32 : 16,
            16,
            screenWidth > 860 ? 32 : 16,
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
                        color: const Color(0xFF673AB7).withValues(alpha: 0.25),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: const Color(0xFF9575CD).withValues(alpha: 0.6),
                        ),
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.cameraRetro,
                              color: Color(0xFFFFD700),
                              size: 13,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'CHAPTER 2 • PRECIOUS MEMORIES & STORY REELS 📸',
                              style: GoogleFonts.cinzel(
                                color: const Color(0xFFD1C4E9),
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
                    'TIME CAPSULE OF JOY',
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
                      'Cherished Smile Moments',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.greatVibes(
                        color: const Color(0xFFFF8DA1),
                        fontSize: screenWidth > 860 ? 60 : 44,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Top Story Bubbles Row
                  SizedBox(
                    height: 104,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.photos.length,
                      itemBuilder: (context, index) {
                        final photo = widget.photos[index];
                        final isSelected = index == _activeStoryIndex;

                        return GestureDetector(
                          onTap: () {
                            setState(() => _activeStoryIndex = index);
                            _openDetail(photo);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: isSelected
                                        ? const LinearGradient(
                                            colors: [Color(0xFFFF007F), Color(0xFFFFD700)],
                                          )
                                        : const LinearGradient(
                                            colors: [Color(0xFF8A2BE2), Color(0xFFFF69B4)],
                                          ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFFFF007F).withValues(alpha: 0.4),
                                        blurRadius: 10,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: const Color(0xFF2A0A38),
                                    backgroundImage: AssetImage(photo.imagePath),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  photo.tag,
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Lottie Heart Tip Banner
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white12),
                    ),
                    child: Row(
                      children: [
                        Lottie.asset(
                          'assets/lottie/heart.json',
                          height: 42,
                          width: 42,
                          repeat: true,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Click or tap on any photo card to zoom into full resolution and tap ❤️ to send her love!',
                            style: GoogleFonts.poppins(
                              color: Colors.white.withValues(alpha: 0.85),
                              fontSize: 12.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Responsive Photo Grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.photos.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.74,
                    ),
                    itemBuilder: (context, index) {
                      final photo = widget.photos[index];

                      return GestureDetector(
                        onTap: () => _openDetail(photo),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E1035),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: const Color(0xFFFFB3BA).withValues(alpha: 0.25),
                              width: 1.2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.4),
                                blurRadius: 15,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.asset(
                                  photo.imagePath,
                                  fit: BoxFit.cover,
                                ),

                                // Bottom gradient caption
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(14, 28, 14, 12),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        colors: [
                                          Colors.black.withValues(alpha: 0.9),
                                          Colors.transparent,
                                        ],
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          photo.title,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              photo.tag,
                                              style: GoogleFonts.poppins(
                                                color: const Color(0xFFFFB3BA),
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                FaIcon(
                                                  photo.isLiked
                                                      ? FontAwesomeIcons.solidHeart
                                                      : FontAwesomeIcons.heart,
                                                  color: photo.isLiked
                                                      ? const Color(0xFFFF2A6D)
                                                      : Colors.white70,
                                                  size: 13,
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  '${photo.likes}',
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
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
                  ),

                  const SizedBox(height: 32),

                  // Next Chapter Forward Banner
                  GestureDetector(
                    onTap: widget.onNextChapter,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFE91E63), Color(0xFFFF4081), Color(0xFFFFD54F)],
                        ),
                        borderRadius: BorderRadius.circular(26),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFE91E63).withValues(alpha: 0.4),
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
                                  'Chapter 3: The Grand Festive Tribute 🌸',
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
                            child: FaIcon(FontAwesomeIcons.arrowRight,
                                color: Color(0xFFE91E63), size: 16),
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
