import 'package:gis_helper/data/resource/result_pattern.dart';
import 'package:gis_helper/data/resource/transformer_resource.dart';
import 'package:gis_helper/domain/model/transformer_model.dart';
import 'package:gis_helper/domain/transformer_repository.dart';

class UpdateAllTransformersRemotely {
  final TransformerRepository transformerRepository;

  UpdateAllTransformersRemotely({required this.transformerRepository});

  Future<Result<List<TransformerModel>>> getAllTransformers() async {
    final transformers = await transformerRepository
        .updateAllTransformersReomtely();
    final List<TransformerModel> transformersModelList = [];
    switch (transformers) {
      case Ok<List<TransformerResource>>():
        {
          transformers.value.forEach((element) {
            transformersModelList.add(
                TransformerModel(feederName: element.feederName,
                    isItOverhead: element.isItOverhead,
                    isItPrivate: element.isItPrivate,
                    mahlaOrSector: element.mahlaOrSector,
                    substationName: element.substationName,
                    transformerCapacity: element.transformerCapacity,
                    transformerName: element.transformerName,
                    transformerSerialNumber: element.transformerSerialNumber,
                    xCoordinates: element.xCoordinates,
                    yCoordinates: element.yCoordinates,
                    zuqaqOrBlock: element.zuqaqOrBlock)
            );
          });
          return Result.ok(transformersModelList);
        }
      case ErrorValue<List<TransformerResource>>():
        {
          return Result.error(transformers.e);
        }
    }
  }
}
