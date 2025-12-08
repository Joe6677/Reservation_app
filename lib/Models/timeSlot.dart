class TimeIntervals {
  final String from;
  final String to;

  TimeIntervals({required this.from, required this.to});

  @override
  bool operator ==(Object other) {
    return other is TimeIntervals && other.from == from && other.to == to;
  }

  @override
  int get hashCode => from.hashCode ^ to.hashCode;
}
