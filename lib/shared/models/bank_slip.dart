import 'dart:convert';

class BankSlipModel {
  final double? value;
  final String? dueDate;
  final String? name;
  final String? barcode;
  BankSlipModel({
    this.value,
    this.dueDate,
    this.name,
    this.barcode,
  });


  BankSlipModel copyWith({
    double? value,
    String? dueDate,
    String? name,
    String? barcode,
  }) {
    return BankSlipModel(
      value: value ?? this.value,
      dueDate: dueDate ?? this.dueDate,
      name: name ?? this.name,
      barcode: barcode ?? this.barcode,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(value != null){
      result.addAll({'value': value});
    }
    if(dueDate != null){
      result.addAll({'dueDate': dueDate});
    }
    if(name != null){
      result.addAll({'name': name});
    }
    if(barcode != null){
      result.addAll({'barcode': barcode});
    }
  
    return result;
  }

  factory BankSlipModel.fromMap(Map<String, dynamic> map) {
    return BankSlipModel(
      value: map['value']?.toDouble(),
      dueDate: map['dueDate'],
      name: map['name'],
      barcode: map['barcode'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BankSlipModel.fromJson(String source) => BankSlipModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BankSlipModel(value: $value, dueDate: $dueDate, name: $name, barcode: $barcode)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is BankSlipModel &&
      other.value == value &&
      other.dueDate == dueDate &&
      other.name == name &&
      other.barcode == barcode;
  }

  @override
  int get hashCode {
    return value.hashCode ^
      dueDate.hashCode ^
      name.hashCode ^
      barcode.hashCode;
  }
}
