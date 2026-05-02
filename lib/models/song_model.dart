class SongModel {
  final String id;
  final String name;
  final String artistName;
  final String albumName;
  final String audioUrl;
  final String imageUrl;
  final int duration; // seconds
  final String genre;

  const SongModel({
    required this.id,
    required this.name,
    required this.artistName,
    required this.albumName,
    required this.audioUrl,
    required this.imageUrl,
    required this.duration,
    required this.genre,
  });

  factory SongModel.fromJamendo(Map<String, dynamic> json) {
    return SongModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? 'Unknown',
      artistName: json['artist_name'] ?? 'Unknown Artist',
      albumName: json['album_name'] ?? 'Unknown Album',
      audioUrl: json['audio'] ?? '',
      imageUrl: json['album_image'] ?? json['image'] ?? '',
      duration: json['duration'] ?? 0,
      genre: (json['musicinfo']?['tags']?['genres'] as List?)?.isNotEmpty == true
          ? json['musicinfo']['tags']['genres'][0]
          : 'Unknown',
    );
  }

  String get durationFormatted {
    final m = duration ~/ 60;
    final s = duration % 60;
    return '$m:${s.toString().padLeft(2, '0')}';
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'artistName': artistName,
        'albumName': albumName,
        'audioUrl': audioUrl,
        'imageUrl': imageUrl,
        'duration': duration,
        'genre': genre,
      };

  factory SongModel.fromJson(Map<String, dynamic> json) => SongModel(
        id: json['id'],
        name: json['name'],
        artistName: json['artistName'],
        albumName: json['albumName'],
        audioUrl: json['audioUrl'],
        imageUrl: json['imageUrl'],
        duration: json['duration'],
        genre: json['genre'],
      );

  @override
  bool operator ==(Object other) => other is SongModel && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
