extension YoutubeExtension on String {
  String get youtubeId {
    final regExp = RegExp(
      r'(?:youtu\.be/|youtube\.com(?:/embed/|watch\?v=))([^?&]+)',
    );

    return regExp.firstMatch(this)?.group(1) ?? '';
  }

  String get thumbnailUrl {
    if (youtubeId.isEmpty) return '';

    return 'https://img.youtube.com/vi/$youtubeId/maxresdefault.jpg';
  }
}
