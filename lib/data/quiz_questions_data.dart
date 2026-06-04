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
];
