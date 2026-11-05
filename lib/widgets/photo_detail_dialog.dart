import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/memory_photo.dart';

class PhotoDetailDialog extends StatefulWidget {
  final MemoryPhoto photo;
  final VoidCallback onLikeToggled;

  const PhotoDetailDialog({
    super.key,
    required this.photo,
    required this.onLikeToggled,
  });

  @override
  State<PhotoDetailDialog> createState() => _PhotoDetailDialogState();
}

class _PhotoDetailDialogState extends State<PhotoDetailDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _heartAnimController;
  late Animation<double> _heartScaleAnimation;
  bool _showBurstHeart = false;

  @override
  void initState() {
    super.initState();
    _heartAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _heartScaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.4), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.4, end: 1.0), weight: 50),
    ]).animate(
      CurvedAnimation(
        parent: _heartAnimController,
        curve: Curves.easeOutBack,
      ),
    );
  }

  @override
  void dispose() {
    _heartAnimController.dispose();
    super.dispose();
  }

  void _triggerHeartBurst() {
    widget.onLikeToggled();
    setState(() => _showBurstHeart = true);
    _heartAnimController.forward(from: 0.0).then((_) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) setState(() => _showBurstHeart = false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 420, maxHeight: 720),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF2C1654),
                Color(0xFF1B0E33),
              ],
            ),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: const Color(0xFFFFB3BA).withValues(alpha: 0.5),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.7),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top Bar with Tag and Close Button
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 14, 12, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF69B4).withValues(alpha: 0.25),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFFFF69B4),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.auto_awesome,
                            color: Color(0xFFFFD700),
                            size: 14,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            widget.photo.tag,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded, color: Colors.white70),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),

              // Interactive Image Area
              Flexible(
                child: GestureDetector(
                  onDoubleTap: _triggerHeartBurst,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.4),
                              blurRadius: 15,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: InteractiveViewer(
                            panEnabled: true,
                            minScale: 0.8,
                            maxScale: 3.5,
                            child: Image.asset(
                              widget.photo.imagePath,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),

                      // Heart burst on double tap
                      if (_showBurstHeart)
                        ScaleTransition(
                          scale: _heartScaleAnimation,
                          child: const Icon(
                            Icons.favorite,
                            color: Color(0xFFFF2A6D),
                            size: 100,
                            shadows: [
                              Shadow(
                                color: Colors.black54,
                                blurRadius: 20,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // Photo Details and Actions
              Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.photo.title,
                            style: GoogleFonts.playfairDisplay(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            widget.onLikeToggled();
                            setState(() {});
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: widget.photo.isLiked
                                  ? const Color(0xFFFF2A6D).withValues(alpha: 0.25)
                                  : Colors.white.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: widget.photo.isLiked
                                    ? const Color(0xFFFF2A6D)
                                    : Colors.white24,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  widget.photo.isLiked
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: widget.photo.isLiked
                                      ? const Color(0xFFFF2A6D)
                                      : Colors.white,
                                  size: 18,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  '${widget.photo.likes}',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.photo.caption,
                      style: GoogleFonts.poppins(
                        color: Colors.white70,
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        '💡 Tip: Double tap photo or pinch to zoom',
                        style: GoogleFonts.poppins(
                          color: Colors.white38,
                          fontSize: 11,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
