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
        primaryColor: Colors.lightGreenAccent,
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

class _CTFHomePageState extends State<CTFHomePage> {
  late Timer _timer;
  final rng = Random();
  List<String> lines = List.generate(40, (_) => "");

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(milliseconds: 70), (_) {
      setState(() {
        for (int i = 0; i < lines.length; i++) {
          lines[i] += _randomChar();

          if (lines[i].length > 220) {
            lines[i] = lines[i].substring(1);
          }
        }
      });
    });
  }

  String _randomChar() {
    const chars = "01<>/\\|#%&@+=-[]{}*";
    return chars[rng.nextInt(chars.length)];
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  // HEADER
  Widget buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "INDY CTF",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 45,
            fontWeight: FontWeight.bold,
            color: Colors.lightGreenAccent.withOpacity(0.95),
            letterSpacing: 3,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          "Real-world cybersecurity challenges for all skill levels.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 17, color: Colors.white70),
        ),
        const SizedBox(height: 20),

        Wrap(
          alignment: WrapAlignment.center,
          spacing: 12,
          runSpacing: 8,
          children: [
            infoChip("LOCATION", "US-EAST-01"),
            infoChip("STATUS", "ACTIVE"),
            infoChip("DATE", DateTime.now().toString().substring(0, 16)),
          ],
        ),

        const SizedBox(height: 50),
      ],
    );
  }

  Widget infoChip(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.lightGreenAccent.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.lightGreenAccent.withOpacity(0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("$label: ",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.lightGreenAccent)),
          Text(value, style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedCodeBackground(lines: lines),

          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: Column(
                  children: [
                    buildHeader(),

                    const HoverCard(
                      title: "ABOUT",
                      subtitle: "What this event is.",
                      body:
                          "INDY CTF is a training ground for hackers—cryptography, logic puzzles, "
                          "network infiltration, and more.",
                    ),

                    const HoverCard(
                      title: "CHALLENGES",
                      subtitle: "What you will face.",
                      body:
                          "Reverse engineering, forensics, binary exploitation, cryptography, web, "
                          "and OSINT challenges of various difficulty.",
                    ),

                    const HoverCard(
                      title: "RULES & JUDGING",
                      subtitle: "How points work.",
                      body:
                          "Submit flags on a secure platform. Score scales by difficulty & solve time. "
                          "Leaderboard updates live.",
                    ),

                    const HoverCard(
                      title: "WHY JOIN?",
                      subtitle: "The benefits.",
                      body:
                          "Sharpen your skills, join a community, build a portfolio, and challenge "
                          "your abilities under pressure.",
                    ),

                    const HoverCard(
                      title: "FAQ",
                      subtitle: "Common questions.",
                      body:
                          "• Experience required? No.\n"
                          "• Cost? Free.\n"
                          "• Solo players? Allowed.\n",
                    ),

                    const HoverCard(
                      title: "SPONSORS",
                      subtitle: "Who supports this.",
                      body:
                          "Supported by tech orgs, local companies, cybersecurity groups, and universities.",
                    ),

                    const SizedBox(height: 120),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedCodeBackground extends StatelessWidget {
  final List<String> lines;

  const AnimatedCodeBackground({super.key, required this.lines});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedContainer(
          duration: const Duration(seconds: 6),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF001418),
                Color(0xFF000000),
                Color(0xFF001820),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),

        Positioned.fill(
          child: Opacity(
            opacity: 0.08,
            child: Column(
              children: lines
                  .map(
                    (line) => Text(
                      line,
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1,
                        color: Colors.greenAccent,
                        fontFamily: "Courier",
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),

        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withOpacity(0.02),
                  Colors.transparent,
                  Colors.white.withOpacity(0.02),
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

class HoverCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String body;

  const HoverCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.body,
  });

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hovering = true),
      onExit: (_) => setState(() => hovering = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedScale(
        scale: hovering ? 1.03 : 1.0,
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.only(bottom: 30),
          padding: const EdgeInsets.all(22),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
                color: hovering
                    ? Colors.lightGreenAccent
                    : Colors.lightGreenAccent.withOpacity(0.3)),
            color: Colors.black.withOpacity(0.28),
            boxShadow: hovering
                ? [
                    BoxShadow(
                      color: Colors.lightGreenAccent.withOpacity(0.32),
                      blurRadius: 25,
                      spreadRadius: 2,
                    )
                  ]
                : [
                    BoxShadow(
                      color: Colors.lightGreenAccent.withOpacity(0.1),
                      blurRadius: 12,
                    )
                  ],
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  color: Colors.lightGreenAccent,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                widget.subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70, fontSize: 15),
              ),
              const SizedBox(height: 14),
              Text(
                widget.body,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
