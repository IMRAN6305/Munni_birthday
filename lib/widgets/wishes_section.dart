import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/memory_photo.dart';

class WishesSection extends StatefulWidget {
  final List<BirthdayWish> wishes;
  final Function(BirthdayWish) onWishAdded;

  const WishesSection({
    super.key,
    required this.wishes,
    required this.onWishAdded,
  });

  @override
  State<WishesSection> createState() => _WishesSectionState();
}

class _WishesSectionState extends State<WishesSection> {
  final _nameController = TextEditingController();
  final _messageController = TextEditingController();
  String _selectedEmoji = '🌸';

  final List<String> _emojiOptions = ['🌸', '✨', '🎂', '💖', '👑', '🎉', '🌟', '💐'];

  @override
  void dispose() {
    _nameController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitWish() {
    final name = _nameController.text.trim();
    final message = _messageController.text.trim();

    if (name.isEmpty || message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter both your name and wish!',
            style: GoogleFonts.poppins(),
          ),
          backgroundColor: Colors.pinkAccent,
        ),
      );
      return;
    }

    final newWish = BirthdayWish(
      sender: name,
      message: message,
      time: 'Just now',
      avatarEmoji: _selectedEmoji,
    );

    widget.onWishAdded(newWish);
    _nameController.clear();
    _messageController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Your wish has been posted to the wall! 💖',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: const Color(0xFFC51162),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1035).withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFFFB3BA).withValues(alpha: 0.35),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.favorite_rounded, color: Color(0xFFFF4081), size: 24),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Wishes & Blessings Wall',
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.playfairDisplay(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Leave a warm birthday wish for Minni below:',
            style: GoogleFonts.poppins(
              color: Colors.white60,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 16),

          // Input form
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Sender name field
                TextField(
                  controller: _nameController,
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 13),
                  decoration: InputDecoration(
                    hintText: 'Your Name / Nickname',
                    hintStyle: GoogleFonts.poppins(color: Colors.white38, fontSize: 13),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    filled: true,
                    fillColor: Colors.black.withValues(alpha: 0.25),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Message field
                TextField(
                  controller: _messageController,
                  maxLines: 2,
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 13),
                  decoration: InputDecoration(
                    hintText: 'Write your heartfelt message here...',
                    hintStyle: GoogleFonts.poppins(color: Colors.white38, fontSize: 13),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    filled: true,
                    fillColor: Colors.black.withValues(alpha: 0.25),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Emoji picker row & Submit button
                Row(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: _emojiOptions.map((emoji) {
                            final isSelected = emoji == _selectedEmoji;
                            return GestureDetector(
                              onTap: () => setState(() => _selectedEmoji = emoji),
                              child: Container(
                                margin: const EdgeInsets.only(right: 6),
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFFFF4081).withValues(alpha: 0.4)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: isSelected ? const Color(0xFFFF4081) : Colors.transparent,
                                  ),
                                ),
                                child: Text(emoji, style: const TextStyle(fontSize: 18)),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: _submitWish,
                      icon: const Icon(Icons.send_rounded, size: 14),
                      label: Text(
                        'Post Wish',
                        style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF4081),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),

          // Wishes list
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.wishes.length,
            separatorBuilder: (_, _) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final wish = widget.wishes[index];
              return Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.08),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: const Color(0xFF6A1B9A).withValues(alpha: 0.4),
                      child: Text(wish.avatarEmoji, style: const TextStyle(fontSize: 18)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                wish.sender,
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFFFFD700),
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                wish.time,
                                style: GoogleFonts.poppins(
                                  color: Colors.white38,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            wish.message,
                            style: GoogleFonts.poppins(
                              color: Colors.white.withValues(alpha: 0.88),
                              fontSize: 12.5,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
