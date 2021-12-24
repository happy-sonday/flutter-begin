import 'package:http/http.dart' as http;

void main() async {
  Uri url = "https://jsonplaceholder.typicode.com/todos/1" as Uri;
  var response = await http.get(url);
  print("status=${response.statusCode}");
  print("response=${response.body}");
}
