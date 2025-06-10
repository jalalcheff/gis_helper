import 'package:gis_helper/data/resource/transformer_resource.dart';
import 'package:gis_helper/domain/model/image_document_model.dart';
import 'package:hive_flutter/adapters.dart';

class NewsAdapter extends TypeAdapter<ImageDocumentModel>{
  @override
  ImageDocumentModel read(BinaryReader reader) {
    final transformer = ImageDocumentModel(
        imageUrl: reader.read() ?? "" ,
        title: reader.read() ?? "",
        descriptions: reader.read() ?? "",
        );
    print("inside read adapter get latest transformers ${transformer.title}");
    return transformer;
  }

  @override
  int get typeId => 4;

  @override
  void write(BinaryWriter writer, ImageDocumentModel obj) {
    print("inside latest transformer adapter write latest transformers ${obj.title}");
    writer.write(obj.imageUrl);
    writer.write(obj.title);
    writer.write(obj.descriptions);
  }

}