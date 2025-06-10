import 'package:gis_helper/data/resource/transformer_resource.dart';

class TransformerModel {
  final String feederName;
  final bool isItOverhead;
  final bool isItPrivate;
  final String mahlaOrSector;
  final String substationName;
  final String transformerCapacity;
  final String transformerName;
  final String transformerSerialNumber;
  final String xCoordinates;
  final String yCoordinates;
  final String zuqaqOrBlock;
  final DateTime created_at;

  // Updated constructor with named optional `created_at`
  TransformerModel({
    DateTime? created_at,
    required this.feederName,
    required this.isItOverhead,
    required this.isItPrivate,
    required this.mahlaOrSector,
    required this.substationName,
    required this.transformerCapacity,
    required this.transformerName,
    required this.transformerSerialNumber,
    required this.xCoordinates,
    required this.yCoordinates,
    required this.zuqaqOrBlock,
  }) : created_at = created_at ?? DateTime.now();

  factory TransformerModel.fromTransformerResource(TransformerResource data) {
    return TransformerModel(
      created_at: data.created_at,
      feederName: data.feederName,
      isItOverhead: data.isItOverhead,
      isItPrivate: data.isItPrivate,
      transformerSerialNumber: data.transformerSerialNumber,
      mahlaOrSector: data.mahlaOrSector,
      substationName: data.substationName,
      transformerCapacity: data.transformerCapacity,
      transformerName: data.transformerName,
      xCoordinates: data.xCoordinates,
      yCoordinates: data.yCoordinates,
      zuqaqOrBlock: data.zuqaqOrBlock,
    );
  }

  void printAllData() {
    print("""
feederName: $feederName
isItOverhead: $isItOverhead
isItPrivate: $isItPrivate
mahlaOrSector: $mahlaOrSector
substationName: $substationName
transformerCapacity: $transformerCapacity
transformerName: $transformerName
transformerSerialNumber: $transformerSerialNumber
xCoordinates: $xCoordinates
yCoordinates: $yCoordinates
zuqaqOrBlock: $zuqaqOrBlock
created_at: $created_at
""");
  }
}
