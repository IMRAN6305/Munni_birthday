import 'package:flutter/material.dart';

class MobileFrameWrapper extends StatefulWidget {
  final Widget child;

  const MobileFrameWrapper({super.key, required this.child});

  @override
  State<MobileFrameWrapper> createState() => _MobileFrameWrapperState();
}

class _MobileFrameWrapperState extends State<MobileFrameWrapper> {
  bool _forceFullScreen = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isLargeScreen = constraints.maxWidth > 540;

        if (!isLargeScreen || _forceFullScreen) {
          return Stack(
            children: [
              widget.child,
              if (isLargeScreen)
                Positioned(
                  top: 16,
                  right: 16,
                  child: _buildToggleBadge(
                    icon: Icons.phone_android,
                    label: 'Switch to Phone Frame',
                    onTap: () => setState(() => _forceFullScreen = false),
                  ),
                ),
            ],
          );
        }

        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF2A0845),
                  Color(0xFF6441A5),
                  Color(0xFFFE8C00),
                ],
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Background celebratory decorations
                ..._buildBackgroundDecorations(),

                // Phone Frame Mockup
                Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                    width: 420,
                    height: 860,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1A24),
                      borderRadius: BorderRadius.circular(48),
                      border: Border.all(
                        color: const Color(0xFFE2B771).withValues(alpha: 0.6),
                        width: 4,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.5),
                          blurRadius: 40,
                          spreadRadius: 8,
                          offset: const Offset(0, 16),
                        ),
                        BoxShadow(
                          color: const Color(0xFFFF69B4).withValues(alpha: 0.3),
                          blurRadius: 60,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(44),
                      child: Stack(
                        children: [
                          // App Content inside screen
                          widget.child,

                          // Smartphone Island / Speaker Notch
                          Positioned(
                            top: 10,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Container(
                                width: 120,
                                height: 26,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.1),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF1F1F35),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Container(
                                      width: 40,
                                      height: 4,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF333348),
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Top right control to toggle full screen on desktop
                Positioned(
                  top: 20,
                  right: 24,
                  child: _buildToggleBadge(
                    icon: Icons.fullscreen,
                    label: 'Expand Full Screen',
                    onTap: () => setState(() => _forceFullScreen = true),
                  ),
                ),

                // Desktop watermark / friendly hint
                Positioned(
                  bottom: 12,
                  child: Text(
                    '🎂 Munni\'s Birthday Celebration • Interactive Web & Mobile App',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 13,
                      letterSpacing: 1.1,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildToggleBadge({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.25),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 8,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: const Color(0xFFFFD700), size: 18),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildBackgroundDecorations() {
    return [
      Positioned(
        top: 60,
        left: 80,
        child: _buildFloatingIcon(Icons.cake_outlined, const Color(0xFFFF8DA1), 48),
      ),
      Positioned(
        bottom: 100,
        left: 100,
        child: _buildFloatingIcon(Icons.favorite, const Color(0xFFFF69B4), 56),
      ),
      Positioned(
        top: 120,
        right: 90,
        child: _buildFloatingIcon(Icons.auto_awesome, const Color(0xFFFFD700), 50),
      ),
      Positioned(
        bottom: 120,
        right: 110,
        child: _buildFloatingIcon(Icons.celebration, const Color(0xFFFFB347), 54),
      ),
    ];
  }

  Widget _buildFloatingIcon(IconData icon, Color color, double size) {
    return Opacity(
      opacity: 0.25,
      child: Icon(icon, color: color, size: size),
    );
  }
}

