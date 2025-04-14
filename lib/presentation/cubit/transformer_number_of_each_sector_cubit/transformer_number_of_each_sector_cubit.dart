import 'package:bloc/bloc.dart';
import 'package:gis_helper/data/resource/result_pattern.dart';
import 'package:meta/meta.dart';

import '../../../domain/get_Number_of_transformers_of_each_sector.dart';

part 'transformer_number_of_each_sector_state.dart';

class TransformerNumberOfEachSectorCubit extends Cubit<TransformerNumberOfEachSectorState> {
  TransformerNumberOfEachSectorCubit(this.getNumberOfTransformersOfEachSector) : super(TransformerNumberOfEachSectorInitial());
  final GetNumberOfTransformersOfEachSector getNumberOfTransformersOfEachSector;
  void emitTransformerNumberOfEachSector() async{
    final transformers = await getNumberOfTransformersOfEachSector.getNumberOfTransformersOfEachSector();
    switch(transformers) {
      case Ok<List<Map<String, dynamic>>>():
        {
          emit(TransformerNumberOfEachSectorLoaded(transformers: transformers.value));
        }
      case ErrorValue<List<Map<String, dynamic>>>():
        {
          emit(TransformerNumberOfEachSectorError(error: transformers.e.toString()));
        }
    }
  }
}
