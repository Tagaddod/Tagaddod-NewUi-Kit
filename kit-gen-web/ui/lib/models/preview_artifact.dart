class PreviewArtifact {
  final String status;
  final String source;
  final String? imageBase64;
  final String? previewUrl;

  const PreviewArtifact({
    required this.status,
    required this.source,
    this.imageBase64,
    this.previewUrl,
  });

  bool get hasImage => imageBase64 != null && imageBase64!.isNotEmpty;
  bool get hasLivePreview => previewUrl != null && previewUrl!.isNotEmpty;

  factory PreviewArtifact.fromJson(Map<String, dynamic> json) =>
      PreviewArtifact(
        status: json['status'] as String? ?? 'unavailable',
        source: json['source'] as String? ?? 'none',
        imageBase64: json['imageBase64'] as String?,
        previewUrl: json['previewUrl'] as String?,
      );
}
