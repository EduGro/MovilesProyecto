import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'adventure_event.dart';
part 'adventure_state.dart';

class AdventureBloc extends Bloc<AdventureEvent, AdventureState> {
  AdventureBloc() : super(AdventureInitial());

  @override
  Stream<AdventureState> mapEventToState(
    AdventureEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
