class PreviewResult {
  final String status;
  final String source;
  final String? imageBase64;
  final int? width;
  final int? height;
  final String? message;

  const PreviewResult({
    required this.status,
    required this.source,
    this.imageBase64,
    this.width,
    this.height,
    this.message,
  });

  factory PreviewResult.rendered({
    required String imageBase64,
    required int width,
    required int height,
    String? message,
  }) =>
      PreviewResult(
        status: 'rendered',
        source: 'flutter_render',
        imageBase64: imageBase64,
        width: width,
        height: height,
        message: message,
      );

  factory PreviewResult.failed({String? message}) => PreviewResult(
        status: 'failed',
        source: 'none',
        message: message,
      );

  factory PreviewResult.unavailable({String? message}) =>
      PreviewResult(
        status: 'unavailable',
        source: 'none',
        message: message,
      );

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
      };
}
