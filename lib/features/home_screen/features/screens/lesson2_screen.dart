import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flexedu/features/home_screen/features/screens/quiz_page.dart';
import 'package:flexedu/features/home_screen/features/screens/generate.dart';
import 'package:flexedu/features/home_screen/features/screens/rchat.dart';
import 'package:flexedu/features/home_screen/features/screens/achat.dart';
import 'package:flexedu/core/colors/colors.dart';
import 'package:flexedu/features/login_screen/features/componant/default_button.dart';

class Lesson2 extends StatefulWidget {
  final String lessonId;
  final String lessonTitle;

  const Lesson2({
    super.key,
    required this.lessonId,
    required this.lessonTitle,
  });

  @override
  State<Lesson2> createState() => _Lesson2State();
}

class _Lesson2State extends State<Lesson2> {
  String? learningStyle;
  late Future<DocumentSnapshot> _lessonFuture;

  VideoPlayerController? _videoController;
  ChewieController? _chewieController;

  final AudioPlayer _audioPlayer = AudioPlayer();
  Duration _audioDuration = Duration.zero;
  Duration _audioPosition = Duration.zero;

  @override
  void initState() {
    super.initState();
    fetchLearningStyle();
    _lessonFuture = FirebaseFirestore.instance
        .collection("lessons")
        .doc(widget.lessonId)
        .get();
  }

  Future<void> fetchLearningStyle() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    final doc =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();
    setState(() {
      learningStyle = doc.data()?['learningStyle'];
    });
  }

  Future<void> setupVideo(String url) async {
    _videoController = VideoPlayerController.network(url);
    await _videoController!.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoController!,
      autoPlay: true,
      looping: false,
    );
    setState(() {});
  }

  Future<void> setupAudio(String url) async {
    await _audioPlayer.setUrl(url);
    _audioPlayer.positionStream.listen((position) {
      setState(() {
        _audioPosition = position;
      });
    });
    _audioPlayer.durationStream.listen((duration) {
      if (duration != null) {
        setState(() {
          _audioDuration = duration;
        });
      }
    });
    _audioPlayer.play();
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _chewieController?.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  Widget buildContent(Map<String, dynamic> data) {
    final quiz = List<Map<String, dynamic>>.from(data['quiz']);

    switch (learningStyle) {
      case "Visual":
        final videoUrl = data['videoUrl'];
        if (_chewieController == null) {
          setupVideo(videoUrl);
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: _videoController!.value.aspectRatio,
              child: Chewie(controller: _chewieController!),
            ),
            const SizedBox(height: 20),
            buildButtons(quiz),
          ],
        );

      case "Read/Write":
        final rawArticle = data['article'];
        final article =
            rawArticle.replaceAll(r'\n', '\n').replaceAll(r'\t', '\t');
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article,
              style: TextStyle(fontSize: 16.sp, height: 1.6),
            ),
            const SizedBox(height: 20),
            buildButtons(quiz),
          ],
        );

      case "Auditory":
        final audioUrl = data['audioUrl'];
        if (_audioPlayer.playing == false && _audioDuration == Duration.zero) {
          setupAudio(audioUrl);
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Listen to the lesson:", style: TextStyle(fontSize: 18.sp)),
            const SizedBox(height: 10),
            ProgressBar(
              progress: _audioPosition,
              total: _audioDuration,
              onSeek: (duration) => _audioPlayer.seek(duration),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    _audioPlayer.playing ? Icons.pause : Icons.play_arrow,
                  ),
                  onPressed: () {
                    if (_audioPlayer.playing) {
                      _audioPlayer.pause();
                    } else {
                      _audioPlayer.play();
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            buildButtons(quiz),
          ],
        );

      case "Kinesthetic":
        final rawExp = List<String>.from(data['exp'] ?? []);
        final images = List<String>.from(data['imageUrls'] ?? []);

        if (rawExp.length < 3 || images.length < 3) {
          return const Center(
              child: Text("Kinesthetic content is missing or incomplete."));
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < 3; i++) ...[
              Text(
                rawExp[i].replaceAll(r'\n', '\n').replaceAll(r'\t', '\t'),
                style: TextStyle(fontSize: 16.sp, height: 1.6),
              ),
              const SizedBox(height: 10),
              Image.network(images[i], height: 200),
              const SizedBox(height: 20),
            ],
            buildButtons(quiz),
          ],
        );

      default:
        return const Center(child: Text("Loading your content..."));
    }
  }

  Widget buildButtons(List<Map<String, dynamic>> quiz) {
    return Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: DefaultButton(
              txt: "Start Quiz",
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => QuizPage(
                      lessonTitle: widget.lessonTitle,
                      quiz: quiz,
                    ),
                  ),
                );
              },
              color: AppColors.mainColor,
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: DefaultButton(
              txt: "Generate AI Data",
              onPress: () {
                if (learningStyle == "Visual" || learningStyle == "Kinesthetic") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Generate(
                        lessonId: widget.lessonId,
                        lessonTitle: widget.lessonTitle,
                      ),
                    ),
                  );
                } else if (learningStyle == "Read/Write") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RChat(
                        lessonId: widget.lessonId,
                        lessonTitle: widget.lessonTitle,
                      ),
                    ),
                  );
                } else if (learningStyle == "Auditory") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AChat(
                        lessonId: widget.lessonId,
                        lessonTitle: widget.lessonTitle,
                      ),
                    ),
                  );
                }
              },
              color: AppColors.containerColor,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.lessonTitle)),
      body: FutureBuilder<DocumentSnapshot>(
        future: _lessonFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final data = snapshot.data!.data() as Map<String, dynamic>;
          return SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: buildContent(data),
          );
        },
      ),
    );
  }
}
