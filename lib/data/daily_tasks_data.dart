// lib/data/daily_tasks_data.dart
import '../models/daily_task.dart';

/// 14 simple daily Islamic habits that rotate every two weeks.
List<DailyTask> getDailyTasksData() {
  return [
    DailyTask(
      id: 'task_0',
      title: 'Say Bismillah before eating',
      arabicPhrase: 'بِسْمِ اللَّهِ',
      description: 'Remember Allah before your meals today.',
      emoji: '🍽️',
    ),
    DailyTask(
      id: 'task_1',
      title: 'Smile at your parents',
      arabicPhrase: 'تَبَسُّمُكَ',
      description: 'A smile is charity! Show your parents a big smile today.',
      emoji: '😊',
    ),
    DailyTask(
      id: 'task_2',
      title: 'Say Alhamdulillah 10 times',
      arabicPhrase: 'الْحَمْدُ لِلَّهِ',
      description: 'Thank Allah for all the wonderful things you have.',
      emoji: '🤲',
    ),
    DailyTask(
      id: 'task_3',
      title: 'Share something with a sibling or friend',
      arabicPhrase: 'الْعَطَاءُ',
      description: 'Sharing is a beautiful Islamic habit.',
      emoji: '🎁',
    ),
    DailyTask(
      id: 'task_4',
      title: 'Say As-Salamu Alaykum',
      arabicPhrase: 'السَّلَامُ عَلَيْكُمْ',
      description: 'Be the first to say Salam loudly and clearly today!',
      emoji: '👋',
    ),
    DailyTask(
      id: 'task_5',
      title: 'Make Dua before sleeping',
      arabicPhrase: 'دُعَاءُ النَّوْمِ',
      description: 'Remember Allah before you go to bed tonight.',
      emoji: '🌙',
    ),
    DailyTask(
      id: 'task_6',
      title: 'Help clean up a room',
      arabicPhrase: 'النَّظَافَةُ',
      description: 'Cleanliness is half of faith. Help tidy up!',
      emoji: '🧹',
    ),
    DailyTask(
      id: 'task_7',
      title: 'Say SubhanAllah 10 times',
      arabicPhrase: 'سُبْحَانَ اللَّهِ',
      description: 'Say how perfect Allah is 10 times.',
      emoji: '📿',
    ),
    DailyTask(
      id: 'task_8',
      title: 'Use your right hand to eat',
      arabicPhrase: 'بِالْيَمِينِ',
      description: 'Follow the Sunnah and eat with your right hand.',
      emoji: '🖐️',
    ),
    DailyTask(
      id: 'task_9',
      title: 'Read one short Surah',
      arabicPhrase: 'قِرَاءَةُ الْقُرْآنِ',
      description: 'Recite Surah Al-Ikhlas or any short Surah you know.',
      emoji: '📖',
    ),
    DailyTask(
      id: 'task_10',
      title: 'Say JazakAllah Khair',
      arabicPhrase: 'جَزَاكَ اللَّهُ خَيْرًا',
      description: 'Thank someone today the Islamic way.',
      emoji: '💖',
    ),
    DailyTask(
      id: 'task_11',
      title: 'Drink water while sitting',
      arabicPhrase: 'السُّنَّةُ',
      description: 'Follow the Prophet ﷺ and sit down when you drink.',
      emoji: '🚰',
    ),
    DailyTask(
      id: 'task_12',
      title: 'Say Astaghfirullah 10 times',
      arabicPhrase: 'أَسْتَغْفِرُ اللَّهَ',
      description: 'Ask Allah for forgiveness. He is the Most Merciful.',
      emoji: '💧',
    ),
    DailyTask(
      id: 'task_13',
      title: 'Hug your Mum or Dad',
      arabicPhrase: 'الرَّحْمَةُ',
      description: 'Show your love! Give your parents a big hug.',
      emoji: '❤️',
    ),
  ];
}
