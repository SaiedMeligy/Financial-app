class DescImprovement {
  final String desc;
  final Map<int, double> sessionAverages;
  final double averageImprovementPerSession;

  DescImprovement({
    required this.desc,
    required this.sessionAverages,
    required this.averageImprovementPerSession,
  });

  factory DescImprovement.fromJson(Map<String, dynamic> json) {
    print('${json}');
    final averages = Map<int, double>.from(
      (json['sessionAverages'] as Map<String, dynamic>).map(
            (k, v) => MapEntry(int.parse(k), (v as num).toDouble()),
      ),
    );

    return DescImprovement(
      desc: json['desc'],
      sessionAverages: averages,
      averageImprovementPerSession: (json['averageImprovementPerSession'] as num).toDouble(),
    );
  }
}