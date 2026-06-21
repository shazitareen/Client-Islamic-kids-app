// lib/data/quiz_questions_data.dart
import '../models/quiz_question.dart';

/// 25 Islamic quiz questions suitable for children,
/// covering Quran basics, Islamic events, and hadith.
const List<QuizQuestion> islamicQuizData = [
  QuizQuestion(
    question: 'How many Surahs (chapters) are in the Quran?',
    options: ['100', '114', '120', '99'],
    correctIndex: 1,
    explanation:
        'The Quran has 114 Surahs, starting with Al-Fatiha and ending with An-Nas!',
  ),
  QuizQuestion(
    question: 'What is the first Surah of the Quran?',
    options: ['Al-Baqarah', 'Al-Ikhlas', 'Al-Fatiha', 'Al-Nas'],
    correctIndex: 2,
    explanation:
        'Al-Fatiha means "The Opening." We recite it in every rakah of prayer!',
  ),
  QuizQuestion(
    question: 'How many pillars of Islam are there?',
    options: ['4', '5', '6', '7'],
    correctIndex: 1,
    explanation: 'The 5 Pillars are: Shahada, Salah, Zakat, Sawm, and Hajj.',
  ),
  QuizQuestion(
    question: 'How many times do Muslims pray each day?',
    options: ['3', '4', '5', '6'],
    correctIndex: 2,
    explanation:
        'Muslims pray 5 times daily: Fajr, Dhuhr, Asr, Maghrib, and Isha.',
  ),
  QuizQuestion(
    question: 'What is the name of the holy book of Islam?',
    options: ['Torah', 'Bible', 'Zabur', 'Quran'],
    correctIndex: 3,
    explanation:
        'The Quran is the word of Allah, revealed to Prophet Muhammad ﷺ.',
  ),
  QuizQuestion(
    question: 'Who was the last Prophet sent by Allah?',
    options: [
      'Prophet Isa (AS)',
      'Prophet Musa (AS)',
      'Prophet Muhammad ﷺ',
      'Prophet Ibrahim (AS)'
    ],
    correctIndex: 2,
    explanation:
        'Prophet Muhammad ﷺ is the Seal of the Prophets (Khatam-un-Nabiyyeen).',
  ),
  QuizQuestion(
    question: 'In which month do Muslims fast?',
    options: ['Muharram', 'Rajab', 'Ramadan', 'Shawwal'],
    correctIndex: 2,
    explanation:
        'Ramadan is the blessed month of fasting. Eid-ul-Fitr follows it!',
  ),
  QuizQuestion(
    question: 'What is the holiest city in Islam?',
    options: ['Madinah', 'Jerusalem', 'Makkah', 'Cairo'],
    correctIndex: 2,
    explanation: 'Makkah is home to the Masjid al-Haram and the Kaabah.',
  ),
  QuizQuestion(
    question: 'What is the name of the annual Islamic pilgrimage?',
    options: ['Umrah', 'Hajj', 'Zakat', 'Salah'],
    correctIndex: 1,
    explanation:
        'Hajj takes place in the month of Dhul Hijjah and is a pillar of Islam.',
  ),
  QuizQuestion(
    question: 'What does "Bismillah" mean?',
    options: [
      'In the name of Allah',
      'Praise be to Allah',
      'Allah is great',
      'May Allah bless you'
    ],
    correctIndex: 0,
    explanation: 'We say Bismillah before starting anything important!',
  ),
  QuizQuestion(
    question: 'What does "Alhamdulillah" mean?',
    options: [
      'Allah is the greatest',
      'Praise be to Allah',
      'There is no god but Allah',
      'May Allah help us'
    ],
    correctIndex: 1,
    explanation: 'We say Alhamdulillah to thank Allah for all His blessings.',
  ),
  QuizQuestion(
    question: 'What is Zakat?',
    options: [
      'Daily prayers',
      'Fasting in Ramadan',
      'Giving charity to the poor',
      'Going to Makkah'
    ],
    correctIndex: 2,
    explanation:
        'Zakat means giving 2.5% of savings to those in need. It purifies our wealth!',
  ),
  QuizQuestion(
    question:
        'What is the name of the angel who brought the Quran to Prophet Muhammad ﷺ?',
    options: ['Mikail', 'Israfil', 'Jibrail', 'Azrail'],
    correctIndex: 2,
    explanation:
        'Jibrail (Gabriel) is the angel of revelation and a noble messenger!',
  ),
  QuizQuestion(
    question: 'Which prophet built the Kaabah with his son?',
    options: [
      'Prophet Nuh (AS)',
      'Prophet Ibrahim (AS)',
      'Prophet Sulaiman (AS)',
      'Prophet Dawud (AS)'
    ],
    correctIndex: 1,
    explanation:
        'Prophet Ibrahim (AS) and his son Ismail (AS) built the Kaabah together.',
  ),
  QuizQuestion(
    question: 'What is Shahada?',
    options: [
      'The Islamic prayer',
      'The declaration of faith',
      'The Islamic tax',
      'The pilgrimage to Makkah'
    ],
    correctIndex: 1,
    explanation:
        'The Shahada is: "There is no god but Allah, and Muhammad is His messenger."',
  ),
  QuizQuestion(
    question: 'On which night was the Quran first revealed?',
    options: ['Lailatul Qadr', 'Lailatul Miraj', 'Lailatul Barat', 'Eid Night'],
    correctIndex: 0,
    explanation:
        'Lailatul Qadr (The Night of Power) is better than a thousand months!',
  ),
  QuizQuestion(
    question: 'What is the greeting Muslims say to each other?',
    options: [
      'Good morning',
      'Bismillah',
      'As-Salamu Alaykum',
      'Alhamdulillah'
    ],
    correctIndex: 2,
    explanation:
        '"As-Salamu Alaykum" means "Peace be upon you." A beautiful greeting!',
  ),
  QuizQuestion(
    question: 'Which prophet was swallowed by a whale?',
    options: [
      'Prophet Musa (AS)',
      'Prophet Isa (AS)',
      'Prophet Yunus (AS)',
      'Prophet Idris (AS)'
    ],
    correctIndex: 2,
    explanation:
        'Prophet Yunus (AS) prayed inside the whale and Allah rescued him!',
  ),
  QuizQuestion(
    question: 'What is the direction Muslims face when praying?',
    options: ['East', 'West', 'North', 'Qibla (towards Makkah)'],
    correctIndex: 3,
    explanation:
        'Muslims face the Kaabah in Makkah when praying, called the Qibla direction.',
  ),
  QuizQuestion(
    question: 'Which festival is celebrated after Ramadan?',
    options: ['Eid ul-Adha', 'Eid ul-Fitr', 'Mawlid', 'Muharram'],
    correctIndex: 1,
    explanation:
        'Eid ul-Fitr is celebrated on 1st Shawwal after the blessed month of Ramadan!',
  ),
  QuizQuestion(
    question: 'How many Rakats are in the fard Fajr prayer?',
    options: ['2', '3', '4', '5'],
    correctIndex: 0,
    explanation:
        'Fajr has 2 Fard (obligatory) rakats. It\'s the morning prayer before sunrise!',
  ),
  QuizQuestion(
    question: 'What is Wudu?',
    options: [
      'Islamic dress',
      'Ritual cleansing before prayer',
      'A type of prayer',
      'A chapter of the Quran'
    ],
    correctIndex: 1,
    explanation:
        'Wudu (ablution) involves washing hands, face, arms, head and feet before Salah.',
  ),
  QuizQuestion(
    question: 'Which prophet split the sea to save his people?',
    options: [
      'Prophet Ibrahim (AS)',
      'Prophet Dawud (AS)',
      'Prophet Musa (AS)',
      'Prophet Isa (AS)'
    ],
    correctIndex: 2,
    explanation:
        'Allah parted the Red Sea for Prophet Musa (AS) and the Children of Israel!',
  ),
  QuizQuestion(
    question: 'What does "Subhanallah" mean?',
    options: [
      'Praise be to Allah',
      'Allah is the Greatest',
      'Glory be to Allah',
      'In the name of Allah'
    ],
    correctIndex: 2,
    explanation:
        '"Subhanallah" is a tasbeeh we say to glorify Allah\'s perfection.',
  ),
  QuizQuestion(
    question: 'In which city is Masjid al-Nabawi located?',
    options: ['Makkah', 'Madinah', 'Jerusalem', 'Baghdad'],
    correctIndex: 1,
    explanation:
        'Masjid al-Nabawi in Madinah is the mosque of Prophet Muhammad ﷺ himself!',
  ),

  // ── Stories of the Prophets ───────────────────────────────────────────────
  QuizQuestion(
    question: 'Which prophet was thrown into fire but was not harmed?',
    options: ['Prophet Musa (AS)', 'Prophet Ibrahim (AS)', 'Prophet Yusuf (AS)', 'Prophet Idris (AS)'],
    correctIndex: 1,
    explanation: 'Allah commanded the fire to be cool and safe for Prophet Ibrahim (AS). A miracle!',
  ),
  QuizQuestion(
    question: 'Which prophet built a large ship (ark) to save his people and animals?',
    options: ['Prophet Dawud (AS)', 'Prophet Nuh (AS)', 'Prophet Sulaiman (AS)', 'Prophet Lut (AS)'],
    correctIndex: 1,
    explanation: 'Prophet Nuh (AS) built the ark on Allah\'s command. The flood lasted many days!',
  ),
  QuizQuestion(
    question: 'Which prophet could talk to animals and birds?',
    options: ['Prophet Dawud (AS)', 'Prophet Isa (AS)', 'Prophet Sulaiman (AS)', 'Prophet Ibrahim (AS)'],
    correctIndex: 2,
    explanation: 'Allah gave Prophet Sulaiman (AS) the special gift of understanding all creatures!',
  ),
  QuizQuestion(
    question: 'Which prophet was sold as a slave by his brothers but became a great leader?',
    options: ['Prophet Yusuf (AS)', 'Prophet Musa (AS)', 'Prophet Harun (AS)', 'Prophet Shu\'ayb (AS)'],
    correctIndex: 0,
    explanation: 'Despite his brothers\' jealousy, Allah elevated Prophet Yusuf (AS) to become a king\'s minister in Egypt!',
  ),
  QuizQuestion(
    question: 'Which prophet received the Zabur (Psalms)?',
    options: ['Prophet Musa (AS)', 'Prophet Isa (AS)', 'Prophet Dawud (AS)', 'Prophet Ibrahim (AS)'],
    correctIndex: 2,
    explanation: 'Prophet Dawud (AS) received the Zabur and had a beautiful melodious voice when reciting it!',
  ),

  // ── Islamic Calendar & Events ─────────────────────────────────────────────
  QuizQuestion(
    question: 'How many months are in the Islamic (Hijri) calendar?',
    options: ['10', '11', '12', '13'],
    correctIndex: 2,
    explanation: 'The Hijri calendar has 12 months, just like the Gregorian calendar!',
  ),
  QuizQuestion(
    question: 'What is the first month of the Islamic calendar?',
    options: ['Ramadan', 'Muharram', 'Dhul Hijjah', 'Rajab'],
    correctIndex: 1,
    explanation: 'Muharram is the first month of the Hijri year. It is one of the sacred months!',
  ),
  QuizQuestion(
    question: 'Which festival is celebrated during Dhul Hijjah?',
    options: ['Eid ul-Fitr', 'Mawlid', 'Eid ul-Adha', 'Laylatul Qadr'],
    correctIndex: 2,
    explanation: 'Eid ul-Adha (Festival of Sacrifice) commemorates Prophet Ibrahim\'s willingness to sacrifice his son for Allah!',
  ),
  QuizQuestion(
    question: 'The Night of Power (Laylatul Qadr) is in which month?',
    options: ['Muharram', 'Rajab', 'Sha\'ban', 'Ramadan'],
    correctIndex: 3,
    explanation: 'Laylatul Qadr is in the last 10 nights of Ramadan. It is better than 1000 months!',
  ),
  QuizQuestion(
    question: 'The Prophet ﷺ was born in which month?',
    options: ['Muharram', 'Rabi al-Awwal', 'Sha\'ban', 'Ramadan'],
    correctIndex: 1,
    explanation: 'Prophet Muhammad ﷺ was born on the 12th of Rabi al-Awwal, the third Islamic month!',
  ),

  // ── Pillars of Faith (Iman) ───────────────────────────────────────────────
  QuizQuestion(
    question: 'How many pillars (articles) of Iman (faith) are there?',
    options: ['4', '5', '6', '7'],
    correctIndex: 2,
    explanation: 'The 6 pillars of Iman: belief in Allah, Angels, Books, Prophets, Day of Judgement, and Qadar!',
  ),
  QuizQuestion(
    question: 'How many angels are mentioned by name in the Quran?',
    options: ['2', '3', '4', '5'],
    correctIndex: 1,
    explanation: 'Jibrail, Mikail, and Israfil are among the named angels. Jibrail brought the Quran!',
  ),
  QuizQuestion(
    question: 'What does "Qadar" mean in Islamic belief?',
    options: ['Prayer', 'Fasting', 'Divine decree and predestination', 'Charity'],
    correctIndex: 2,
    explanation: 'Qadar means believing that Allah knows everything and has decreed all that will happen!',
  ),
  QuizQuestion(
    question: 'Which angel is responsible for blowing the trumpet on the Day of Judgement?',
    options: ['Jibrail', 'Mikail', 'Israfil', 'Munkar'],
    correctIndex: 2,
    explanation: 'Angel Israfil will blow the trumpet (Sur) to signal the end of the world and the start of the Day of Judgement!',
  ),
  QuizQuestion(
    question: 'What is the name of the last holy book revealed by Allah?',
    options: ['Torah', 'Injil (Gospel)', 'Zabur', 'Quran'],
    correctIndex: 3,
    explanation: 'The Quran is the final book from Allah, revealed to Prophet Muhammad ﷺ over 23 years!',
  ),

  // ── Islamic Manners (Adab) ────────────────────────────────────────────────
  QuizQuestion(
    question: 'What do we say when something good happens?',
    options: ['Astaghfirullah', 'Mashallah', 'Inna lillahi', 'A\'udhu billah'],
    correctIndex: 1,
    explanation: '"Mashallah" means "What Allah has willed!" — we say it to appreciate blessings!',
  ),
  QuizQuestion(
    question: 'What do we say when we sneeze?',
    options: ['Subhanallah', 'Alhamdulillah', 'Bismillah', 'Allahu Akbar'],
    correctIndex: 1,
    explanation: 'We say "Alhamdulillah" when we sneeze, and those around us reply "Yarhamukallah"!',
  ),
  QuizQuestion(
    question: 'What should we do when we yawn?',
    options: [
      'Yawn loudly to stretch',
      'Cover our mouth with our hand',
      'Leave the room',
      'Say Bismillah first',
    ],
    correctIndex: 1,
    explanation: 'The Prophet ﷺ taught us to cover our mouth when yawning. Shaytan loves open yawning!',
  ),
  QuizQuestion(
    question: 'Which hand should we use when eating and drinking?',
    options: ['Left hand', 'Right hand', 'Either hand is fine', 'Both hands'],
    correctIndex: 1,
    explanation: 'We eat and drink with the right hand, following the Sunnah of the Prophet ﷺ!',
  ),
  QuizQuestion(
    question: 'What is the Islamic term for respecting and obeying your parents?',
    options: ['Sadaqah', 'Birr al-Walidayn', 'Zakat', 'Tawbah'],
    correctIndex: 1,
    explanation: '"Birr al-Walidayn" means being kind and obedient to your parents. Allah loves this greatly!',
  ),

  // ── Names of Allah (Al-Asma ul-Husna) ────────────────────────────────────
  QuizQuestion(
    question: 'What does "Ar-Rahman" mean?',
    options: ['The Most Powerful', 'The Most Merciful (to all creation)', 'The Creator', 'The Provider'],
    correctIndex: 1,
    explanation: '"Ar-Rahman" means Allah\'s mercy extends to all of creation — believers and non-believers alike!',
  ),
  QuizQuestion(
    question: 'What does "Al-Khaliq" mean?',
    options: ['The Forgiver', 'The Wise', 'The Creator', 'The King'],
    correctIndex: 2,
    explanation: '"Al-Khaliq" means The Creator. Allah created everything from nothing!',
  ),
  QuizQuestion(
    question: 'What does "Al-Alim" mean?',
    options: ['The All-Knowing', 'The All-Hearing', 'The Most High', 'The Most Powerful'],
    correctIndex: 0,
    explanation: '"Al-Alim" means Allah knows everything — even our secret thoughts!',
  ),
  QuizQuestion(
    question: 'What does "As-Sami" mean?',
    options: ['The All-Seeing', 'The All-Hearing', 'The Forgiver', 'The Provider'],
    correctIndex: 1,
    explanation: '"As-Sami" means The All-Hearing. Allah hears every dua we make, no matter how quietly!',
  ),
  QuizQuestion(
    question: 'How many Beautiful Names (Asma ul-Husna) does Allah have?',
    options: ['66', '77', '88', '99'],
    correctIndex: 3,
    explanation: 'Allah has 99 beautiful names! The Prophet ﷺ said whoever memorises them all will enter Paradise!',
  ),

  // ── Quran Knowledge ───────────────────────────────────────────────────────
  QuizQuestion(
    question: 'Which is the longest Surah in the Quran?',
    options: ['Al-Imran', 'Al-Baqarah', 'An-Nisa', 'Al-Maidah'],
    correctIndex: 1,
    explanation: 'Al-Baqarah is the longest Surah with 286 verses. It contains Ayatul Kursi!',
  ),
  QuizQuestion(
    question: 'Which is the shortest Surah in the Quran?',
    options: ['Al-Ikhlas', 'Al-Falaq', 'Al-Kawthar', 'An-Nas'],
    correctIndex: 2,
    explanation: 'Al-Kawthar has only 3 verses — it is the shortest Surah in the Quran!',
  ),
  QuizQuestion(
    question: 'What is the most powerful verse (ayah) in the Quran?',
    options: ['Al-Fatiha', 'Ayatul Kursi', 'The first verse of Al-Baqarah', 'Surah Al-Ikhlas'],
    correctIndex: 1,
    explanation: 'Ayatul Kursi (2:255) is the greatest verse — recite it every night for protection!',
  ),
  QuizQuestion(
    question: 'In which city was the Quran first revealed to Prophet Muhammad ﷺ?',
    options: ['Madinah', 'Taif', 'Makkah', 'Jerusalem'],
    correctIndex: 2,
    explanation: 'The first revelation came in the Cave of Hira, near Makkah, in the month of Ramadan!',
  ),
  QuizQuestion(
    question: 'What are the first words revealed to Prophet Muhammad ﷺ?',
    options: ['Bismillah', 'Iqra (Read!)', 'Alhamdulillah', 'La ilaha illallah'],
    correctIndex: 1,
    explanation: '"Iqra" meaning "Read!" were the first words revealed by Angel Jibrail to the Prophet ﷺ!',
  ),
];
