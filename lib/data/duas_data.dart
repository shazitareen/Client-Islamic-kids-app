// lib/data/duas_data.dart

class DuaItem {
  final String title;
  final String arabic;
  final String transliteration;
  final String translation;
  final String emoji;

  const DuaItem({
    required this.title,
    required this.arabic,
    required this.transliteration,
    required this.translation,
    required this.emoji,
  });
}

const List<DuaItem> allDuas = [
  DuaItem(
    title: 'Before eating',
    arabic: 'بِسْمِ اللَّهِ',
    transliteration: 'Bismillah',
    translation: 'In the name of Allah',
    emoji: '🍽️',
  ),
  DuaItem(
    title: 'After eating',
    arabic: 'الْحَمْدُ لِلَّهِ الَّذِي أَطْعَمَنَا وَسَقَانَا وَجَعَلَنَا مُسْلِمِينَ',
    transliteration: 'Alhamdulillahil-ladhee at\'amanaa wa saqaanaa wa ja\'alanaa muslimeen',
    translation: 'Praise be to Allah who fed us, gave us drink, and made us Muslims',
    emoji: '😋',
  ),
  DuaItem(
    title: 'Before sleeping',
    arabic: 'بِاسْمِكَ اللَّهُمَّ أَمُوتُ وَأَحْيَا',
    transliteration: 'Bismika Allahumma amootu wa ahyaa',
    translation: 'In Your name, O Allah, I die and I live',
    emoji: '🌙',
  ),
  DuaItem(
    title: 'After waking up',
    arabic: 'الْحَمْدُ لِلَّهِ الَّذِي أَحْيَانَا بَعْدَ مَا أَمَاتَنَا وَإِلَيْهِ النُّشُورُ',
    transliteration: 'Alhamdulillahil-ladhee ahyaanaa ba\'da maa amaatanaa wa ilayhin-nushoor',
    translation: 'Praise be to Allah who gave us life after death and to Him is the resurrection',
    emoji: '☀️',
  ),
  DuaItem(
    title: 'Leaving the home',
    arabic: 'بِسْمِ اللَّهِ تَوَكَّلْتُ عَلَى اللَّهِ وَلَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللَّهِ',
    transliteration: 'Bismillahi tawakkaltu \'alallahi wa laa hawla wa laa quwwata illaa billah',
    translation: 'In the name of Allah, I trust in Allah; there is no power except with Allah',
    emoji: '🚪',
  ),
  DuaItem(
    title: 'Entering the home',
    arabic: 'اللَّهُمَّ إِنِّي أَسْأَلُكَ خَيْرَ الْمَوْلِجِ وَخَيْرَ الْمَخْرَجِ',
    transliteration: 'Allahumma innee as\'aluka khayral-mawliji wa khayral-makhraji',
    translation: 'O Allah, I ask You for the good of the entering and the good of the exit',
    emoji: '🏠',
  ),
  DuaItem(
    title: 'Before studying',
    arabic: 'رَبِّ زِدْنِي عِلْمًا',
    transliteration: 'Rabbi zidnee \'ilmaa',
    translation: 'My Lord, increase me in knowledge',
    emoji: '📚',
  ),
  DuaItem(
    title: 'After wudu',
    arabic: 'أَشْهَدُ أَنْ لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ وَأَشْهَدُ أَنَّ مُحَمَّدًا عَبْدُهُ وَرَسُولُهُ',
    transliteration: 'Ash-hadu an laa ilaaha illallaahu wahdahu laa shareeka lahu wa ash-hadu anna Muhammadan \'abduhu wa rasooluhu',
    translation: 'I bear witness that there is no god but Allah alone, and I bear witness that Muhammad is His servant and messenger',
    emoji: '💧',
  ),
  DuaItem(
    title: 'Entering the masjid',
    arabic: 'اللَّهُمَّ افْتَحْ لِي أَبْوَابَ رَحْمَتِكَ',
    transliteration: 'Allahumma iftah lee abwaaba rahmatik',
    translation: 'O Allah, open the gates of Your mercy for me',
    emoji: '🕌',
  ),
  DuaItem(
    title: 'Leaving the masjid',
    arabic: 'اللَّهُمَّ إِنِّي أَسْأَلُكَ مِنْ فَضْلِكَ',
    transliteration: 'Allahumma innee as\'aluka min fadlik',
    translation: 'O Allah, I ask You for Your bounty',
    emoji: '✨',
  ),
  DuaItem(
    title: 'Entering the bathroom',
    arabic: 'اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْخُبُثِ وَالْخَبَائِثِ',
    transliteration: 'Allahumma innee a\'oodhu bika minal-khubuthi wal-khabaa\'ith',
    translation: 'O Allah, I seek refuge with You from evil and evil ones',
    emoji: '🚽',
  ),
  DuaItem(
    title: 'For parents',
    arabic: 'رَبِّ ارْحَمْهُمَا كَمَا رَبَّيَانِي صَغِيرًا',
    transliteration: 'Rabbir-hamhumaa kamaa rabbayaanee sagheeraa',
    translation: 'My Lord, have mercy on them as they raised me when I was small',
    emoji: '❤️',
  ),
  DuaItem(
    title: 'When it rains',
    arabic: 'اللَّهُمَّ صَيِّبًا نَافِعًا',
    transliteration: 'Allahumma sayyiban naafi\'aa',
    translation: 'O Allah, make it a beneficial rain',
    emoji: '🌧️',
  ),
  DuaItem(
    title: 'When seeing the moon',
    arabic: 'اللَّهُ أَكْبَرُ اللَّهُمَّ أَهِلَّهُ عَلَيْنَا بِالْأَمْنِ وَالْإِيمَانِ',
    transliteration: 'Allahu Akbar. Allahumma ahillahu \'alaynaa bil-amni wal-eemaan',
    translation: 'Allah is the Greatest. O Allah, let this moon appear over us with security and faith',
    emoji: '🌙',
  ),
  DuaItem(
    title: 'For good health',
    arabic: 'اللَّهُمَّ عَافِنِي فِي بَدَنِي، اللَّهُمَّ عَافِنِي فِي سَمْعِي، اللَّهُمَّ عَافِنِي فِي بَصَرِي',
    transliteration: 'Allahumma \'aafinee fee badanee, Allahumma \'aafinee fee sam\'ee, Allahumma \'aafinee fee basaree',
    translation: 'O Allah, grant me health in my body, my hearing, and my sight',
    emoji: '💪',
  ),
  DuaItem(
    title: 'Protection from Shaytan',
    arabic: 'أَعُوذُ بِاللَّهِ مِنَ الشَّيْطَانِ الرَّجِيمِ',
    transliteration: 'A\'oodhu billahi minash-shaytaanir-rajeem',
    translation: 'I seek refuge with Allah from the accursed Shaytan',
    emoji: '🛡️',
  ),
  DuaItem(
    title: 'Before travelling',
    arabic: 'اللَّهُمَّ إِنَّا نَسْأَلُكَ فِي سَفَرِنَا هَذَا الْبِرَّ وَالتَّقْوَى',
    transliteration: 'Allahumma innaa nas\'aluka fee safarinaa haadhal birra wat-taqwaa',
    translation: 'O Allah, we ask You during this journey for righteousness and piety',
    emoji: '✈️',
  ),
  DuaItem(
    title: 'When in difficulty',
    arabic: 'لَا إِلَهَ إِلَّا أَنْتَ سُبْحَانَكَ إِنِّي كُنْتُ مِنَ الظَّالِمِينَ',
    transliteration: 'Laa ilaaha illaa anta subhaanaka innee kuntu minazh-zhaalimeen',
    translation: 'There is none worthy of worship except You. Glory be to You. Indeed I was among the wrongdoers',
    emoji: '🤲',
  ),
  DuaItem(
    title: 'For forgiveness',
    arabic: 'اللَّهُمَّ اغْفِرْ لِي وَارْحَمْنِي وَاهْدِنِي وَعَافِنِي وَارْزُقْنِي',
    transliteration: 'Allahumma ighfir lee warhamni wahdinee wa\'afinee warzuqnee',
    translation: 'O Allah, forgive me, have mercy on me, guide me, grant me well-being and provide for me',
    emoji: '💚',
  ),
  DuaItem(
    title: 'Morning remembrance',
    arabic: 'أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلَّهِ وَالْحَمْدُ لِلَّهِ',
    transliteration: 'Asbahna wa asbahal-mulku lillahi wal-hamdu lillah',
    translation: 'We have reached the morning and the whole kingdom belongs to Allah, and praise be to Allah',
    emoji: '🌅',
  ),
  DuaItem(
    title: 'Evening remembrance',
    arabic: 'أَمْسَيْنَا وَأَمْسَى الْمُلْكُ لِلَّهِ وَالْحَمْدُ لِلَّهِ',
    transliteration: 'Amsayna wa amsal-mulku lillahi wal-hamdu lillah',
    translation: 'We have reached the evening and the whole kingdom belongs to Allah, and praise be to Allah',
    emoji: '🌆',
  ),
  DuaItem(
    title: 'When angry',
    arabic: 'أَعُوذُ بِاللَّهِ مِنَ الشَّيْطَانِ الرَّجِيمِ',
    transliteration: 'A\'oodhu billahi minash-shaytaanir-rajeem',
    translation: 'I seek refuge with Allah from the accursed Shaytan',
    emoji: '😤',
  ),
  DuaItem(
    title: 'When sneezing',
    arabic: 'الْحَمْدُ لِلَّهِ',
    transliteration: 'Alhamdulillah',
    translation: 'Praise be to Allah',
    emoji: '🤧',
  ),
  DuaItem(
    title: 'When hearing the adhan',
    arabic: 'وَأَنَا أَشْهَدُ أَنْ لَا إِلَهَ إِلَّا اللَّهُ',
    transliteration: 'Wa ana ash-hadu an laa ilaaha illallah',
    translation: 'And I bear witness that there is no god worthy of worship except Allah',
    emoji: '📢',
  ),
  DuaItem(
    title: 'Dua for Laylatul Qadr',
    arabic: 'اللَّهُمَّ إِنَّكَ عَفُوٌّ تُحِبُّ الْعَفْوَ فَاعْفُ عَنِّي',
    transliteration: 'Allahumma innaka \'afuwwun tuhibbul-\'afwa fa\'fu \'annee',
    translation: 'O Allah, You are Forgiving and love forgiveness, so forgive me',
    emoji: '🌟',
  ),
  DuaItem(
    title: 'Gratitude to Allah',
    arabic: 'رَبِّ أَوْزِعْنِي أَنْ أَشْكُرَ نِعْمَتَكَ الَّتِي أَنْعَمْتَ عَلَيَّ',
    transliteration: 'Rabbi awzi\'nee an ashkura ni\'matakal-latee an\'amta \'alayya',
    translation: 'My Lord, inspire me to be grateful for Your favour which You have bestowed upon me',
    emoji: '🙏',
  ),
  DuaItem(
    title: 'Seeking guidance',
    arabic: 'اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ',
    transliteration: 'Ihdinassiraatal mustaqeem',
    translation: 'Guide us to the straight path',
    emoji: '🧭',
  ),
  DuaItem(
    title: 'Drinking water',
    arabic: 'الْحَمْدُ لِلَّهِ الَّذِي سَقَانَا عَذْبًا فُرَاتًا',
    transliteration: 'Alhamdulillahil-ladhee saqaana \'adban furaataa',
    translation: 'Praise be to Allah who gave us fresh and sweet water to drink',
    emoji: '🥤',
  ),
  DuaItem(
    title: 'For a good ending',
    arabic: 'رَبَّنَا آتِنَا فِي الدُّنْيَا حَسَنَةً وَفِي الْآخِرَةِ حَسَنَةً وَقِنَا عَذَابَ النَّارِ',
    transliteration: 'Rabbana aatinaa fid-dunyaa hasanatan wa fil-aakhirati hasanatan wa qinaa \'adhaaban-naar',
    translation: 'Our Lord, give us good in this world and good in the Hereafter, and protect us from the punishment of the Fire',
    emoji: '🌈',
  ),
  DuaItem(
    title: 'Seeking knowledge',
    arabic: 'اللَّهُمَّ انْفَعْنِي بِمَا عَلَّمْتَنِي وَعَلِّمْنِي مَا يَنْفَعُنِي',
    transliteration: 'Allahumma infa\'nee bimaa \'allamtanee wa \'allimnee maa yanfa\'unee',
    translation: 'O Allah, benefit me through what You have taught me, and teach me what will benefit me',
    emoji: '💡',
  ),
];

DuaItem getDuaOfTheDay() {
  final dayIndex = DateTime.now().difference(DateTime(2024, 1, 1)).inDays % allDuas.length;
  return allDuas[dayIndex];
}
