String formatTime(String date) {
  final Duration duration = DateTime.now().difference(DateTime.parse(date));
  if (duration.inDays >= 7) {
    return 'Something went wrong...';
  } else if (duration.inDays > 0) {
    return '${duration.inDays} day${duration.inDays > 1 ? 's' : ''} ago';
  } else if (duration.inHours > 0) {
    return '${duration.inHours} hour${duration.inHours > 1 ? 's' : ''} ago';
  } else if (duration.inMinutes > 0) {
    return '${duration.inMinutes} minute${duration.inMinutes > 1 ? 's' : ''} ago';
  } else {
    return 'Just now';
  }
}