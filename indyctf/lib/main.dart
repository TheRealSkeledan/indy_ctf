import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const CTFApp());
}

class CTFApp extends StatelessWidget {
  const CTFApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'INDY CTF',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF050505),
        primaryColor: const Color.fromARGB(255, 105, 255, 68),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontFamily: "Courier"),
          bodyLarge: TextStyle(fontFamily: "Courier"),
          titleLarge: TextStyle(fontFamily: "Courier"),
        ),
      ),
      home: const CTFHomePage(),
    );
  }
}

class CTFHomePage extends StatefulWidget {
  const CTFHomePage({super.key});

  @override
  State<CTFHomePage> createState() => _CTFHomePageState();
}

class _CTFHomePageState extends State<CTFHomePage>
    with SingleTickerProviderStateMixin {
  late Timer _rainTimer;
  final Random _rng = Random();

  List<String> codeRain = List.generate(80, (_) => "");

  @override
  void initState() {
    super.initState();

    // ANIMATED BACKGROUND CODE RAIN
    _rainTimer = Timer.periodic(const Duration(milliseconds: 90), (_) {
      setState(() {
        for (int i = 0; i < codeRain.length; i++) {
          codeRain[i] += _randomChar();

          if (codeRain[i].length > 120) {
            codeRain[i] = codeRain[i].substring(40);
          }
        }
      });
    });
  }

  String _randomChar() {
    const chars = "01{}<>/\\|#%&@*+=-[]\$";
    return chars[_rng.nextInt(chars.length)];
  }

  @override
  void dispose() {
    _rainTimer.cancel();
    super.dispose();
  }

  // TOP HEADER PANEL
  Widget buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "INDY CTF",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.lightGreenAccent.withOpacity(0.9),
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          "Real-world cybersecurity challenges for all skill levels.",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            infoChip("LOCATION", "US-EAST-01"),
            const SizedBox(width: 10),
            infoChip("STATUS", "ACTIVE"),
            const SizedBox(width: 10),
            infoChip("DATE", DateTime.now().toString().substring(0, 16)),
          ],
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget infoChip(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.lightGreenAccent.withOpacity(0.15),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.lightGreenAccent.withOpacity(0.4)),
      ),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.lightGreenAccent),
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  // MAIN UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBackground(codeRain: codeRain),
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
              ],
            ),
          ),

          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildHeader(),

                const CTFSection(
                  title: "About",
                  subtitle: "What this event is and why it exists.",
                  body:
                      "Welcome to INDY CTF — a real-world challenge environment "
                      "for cybersecurity enthusiasts, puzzle solvers, and digital infiltrators.",
                ),

                const CTFSection(
                  title: "Challenges",
                  subtitle: "Categories & difficulty ranges.",
                  body:
                      "Includes cryptography, reverse engineering, forensics, "
                      "binary exploitation, web attacks, OSINT, and more.",
                ),

                const CTFSection(
                  title: "Judging & Rules",
                  subtitle: "How scoring works.",
                  body:
                      "Flags are submitted through a secure platform. Scoring is determined by "
                      "challenge difficulty and solve time, with a live leaderboard.",
                ),

                const CTFSection(
                  title: "Why Join",
                  subtitle: "What you get out of the event.",
                  body:
                      "Sharpen your skills, meet new people, build your resume, and challenge your limits.",
                ),

                const CTFSection(
                  title: "FAQs",
                  subtitle: "Common participant questions.",
                  body:
                      "• Experience needed? No, beginners welcome.\n"
                      "• Cost? Free.\n"
                      "• Solo players? Yes.",
                ),

                const CTFSection(
                  title: "Sponsors",
                  subtitle: "Organizations that made this possible.",
                  body:
                      "Supported by local tech companies, cybersecurity orgs, and universities.",
                ),

                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedBackground extends StatelessWidget {
  final List<String> codeRain;

  const AnimatedBackground({super.key, required this.codeRain});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // MOVING GRADIENT GLOW
        AnimatedContainer(
          duration: const Duration(seconds: 6),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF001020),
                Color(0xFF000000),
                Color(0xFF001830),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),

        // CODE RAIN LAYER
        Positioned.fill(
          child: Opacity(
            opacity: 0.05,
            child: Column(
              children: codeRain
                  .map(
                    (str) => Text(
                      str,
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                        color: Colors.greenAccent,
                        fontSize: 14,
                        height: 1.1,
                        fontFamily: 'Courier',
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),

        // SCANLINE OVERLAY
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withOpacity(0.01),
                  Colors.transparent,
                  Colors.white.withOpacity(0.01),
                ],
                stops: const [0.0, 0.5, 1.0],
                tileMode: TileMode.repeated,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CTFSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final String body;

  const CTFSection({
    super.key,
    required this.title,
    required this.subtitle,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      margin: const EdgeInsets.only(bottom: 35),
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.lightGreenAccent.withOpacity(0.3)),
        color: Colors.black.withOpacity(0.25),
        boxShadow: [
          BoxShadow(
            color: Colors.lightGreenAccent.withOpacity(0.12),
            blurRadius: 12,
            spreadRadius: 1,
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.lightGreenAccent,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            body,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 15,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}