final String tableEmployee = 'employees';

class EmpFields {
  static final List<String> values = [
    /// Add all fields
    id, name, role, fromDate, toDate
  ];

  static const String id = '_id';
  static const String role = 'role';
  static const String name = 'name';
  static const String fromDate = 'fromTime';
  static const String toDate = 'toDate';
}

class Employee {
  final int? id;
  final String name;
  final String role;
  final DateTime fromDate;
  final DateTime? toDate;
  const Employee({
    this.id,
    required this.role,
    required this.name,
    required this.fromDate,
    required this.toDate,
  });

  Employee copy({
    int? id,
    String? name,
    String? role,
    DateTime? fromDate,
    DateTime? toDate,
  }) =>
      Employee(
        id: id ?? this.id,
        name: name ?? this.name,
        role: role ?? this.role,
        fromDate: fromDate ?? this.fromDate,
        toDate: toDate ?? this.toDate,
      );

  static Employee fromJson(Map<String, Object?> json) => Employee(
    id: json[EmpFields.id] as int?,
    role: json[EmpFields.role] as String,
    name: json[EmpFields.name] as String,
    fromDate: DateTime.parse(json[EmpFields.fromDate] as String),
    toDate: (json[EmpFields.toDate] as String?) != 'null' ?DateTime.parse(json[EmpFields.toDate] as String) : null,
  );

  Map<String, Object?> toJson() => {
    EmpFields.id: id,
    EmpFields.name: name,
    EmpFields.role: role,
    EmpFields.fromDate: fromDate.toIso8601String(),
    EmpFields.toDate: toDate != null ? toDate!.toIso8601String() : 'null',
  };
}