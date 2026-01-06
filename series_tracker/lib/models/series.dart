enum SeriesStatus {
  watching,
  completed,
  planned,
  dropped,
}

class Series {
  final String id;
  String title;
  String description;
  int totalSeasons;
  int totalEpisodes;

  int currentSeason;
  int currentEpisode;

  SeriesStatus status;
  String? imageUrl;
  List<String> reviews;

  Series({
    required this.id,
    required this.title,
    required this.description,
    required this.totalSeasons,
    required this.totalEpisodes,
    this.currentSeason = 1,
    this.currentEpisode = 1,
    this.status = SeriesStatus.planned,
    this.imageUrl,
    List<String>? reviews,
  }) : reviews = reviews ?? [];
}
