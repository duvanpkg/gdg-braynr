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
  double _volume = 0.7; // Default volume level

  // URL alternativas para diferentes plataformas
  static const String _aacStreamUrl = 'https://tupanel.info:8000/stream?sid=1';

  // Definirá la URL basada en la plataforma
  late String _audioUrl;

  @override
  void initState() {
    super.initState();
    _setupAudioPlayer();
    _audioPlayer.setVolume(_volume);

    _audioUrl = _aacStreamUrl;
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

  void _setVolume(double value) {
    setState(() {
      _volume = value;
    });
    _audioPlayer.setVolume(_volume);
  }

  void _toggleMute() {
    setState(() {
      if (_volume > 0) {
        // Store current volume to restore later
        _volume = 0;
      } else {
        // Restore to default volume
        _volume = 0.7;
      }
    });
    _audioPlayer.setVolume(_volume);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Icon(Icons.music_note, color: Colors.black54),
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'LoFi Radio',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Radio stream en vivo',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              // Volume button
              IconButton(
                icon: Icon(
                  _volume == 0 ? Icons.volume_off : Icons.volume_up,
                  size: 24,
                  color: Colors.grey.shade700,
                ),
                onPressed: _toggleMute,
              ),
              // Volume slider
              SizedBox(
                width: 80,
                child: Slider(
                  value: _volume,
                  min: 0.0,
                  max: 1.0,
                  divisions: 10,
                  onChanged: _setVolume,
                  activeColor: Colors.blue.shade700,
                ),
              ),
              // Play/Pause button
              _isLoading
                  ? SizedBox(
                      width: 42,
                      height: 42,
                      child: CircularProgressIndicator(
                        color: Colors.blue.shade700,
                        strokeWidth: 3,
                      ),
                    )
                  : IconButton(
                      icon: Icon(
                        _isPlaying
                            ? Icons.pause_circle_filled
                            : Icons.play_circle_filled,
                        size: 42,
                        color: Colors.blue.shade700,
                      ),
                      onPressed: _playPause,
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
