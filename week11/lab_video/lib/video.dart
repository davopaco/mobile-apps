class Video {
  int id;
  String title;
  String thumbnailUrl;
  String videoUrl;
  String duration;
  String size;

  Video(
      {required this.id,
      required this.title,
      required this.thumbnailUrl,
      required this.videoUrl,
      required this.duration,
      required this.size});

  factory Video.fromMap(Map<String, dynamic> snippet) {
    print(snippet);
    return Video(
      id: snippet['id'],
      title: snippet['title'],
      thumbnailUrl: snippet['thumbnail'],
      videoUrl: snippet['video'],
      duration: snippet['duration'],
      size: snippet['size'],
    );
  }
}
