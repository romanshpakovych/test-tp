
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
}