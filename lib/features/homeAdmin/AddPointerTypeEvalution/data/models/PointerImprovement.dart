class PointerImprovement {
  final int pointerId;
  final String pointerName;
  final String desc;
  final Map<int, double> evaluationsBySession;
  final double averageImprovement;

  PointerImprovement({
    required this.pointerId,
    required this.pointerName,
    required this.desc,
    required this.evaluationsBySession,
    required this.averageImprovement,
  });

  factory PointerImprovement.fromJson(Map<String, dynamic> json) {
    print('${json}');
    final evaluations = Map<int, double>.from(
      (json['evaluations'] as Map<String, dynamic>).map(
            (k, v) => MapEntry(int.parse(k), (v as num).toDouble()),
      ),
    );

    return PointerImprovement(
      pointerId: json['pointerId'],
      pointerName: json['pointerName'],
      desc: json['desc'].toString(),
      evaluationsBySession: evaluations,
      averageImprovement: (json['averageImprovementPerSession'] as num).toDouble(),
    );
  }
}
