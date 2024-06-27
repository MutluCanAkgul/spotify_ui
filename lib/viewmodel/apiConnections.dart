import 'dart:convert';
import 'dart:io';
import 'package:spotify_ui/model/homepagedatamodel.dart';
import 'package:spotify_ui/model/librarypagedatamodel.dart';
import 'package:spotify_ui/model/searchpagedatamodel.dart';
Future<LibraryPageDataModel> libraryapiCall() async {
  final httpClient = HttpClient();
  const int maxRetries = 3;
  int retries = 0;

  while (retries < maxRetries) {
    try {
      final request =
          await httpClient.getUrl(Uri.parse('http://localhost:3000/library'));
      final response = await request.close();

      if (response.statusCode == 200) {
        final responseBody = await response.transform(utf8.decoder).join();

       
        List<dynamic> jsonResponse = json.decode(responseBody);
        return LibraryPageDataModel.fromJson(jsonResponse);
      } else {
        throw Exception('Bir Hata oluştu: Status code ${response.statusCode}');
      }
    } on SocketException catch (e) {
      if (retries >= maxRetries - 1) {
        throw Exception('Bir Hata oluştu: $e');
      }
      retries++;
      await Future.delayed(
          const Duration(seconds: 2));
    } on FormatException catch (e) {
      throw Exception('Bir Hata oluştu: Invalid JSON format: $e');
    }
  }

  httpClient.close();
  throw Exception('Bir Hata oluştu: Max retries reached');
}
Future<SearchPageLocalData> searchapiCall() async {
  final httpClient = HttpClient();
  const int maxRetries = 3;
  int retries = 0;

  while (retries < maxRetries) {
    try {
      final request = await httpClient.getUrl(Uri.parse('http://localhost:3000/category'));
      final response = await request.close();

      if (response.statusCode == 200) {
        final responseBody = await response.transform(utf8.decoder).join();
        print('API Response: $responseBody'); // Debugging line

        List<dynamic> jsonResponse = json.decode(responseBody);
        return SearchPageLocalData.fromJson(jsonResponse);
      } else {
        throw Exception('Bir Hata oluştu: Status code ${response.statusCode}');
      }
    } on SocketException catch (e) {
      if (retries >= maxRetries - 1) {
        throw Exception('Bir Hata oluştu: $e');
      }
      retries++;
      await Future.delayed(const Duration(seconds: 2));
    } on FormatException catch (e) {
      throw Exception('Bir Hata oluştu: Invalid JSON format: $e');
    }
  }

  httpClient.close();
  throw Exception('Bir Hata oluştu: Max retries reached');
}

Future<HomePageDataModel> homeapiCall() async {
  final httpClient = HttpClient();
  const int maxRetries = 3;
  int retries = 0;

  while (retries < maxRetries) {
    try {
      final request =
          await httpClient.getUrl(Uri.parse('http://localhost:3000/homepage'));
      final response = await request.close();

      if (response.statusCode == 200) {
        final responseBody = await response.transform(utf8.decoder).join();

        
        List<dynamic> jsonResponse = json.decode(responseBody);
        return HomePageDataModel.fromJson(jsonResponse);
      } else {
        throw Exception('Bir Hata oluştu: Status code ${response.statusCode}');
      }
    } on SocketException catch (e) {
      if (retries >= maxRetries - 1) {
        throw Exception('Bir Hata oluştu: $e');
      }
      retries++;
      await Future.delayed(
          const Duration(seconds: 2));
    } on FormatException catch (e) {
      throw Exception('Bir Hata oluştu: Invalid JSON format: $e');
    }
  }

  httpClient.close();
  throw Exception('Bir Hata oluştu: Max retries reached');
}