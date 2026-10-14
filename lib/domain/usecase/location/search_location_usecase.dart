import 'package:injectable/injectable.dart';
import '../../entity/location/picked_location.dart';
import '../../repository/location/location_repository.dart';

@lazySingleton
class SearchLocationUseCase {
  final LocationRepository _repository;

  const SearchLocationUseCase(this._repository);

  Future<List<PickedLocation>> call(String query) {
    return _repository.searchLocation(query);
  }
}
