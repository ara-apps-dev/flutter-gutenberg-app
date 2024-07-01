class Formats {
  final String? coverImage;
  final String? fileZip;
  final String? htmlText;
  final String? htmlTextUTF8;
  final String? plainTextUTF8;
  final String? plainTextUSASCII;

  Formats({
    this.coverImage,
    this.fileZip,
    this.htmlText,
    this.htmlTextUTF8,
    this.plainTextUSASCII,
    this.plainTextUTF8,
  });

  factory Formats.fromJson(Map<dynamic, dynamic> json) {
    return Formats(
      coverImage: json['image/jpeg'] ?? '',
      fileZip: json['application/octet-stream'] ?? '',
      htmlText: json['text/html'] ?? '',
      htmlTextUTF8: json['text/html; charset=utf-8'] ?? '',
      plainTextUSASCII: json['text/plain; charset=us-ascii'] ?? '',
      plainTextUTF8: json['text/plain; charset=utf-8'] ?? '',
    );
  }

  Map<dynamic, dynamic> toJson() => {
        "image/jpeg": coverImage,
        "application/octet-stream": fileZip,
        "text/html": htmlText,
        "text/html; charset=utf-8": htmlTextUTF8,
        "text/plain; charset=us-ascii": plainTextUSASCII,
        "text/plain; charset=utf-8": plainTextUTF8,
      };
}
