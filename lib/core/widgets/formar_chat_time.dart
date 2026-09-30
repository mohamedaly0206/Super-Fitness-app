import 'package:easy_localization/easy_localization.dart';

String formatChatTime(DateTime dateTime) {
  final now = DateTime.now();

  if (dateTime.year == now.year &&
      dateTime.month == now.month &&
      dateTime.day == now.day) {
    return DateFormat('h:mm a').format(dateTime);
  }

  final yesterday = now.subtract(const Duration(days: 1));
  if (dateTime.year == yesterday.year &&
      dateTime.month == yesterday.month &&
      dateTime.day == yesterday.day) {
    return 'Yesterday';
  }

  if (now.difference(dateTime).inDays < 7) {
    return DateFormat('EEEE').format(dateTime); // Monday
  }

  return DateFormat('dd MMM').format(dateTime); // 25 Jul
}
