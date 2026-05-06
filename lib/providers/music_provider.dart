import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:melodex/models/song_model.dart';
import 'package:melodex/services/jamendo_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class MusicProvider extends ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();

  SongModel? _currentSong;
  List<SongModel> _queue = [];
  int _currentIndex = -1;
  bool _isPlaying = false;
  bool _isLoading = false;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  List<SongModel> _favorites = [];

  SongModel? get currentSong => _currentSong;
  List<SongModel> get queue => _queue;
  bool get isPlaying => _isPlaying;
  bool get isLoading => _isLoading;
  Duration get position => _position;
  Duration get duration => _duration;
  List<SongModel> get favorites => _favorites;
  AudioPlayer get player => _player;

  bool get hasPrevious => _currentIndex > 0;
  bool get hasNext => _currentIndex < _queue.length - 1;

  double get progress {
    if (_duration.inMilliseconds == 0) return 0;
    return _position.inMilliseconds / _duration.inMilliseconds;
  }

  MusicProvider() {
    _initListeners();
    _loadFavorites();
  }

  void _initListeners() {
    _player.playerStateStream.listen((state) {
      _isPlaying = state.playing;
      _isLoading =
          state.processingState == ProcessingState.loading ||
          state.processingState == ProcessingState.buffering;
      if (state.processingState == ProcessingState.completed) {
        playNext();
      }
      notifyListeners();
    });

    _player.positionStream.listen((pos) {
      _position = pos;
      notifyListeners();
    });

    _player.durationStream.listen((dur) {
      _duration = dur ?? Duration.zero;
      notifyListeners();
    });
  }

  Future<void> playSong(SongModel song, {List<SongModel>? queue}) async {
    if (queue != null) {
      _queue = queue;
      _currentIndex = queue.indexOf(song);
      if (_currentIndex == -1) {
        _queue.insert(0, song);
        _currentIndex = 0;
      }
    } else if (_currentSong?.id != song.id) {
      _queue = [song];
      _currentIndex = 0;
    }

    _currentSong = song;
    _isLoading = true;
    notifyListeners();

    try {
      await _player.setUrl(song.audioUrl);
      await _player.play();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> togglePlay() async {
    if (_player.playing) {
      await _player.pause();
    } else {
      await _player.play();
    }
  }

  Future<void> playNext() async {
    if (hasNext) {
      _currentIndex++;
      await playSong(_queue[_currentIndex]);
    }
  }

  Future<void> playPrevious() async {
    if (_position.inSeconds > 3) {
      await _player.seek(Duration.zero);
    } else if (hasPrevious) {
      _currentIndex--;
      await playSong(_queue[_currentIndex]);
    }
  }

  Future<void> seekTo(double value) async {
    final pos = Duration(
      milliseconds: (value * _duration.inMilliseconds).round(),
    );
    await _player.seek(pos);
  }

  // Favorites
  bool isFavorite(SongModel song) => _favorites.any((s) => s.id == song.id);

  Future<void> toggleFavorite(SongModel song) async {
    if (isFavorite(song)) {
      _favorites.removeWhere((s) => s.id == song.id);
    } else {
      _favorites.insert(0, song);
    }
    notifyListeners();
    await _saveFavorites();
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final data = _favorites.map((s) => jsonEncode(s.toJson())).toList();
    await prefs.setStringList('favorites', data);
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList('favorites') ?? [];
    _favorites = data.map((s) => SongModel.fromJson(jsonDecode(s))).toList();
    notifyListeners();
  }

  Future<void> loadFeaturedTracks() async {
    _isLoading = true;
    notifyListeners();
    try {
      _queue = await JamendoService.getFeatured();
      _currentIndex = -1;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> searchTracks(String query) async {
    _isLoading = true;
    notifyListeners();
    try {
      _queue = await JamendoService.searchSongs(query);
      _currentIndex = -1;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> clearSearch() async {
    await loadFeaturedTracks();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}
