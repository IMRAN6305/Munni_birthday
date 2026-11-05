class MemoryPhoto {
  final String id;
  final String imagePath;
  final String title;
  final String caption;
  final String tag;
  int likes;
  bool isLiked;

  MemoryPhoto({
    required this.id,
    required this.imagePath,
    required this.title,
    required this.caption,
    required this.tag,
    this.likes = 0,
    this.isLiked = false,
  });
}

class BirthdayWish {
  final String sender;
  final String message;
  final String time;
  final String avatarEmoji;

  BirthdayWish({
    required this.sender,
    required this.message,
    required this.time,
    required this.avatarEmoji,
  });
}

