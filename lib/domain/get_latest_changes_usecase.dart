import 'package:gis_helper/data/resource/result_pattern.dart';
import 'package:gis_helper/data/resource/transformer_resource.dart';
import 'package:gis_helper/domain/transformer_repository.dart';

import 'model/transformer_model.dart';

class GetLatestChangesUsecase {
  final TransformerRepository transformerRepository;

  GetLatestChangesUsecase({required this.transformerRepository});

  Future<Result<List<TransformerModel>>> getLatestChanges() async {
    final Result<
        List<TransformerResource>> latestChanges = await transformerRepository
        .getLastChangesTransformers();
    final List<TransformerModel> latestChangesModel = [];
    switch (latestChanges) {
      case Ok<List<TransformerResource>>():
        {
          latestChanges.value.forEach((element) {
            latestChangesModel.add(
                TransformerModel(
                    feederName: element.feederName,
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
          return Result.ok(latestChangesModel);
        }
      case ErrorValue<List<TransformerResource>>():
      {
        return Result.error(latestChanges.e);
      }
    }
  }
}