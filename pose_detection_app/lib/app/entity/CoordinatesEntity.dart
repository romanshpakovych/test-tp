
class CoordinatesEntity {
  double x;
  double y;
  double z;

  CoordinatesEntity({this.x, this.y, this.z});

  CoordinatesEntity.fromJson(Map<String, dynamic> json) {
    x = (json['x'] as num).toDouble();
    y = (json['y'] as num).toDouble();
    z = (json['z'] as num).toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['x'] = this.x;
    data['y'] = this.y;
    data['z'] = this.z;
    return data;
  }
}