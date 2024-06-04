import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class CardPhotos {
  static Future<List<Uint8List>> fetchPhotosFromDatabase() async {
    final response = await http.get(Uri.parse("http://192.168.8.193/memory_card_photos/conn1.php"));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Uint8List> photos = <Uint8List> [];
      for (dynamic item in data) {
        try {
          String base64Image = item['photo'];
          Uint8List bytes = base64.decode(base64Image);
          photos.add(bytes);
        } catch (e) {
          print('Error decoding image: $e');
        }
      }
      // photos.shuffle(); // Shuffle the list of photos
      return photos;
    } else {
      throw Exception('Failed to fetch photos from the database');
    }
  }
}