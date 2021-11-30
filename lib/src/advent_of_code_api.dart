import 'package:http/http.dart' as http;

class AdventOfCode {
  final String _sessionCookie;
  final String _year = '2021';

  AdventOfCode(this._sessionCookie);

  Future<String> getPuzzleInputOfDay(int day) async {
    var response = await http.get(
      Uri.parse('https://adventofcode.com/' + _year + '/day/' + day.toString() + '/input'),
      headers: {'Cookie': _sessionCookie},
    );

    return response.body;
  }
}
