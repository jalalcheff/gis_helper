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

  factory TransformerModel.fromTransformerResource(TransformerResource data) {
    return TransformerModel(
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

  TransformerModel({required this.feederName,
    required this.isItOverhead,
    required this.isItPrivate,
    required this.mahlaOrSector,
    required this.substationName,
    required this.transformerCapacity,
    required this.transformerName,
    required this.transformerSerialNumber,
    required this.xCoordinates,
    required this.yCoordinates,
    required this.zuqaqOrBlock});

  printAllData() {
    print(
        "all data are : \n feederName : ${feederName}\n isItOverhead : ${isItOverhead}\n isItPrivate : ${isItPrivate}\n mahlaOrSector : ${mahlaOrSector}\n substationName : ${substationName}\n transformerCapacity : ${transformerCapacity}\n transformerName : ${transformerName}\n transformerSerialNumber : ${transformerSerialNumber}\n xCoordinates : ${xCoordinates}\n yCoordinates : ${yCoordinates}\n zuqaqOrBlock : ${zuqaqOrBlock}");
  }

}