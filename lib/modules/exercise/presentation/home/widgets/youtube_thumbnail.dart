String youtubeThumbnail(String url) {
  if (url.isEmpty) return '';

  final uri = Uri.tryParse(url);
  if (uri == null) return '';

  String? videoId;

  if (uri.host.contains('youtu.be')) {
    videoId = uri.pathSegments.isNotEmpty ? uri.pathSegments.first : null;
  } else if (uri.pathSegments.contains('embed')) {
    final embedIndex = uri.pathSegments.indexOf('embed');
    if (embedIndex + 1 < uri.pathSegments.length) {
      videoId = uri.pathSegments[embedIndex + 1];
    }
  } else {
    videoId = uri.queryParameters['v'];
  }

  if (videoId == null || videoId.isEmpty) {
    return '';
  }

  return 'https://i.ytimg.com/vi/$videoId/maxresdefault.jpg';
}
