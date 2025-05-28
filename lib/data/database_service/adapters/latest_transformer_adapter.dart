import 'package:gis_helper/data/resource/transformer_resource.dart';
import 'package:hive_flutter/adapters.dart';

class LatestTransformerAdapter extends TypeAdapter<TransformerResource>{
  @override
  TransformerResource read(BinaryReader reader) {
    final transformer = TransformerResource(
        feederName: reader.read(),
        isItOverhead: reader.read() ?? false,
        isItPrivate: reader.read() ?? false,
        mahlaOrSector: reader.read() ?? "" ,
        substationName: reader.read() ?? "",
        transformerCapacity: reader.read() ?? "",
        transformerName: reader.read() ?? "",
        transformerSerialNumber: reader.read() ?? "",
        xCoordinates: reader.read() ?? "",
        yCoordinates: reader.read() ?? "",
        zuqaqOrBlock: reader.read() ?? "");
    print("inside read adapter get latest transformers ${transformer.mahlaOrSector}");
    return transformer;
  }

  @override
  int get typeId => 3;

  @override
  void write(BinaryWriter writer, TransformerResource obj) {
    print("inside latest transformer adapter write latest transformers ${obj.mahlaOrSector}");
    writer.write(obj.feederName);
    writer.write(obj.isItOverhead);
    writer.write(obj.isItPrivate);
    writer.write(obj.mahlaOrSector);
    writer.write(obj.substationName);
    writer.write(obj.transformerCapacity);
    writer.write(obj.transformerName);
    writer.write(obj.transformerSerialNumber);
    writer.write(obj.xCoordinates);
    writer.write(obj.yCoordinates);
    writer.write(obj.zuqaqOrBlock);
  }

}