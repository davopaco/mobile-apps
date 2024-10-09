import 'package:lab_video/video.dart';

class VideosRepo {
  Future<List<Video>> getVideos() async {
    List<Map<String, dynamic>> videosMap = [
      {
        'id': 1,
        'title': 'Countdown',
        'thumbnail':
            'https://videocdn.cdnpk.net/videos/24a82a25-0073-4fe6-b737-039ba3a0dcdc/horizontal/thumbnails/large.jpg?ga=GA1.1.1664462949.1728416678&item_id=172386',
        'video':
            'https://videocdn.cdnpk.net/videos/24a82a25-0073-4fe6-b737-039ba3a0dcdc/horizontal/previews/clear/large.mp4?token=exp=1728418227~hmac=02dab01aab07840fe8ef7917ca8ee288d0664cdc43299ba0370b7c3ef0aea3ec',
        'size': '20',
      },
      {
        'id': 2,
        'title': 'Woman Making a Pesebre',
        'thumbnail':
            'https://videocdn.cdnpk.net/videos/afb7708f-e86e-498d-ad08-399a088c0b0d/horizontal/thumbnails/large.jpg?ga=GA1.1.1664462949.1728416678&item_id=172726',
        'video':
            'https://videocdn.cdnpk.net/videos/afb7708f-e86e-498d-ad08-399a088c0b0d/horizontal/previews/clear/large.mp4?token=exp=1728419537~hmac=8ecfa78cf0b140cf7a0ab12a668c458fa8b4f58db9c82b1e32f3e5d70962da62',
        'size': '30',
      },
      {
        'id': 3,
        'title': 'Showing Presents',
        'thumbnail':
            'https://videocdn.cdnpk.net/videos/4b2fada2-736a-43ac-bf11-b086b72f42fa/horizontal/thumbnails/large.jpg?ga=GA1.1.1664462949.1728416678&item_id=2820278',
        'video':
            'https://videocdn.cdnpk.net/videos/4b2fada2-736a-43ac-bf11-b086b72f42fa/horizontal/previews/watermarked/large.mp4',
        'size': '40',
      },
      {
        'id': 4,
        'title': 'Sparkling Xmas Tree',
        'thumbnail':
            'https://videocdn.cdnpk.net/videos/edada415-e20b-4e5f-b5b9-bb9f1dd38bf4/horizontal/thumbnails/large.jpg?ga=GA1.1.1664462949.1728416678&item_id=90217',
        'video':
            'https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4',
        'size': '20',
      },
      {
        'id': 5,
        'title': 'Dancing to Tutaina',
        'thumbnail':
            'https://videocdn.cdnpk.net/videos/1b6250da-b0f3-4fc2-a170-200f8f9da29a/horizontal/thumbnails/large.jpg?ga=GA1.1.1664462949.1728416678&item_id=1741794',
        'video':
            'https://videocdn.cdnpk.net/videos/1b6250da-b0f3-4fc2-a170-200f8f9da29a/horizontal/previews/clear/large.mp4?token=exp=1728419668~hmac=f1f5898e02f964eb66208aa1dff5c45c0eccd595d71e8e2a83415b57239fef72',
        'size': '30',
      },
      {
        'id': 6,
        'title': 'Xmas Chocolates',
        'thumbnail':
            'https://videocdn.cdnpk.net/videos/1985c5b5-4f51-4cc6-aeca-8ed7322a9eb1/horizontal/thumbnails/large.jpg?ga=GA1.1.1664462949.1728416678&item_id=1873946',
        'video':
            'https://videocdn.cdnpk.net/videos/1985c5b5-4f51-4cc6-aeca-8ed7322a9eb1/horizontal/previews/watermarked/large.mp4',
        'size': '40',
      },
    ];
    List<Video> videos = [];
    // Appending video duration and size to each video
    for (Map<String, dynamic> video in videosMap) {
      video['duration'] = '';
      videos.add(Video.fromMap(video));
    }
    print(videos);
    return videos;
  }
}
