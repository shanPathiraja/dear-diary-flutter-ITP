import 'package:dear_diary/src/db/models/post_model.dart';

class HomePageState {
  List<Post> posts;
  String errorMessage;
  String errorTitle;
  int batteryLevel;
  bool isLoading;

  HomePageState({
    required this.posts,
    required this.errorMessage,
    required this.errorTitle,
    required this.batteryLevel,
    required this.isLoading,
  });

  static HomePageState get initialState => HomePageState(
        posts: [],
        errorMessage: '',
        errorTitle: '',
        batteryLevel: 0,
        isLoading: false,
      );

  HomePageState clone({
    List<Post>? posts,
    String? errorMessage,
    String? errorTitle,
    int? batteryLevel,
    bool? isLoading,
  }) {
    return HomePageState(
      posts: posts ?? this.posts,
      errorMessage: errorMessage ?? this.errorMessage,
      errorTitle: errorTitle ?? this.errorTitle,
      batteryLevel: batteryLevel ?? this.batteryLevel,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
