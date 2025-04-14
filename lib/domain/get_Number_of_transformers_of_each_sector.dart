import 'package:gis_helper/data/resource/result_pattern.dart';
import 'package:gis_helper/data/resource/transformer_resource.dart';
import 'package:gis_helper/domain/transformer_repository.dart';

class GetNumberOfTransformersOfEachSector {
  final TransformerRepository transformerRepository;

  GetNumberOfTransformersOfEachSector({required this.transformerRepository});
  Future<Result<List<Map<String,dynamic>>>> getNumberOfTransformersOfEachSector()  async {
    final allTransformers = await transformerRepository.getAllTransformers();
    List<Map<String,dynamic>> transformersOfEachSector = [];
    Set<String> sectors = {};
    int transformerSectorCounter = 0;
    switch(allTransformers) {
      case Ok<List<TransformerResource>>():
        {
          for(var transformer in allTransformers.value) {
            sectors.add(transformer.mahlaOrSector);
          }
          for(var sector in sectors) {
            for(var transformer in allTransformers.value) {
              if(sector == transformer.mahlaOrSector) {
                transformerSectorCounter++;
              }
            }
            transformersOfEachSector.add({
            "$sector": "$transformerSectorCounter"
            });
            transformerSectorCounter = 0;
          }
          return Ok(transformersOfEachSector);
        }
      case ErrorValue<List<TransformerResource>>():
        return ErrorValue(allTransformers.e);
    }
}
}