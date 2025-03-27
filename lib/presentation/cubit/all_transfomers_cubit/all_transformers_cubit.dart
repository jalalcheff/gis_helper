import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/resource/transformer_resource.dart';

part 'all_transformers_state.dart';

class AllTransformersCubit extends Cubit<AllTransformersState> {
  AllTransformersCubit() : super(AllTransformersInitial());
  void loadAllTransformers(List<TransformerResource> transformers){
    emit(AllTransformersLoaded(transformers: transformers));
  }
}
