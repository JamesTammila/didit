String formatTime(String date) {
  final DateTime dateTime = DateTime.parse(date);
  final Duration duration = DateTime.now().difference(dateTime);
  if (duration.inDays > 365) {
    final years = (duration.inDays / 365).floor();
    return '${years}y';
  } else if (duration.inDays > 30) {
    final months = (duration.inDays / 30).floor();
    return '${months}mo';
  } else if (duration.inDays > 7) {
    final weeks = (duration.inDays / 7).floor();
    return '${weeks}w';
  } else if (duration.inDays > 0) {
    return '${duration.inDays}d';
  } else if (duration.inHours > 0) {
    return '${duration.inHours}h';
  } else if (duration.inMinutes > 0) {
    return '${duration.inMinutes}m';
  } else {
    return 'now';
  }
}