import 'dart:io';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({super.key});

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  bool _isLoading = false;
  final double _volume = 0.7; // Default volume level
  int _selectedStreamIndex = 0; // 0=rain, 1=electronic, 2=nature, 3=lofi

  // Audio stream URLs
  static const Map<int, String> _audioStreams = {
    0: 'https://tupanel.info:8000/stream?sid=1', // Electronic

    1: 'https://live.proradiosonline.com/listen/lofi_radio/aac', // Lofi
  };

  // Stream labels
  static const Map<int, String> _streamLabels = {0: 'Electro', 1: 'Lofi'};

  // Current audio URL
  late String _audioUrl;

  @override
  void initState() {
    super.initState();
    _setupAudioPlayer();
    _audioPlayer.setVolume(_volume);

    _audioUrl = _audioStreams[_selectedStreamIndex] ?? '';
  }

  void _setupAudioPlayer() {
    // Set up audio player event handlers
    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (mounted) {
        setState(() {
          _isPlaying = state == PlayerState.playing;
          if (state == PlayerState.playing) {
            _isLoading = false;
          }
        });
      }
    });

    // Handle playback completion
    _audioPlayer.onPlayerComplete.listen((_) {
      if (mounted) {
        setState(() {
          _isPlaying = false;
          _isLoading = false;
        });
      }
    });
  }

  Future<void> _playPause() async {
    try {
      setState(() {
        _isLoading = true;
      });

      if (_isPlaying) {
        await _audioPlayer.pause();
        setState(() {
          _isLoading = false;
        });
      } else {
        // Configurar opciones específicas para iOS/macOS
        if (Platform.isIOS || Platform.isMacOS) {
          await _audioPlayer.setReleaseMode(ReleaseMode.release);
        }

        await _audioPlayer.play(UrlSource(_audioUrl));
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al reproducir: ${e.toString()}'),
            duration: const Duration(seconds: 5),
            action: SnackBarAction(
              label: 'Reintentar',
              onPressed: _playPause,
            ),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _selectStream(int index) async {
    if (_selectedStreamIndex == index && _isPlaying) {
      // If the same stream is selected and playing, just pause it
      await _playPause();
      return;
    }

    // If a different stream is selected, stop the current one
    if (_isPlaying) {
      await _audioPlayer.pause();
    }

    setState(() {
      _selectedStreamIndex = index;
      _audioUrl = _audioStreams[index] ?? '';
      _isPlaying = false;
      _isLoading = false;
    });

    // Start playing the new stream
    await _playPause();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text(
              _streamLabels[_selectedStreamIndex] ?? 'Music',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Stream selection buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Electronic button
              _buildStreamSelector(0),
              const SizedBox(width: 10),

              // Lofi button
              _buildStreamSelector(1),
            ],
          ),
          const SizedBox(height: 20),

          // Progress bar
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: 1,
            backgroundColor: Colors.grey[700],
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
          ),

          // Controls
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Play/Pause button
              _isLoading
                  ? const SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3,
                      ),
                    )
                  : IconButton(
                      iconSize: 50,
                      color: Colors.white,
                      icon: Icon(
                        _isPlaying ? Icons.pause : Icons.play_arrow,
                      ),
                      onPressed: _playPause,
                    ),
            ],
          ),
        ],
      ),
    );
  }

  String _getMainImageAsset() {
    switch (_selectedStreamIndex) {
      case 0:
        return 'assets/images/rain_theme.jpg';
      case 1:
        return 'assets/images/electronic_theme.jpg';
      case 2:
        return 'assets/images/nature_theme.jpg';
      case 3:
        return 'assets/images/lofi_theme.jpg';
      default:
        return 'assets/images/lofi_theme.jpg';
    }
  }

  Widget _buildStreamSelector(int index) {
    bool isSelected = _selectedStreamIndex == index;
    String imageAsset;

    // Use placeholder images for now
    switch (index) {
      case 0:
        imageAsset = 'assets/images/icons/electronic.png';
        break;
      case 1:
        imageAsset = 'assets/images/icons/lofi.png';
        break;
      default:
        imageAsset = 'assets/images/icons/lofi.png';
        break;
    }

    return GestureDetector(
      onTap: () => _selectStream(index),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: isSelected ? Border.all(color: Colors.white, width: 2) : null,
          color: Colors.grey[800],
        ),
        clipBehavior: Clip.antiAlias,
        child: Center(
          child: Text(
            _streamLabels[index] ?? 'Stream',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
