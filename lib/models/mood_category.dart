class MoodCategory {
  final String title;
  final List<Map<String, String>> songs; // Each song will be a Map of title and artist

  MoodCategory({required this.title, required this.songs});
}
