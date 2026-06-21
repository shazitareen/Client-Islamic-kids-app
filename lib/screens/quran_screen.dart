// lib/screens/quran_screen.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../app_theme.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({super.key});

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  List<QuranSurah> _surahs = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadSurahList();
  }

  Future<void> _loadSurahList() async {
    const cacheKey = 'quran_surah_list';
    try {
      final prefs = await SharedPreferences.getInstance();
      final cached = prefs.getString(cacheKey);
      if (cached != null) {
        _parseSurahs(jsonDecode(cached));
        return;
      }
      final res = await http
          .get(Uri.parse('https://api.alquran.cloud/v1/surah'))
          .timeout(const Duration(seconds: 15));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        await prefs.setString(cacheKey, jsonEncode(data['data']));
        _parseSurahs(data['data']);
      } else {
        throw Exception('Server error ${res.statusCode}');
      }
    } catch (e) {
      if (mounted) setState(() { _error = 'Could not load Quran. Check your internet connection.'; _loading = false; });
    }
  }

  void _parseSurahs(dynamic data) {
    final list = (data as List).map((s) => QuranSurah(
      number: s['number'],
      name: s['name'],
      englishName: s['englishName'],
      englishNameTranslation: s['englishNameTranslation'],
      numberOfAyahs: s['numberOfAyahs'],
      revelationType: s['revelationType'],
    )).toList();
    if (mounted) setState(() { _surahs = list; _loading = false; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('القرآن الكريم', style: TextStyle(fontFamily: 'serif')),
        backgroundColor: AppTheme.primaryGreen,
        centerTitle: true,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.wifi_off_rounded, size: 64, color: Colors.grey),
                        const SizedBox(height: 16),
                        Text(_error!, textAlign: TextAlign.center),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            setState(() { _loading = true; _error = null; });
                            _loadSurahList();
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                )
              : ListView.separated(
                  itemCount: _surahs.length,
                  separatorBuilder: (_, __) => const Divider(height: 1, indent: 72),
                  itemBuilder: (context, index) {
                    final s = _surahs[index];
                    return ListTile(
                      leading: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppTheme.primaryGreen.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            '${s.number}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryGreen,
                            ),
                          ),
                        ),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(s.englishName, style: const TextStyle(fontWeight: FontWeight.bold)),
                          Text(s.name, style: const TextStyle(fontSize: 18, color: AppTheme.primaryGreen)),
                        ],
                      ),
                      subtitle: Text(
                        '${s.englishNameTranslation} • ${s.numberOfAyahs} verses • ${s.revelationType}',
                        style: const TextStyle(fontSize: 12),
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => QuranSurahScreen(surah: s),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}

// ─── Surah Detail Screen ─────────────────────────────────────────────────────

class QuranSurahScreen extends StatefulWidget {
  final QuranSurah surah;
  const QuranSurahScreen({super.key, required this.surah});

  @override
  State<QuranSurahScreen> createState() => _QuranSurahScreenState();
}

class _QuranSurahScreenState extends State<QuranSurahScreen> {
  List<QuranAyah> _ayahs = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadSurah();
  }

  Future<void> _loadSurah() async {
    final cacheKey = 'quran_surah_${widget.surah.number}';
    try {
      final prefs = await SharedPreferences.getInstance();
      final cached = prefs.getString(cacheKey);
      if (cached != null) {
        _parseAyahs(jsonDecode(cached));
        return;
      }
      final url =
          'https://api.alquran.cloud/v1/surah/${widget.surah.number}/editions/quran-uthmani,en.sahih';
      final res = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 15));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body)['data'] as List;
        await prefs.setString(cacheKey, jsonEncode(data));
        _parseAyahs(data);
      } else {
        throw Exception('Server error');
      }
    } catch (e) {
      if (mounted) setState(() { _error = 'Could not load surah. Check your connection.'; _loading = false; });
    }
  }

  void _parseAyahs(List data) {
    final arabic = data[0]['ayahs'] as List;
    final english = data[1]['ayahs'] as List;
    final list = List.generate(arabic.length, (i) => QuranAyah(
      numberInSurah: arabic[i]['numberInSurah'],
      arabic: arabic[i]['text'],
      english: english[i]['text'],
    ));
    if (mounted) setState(() { _ayahs = list; _loading = false; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.surah.englishName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(widget.surah.englishNameTranslation, style: const TextStyle(fontSize: 12)),
          ],
        ),
        backgroundColor: AppTheme.primaryGreen,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                widget.surah.name,
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.wifi_off_rounded, size: 64, color: Colors.grey),
                      const SizedBox(height: 16),
                      Text(_error!, textAlign: TextAlign.center),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          setState(() { _loading = true; _error = null; });
                          _loadSurah();
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _ayahs.length,
                  itemBuilder: (context, index) {
                    final ayah = _ayahs[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 6, offset: Offset(0, 2))],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Verse number badge
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryGreen.withValues(alpha: 0.1),
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    color: AppTheme.primaryGreen,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${ayah.numberInSurah}',
                                      style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Arabic text
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                            child: Text(
                              ayah.arabic,
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl,
                              style: const TextStyle(
                                fontSize: 24,
                                height: 1.8,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          const Divider(height: 1, indent: 16, endIndent: 16),
                          // English translation
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                            child: Text(
                              ayah.english,
                              style: const TextStyle(fontSize: 14, color: Colors.black54, height: 1.5),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}

// ─── Data models ─────────────────────────────────────────────────────────────

class QuranSurah {
  final int number;
  final String name;
  final String englishName;
  final String englishNameTranslation;
  final int numberOfAyahs;
  final String revelationType;

  const QuranSurah({
    required this.number,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.numberOfAyahs,
    required this.revelationType,
  });
}

class QuranAyah {
  final int numberInSurah;
  final String arabic;
  final String english;

  const QuranAyah({required this.numberInSurah, required this.arabic, required this.english});
}
