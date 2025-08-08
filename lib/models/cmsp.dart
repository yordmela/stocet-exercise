class CMSP {
  final String name;
  final String type;
  final String licensedDate;
  final String summary;
  final String background;
  final String goals;
  final String capital;
  final String preparedOn;

  CMSP({
    required this.name,
    required this.type,
    required this.licensedDate,
    required this.summary,
    required this.background,
    required this.goals,
    required this.capital,
    required this.preparedOn,
  });

  factory CMSP.fromJson(Map<String, dynamic> json) => CMSP(
        name: json['name'],
        type: json['type'],
        licensedDate: json['licensedDate'],
        summary: json['summary'],
        background: json['background'],
        goals: json['goals'],
        capital: json['capital'],
        preparedOn: json['preparedOn'],
      );
}
