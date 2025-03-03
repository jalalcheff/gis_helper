import 'package:gis_helper/data/resource/transformer_resource.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TransformerResourceAdapter extends TypeAdapter<TransformerResource> {
  @override
  TransformerResource read(BinaryReader reader) {
    //print("inside read adapter get all transformers ${reader.read()[1]}");
      final data = TransformerResource(
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
    print("inside read adapter get all transformers ${data.mahlaOrSector}");
    return data;
  }

  @override
  int get typeId => 2;

  @override
  void write(BinaryWriter writer, TransformerResource obj) {
    print("inside adapter get transformers ${obj.mahlaOrSector}");
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