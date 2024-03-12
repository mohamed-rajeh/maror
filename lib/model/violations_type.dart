// Driver information
class ViolationType {
  final int? id;
  final String name;
  final double cost;

  ViolationType.fromMap(Map<String, dynamic> map)
      : id = map['id'] as int,
        name = map['name'] as String,
        cost = map['cost'] as double;

  ViolationType({
    this.id,
    required this.name,
    required this.cost,
  });
}
