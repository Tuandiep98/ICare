import 'package:bloc/bloc.dart';
import 'package:ICare/api/api_repository.dart';
import 'package:ICare/models/response_top_headlinews_news.dart';


abstract class DataState {}

class DataInitial extends DataState {}

class DataLoading extends DataState {}

class DataSuccess extends DataState {
  final List<News> data;

  DataSuccess(this.data);
}

class DataFailed extends DataState {
  final String errorMessage;

  DataFailed(this.errorMessage);
}

class DataEvent {
  final String category;

  DataEvent(this.category);
}

class HomeBloc extends Bloc<DataEvent, DataState> {
  @override
  DataState get initialState => DataInitial();

  @override
  Stream<DataState> mapEventToState(DataEvent event) async* {
    yield DataLoading();
    final apiRepository = ApiRepository();
    final categoryLowerCase = event.category.toLowerCase();
    switch (categoryLowerCase) {
      case 'tất cả':
        final data = await apiRepository.fetchTopHeadlinesNews();
        if (data.length > 0) {
          yield DataSuccess(data);
        } else {
          yield DataFailed('Failed to fetch data');
        }
        break;
      case 'nóng':
        final data = await apiRepository.tinTucNong();
        if (data.length > 0) {
          yield DataSuccess(data);
        } else {
          yield DataFailed('Failed to fetch data');
        }
        break;
      case 'khỏe đẹp':
        final data = await apiRepository.tinTucKhoeDep();
        if (data.length > 0) {
          yield DataSuccess(data);
        } else {
          yield DataFailed('Failed to fetch data');
        }
        break;
      case 'y học':
        final data = await apiRepository.tinTucYHoc();
        if (data.length > 0) {
          yield DataSuccess(data);
        } else {
          yield DataFailed('Failed to fetch data');
        }
        break;
      case 'dinh dưỡng':
        final data = await apiRepository.tinTucDinhDuong();
        if (data.length > 0) {
          yield DataSuccess(data);
        } else {
          yield DataFailed('Failed to fetch data');
        }
        break;
      case 'giới tính':
        final data = await apiRepository.tinTucGioitinh();
        if (data != null) {
          yield DataSuccess(data);
        } else {
          yield DataFailed('Failed to fetch data');
        }
        break;
      case 'dịch bệnh':
        final data = await apiRepository.tinTucDichBenh();
        if (data != null) {
          yield DataSuccess(data);
        } else {
          yield DataFailed('Failed to fetch data');
        }
        break;
      case 'mẹo cần biết':
        final data = await apiRepository.tinTucMeoCanBiet();
        if (data != null) {
          yield DataSuccess(data);
        } else {
          yield DataFailed('Failed to fetch data');
        }
        break;
      default:
        yield DataFailed('Unknown category');
    }
  }
}
