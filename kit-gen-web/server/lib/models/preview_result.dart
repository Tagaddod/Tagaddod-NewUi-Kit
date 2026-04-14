class PreviewResult {
  final String status;
  final String source;
  final String? imageBase64;
  final int? width;
  final int? height;
  final String? message;
  final String? previewUrl;

  const PreviewResult({
    required this.status,
    required this.source,
    this.imageBase64,
    this.width,
    this.height,
    this.message,
    this.previewUrl,
  });

  factory PreviewResult.livePreview({
    required String previewUrl,
    String? message,
  }) =>
      PreviewResult(
        status: 'live',
        source: 'widget_previewer',
        previewUrl: previewUrl,
        message: message,
      );

  factory PreviewResult.failed({String? message}) =>
      PreviewResult(status: 'failed', source: 'none', message: message);

  factory PreviewResult.unavailable({String? message}) =>
      PreviewResult(status: 'unavailable', source: 'none', message: message);

  factory PreviewResult.conceptFallback({
    required String imageBase64,
    String? message,
  }) =>
      PreviewResult(
        status: 'failed',
        source: 'concept',
        imageBase64: imageBase64,
        message: message,
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'source': source,
        'imageBase64': imageBase64,
        'width': width,
        'height': height,
        'message': message,
        'previewUrl': previewUrl,
      };
}
