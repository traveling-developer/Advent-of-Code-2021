import 'package:adventofcode2021/src/day12.dart';
import 'package:test/test.dart';

void main() {
  group('day 12', () {
    test('solveFirstPuzzle - samll example input - returns expected result', () {
      var smallExample = '''start-A
start-b
A-c
A-b
b-d
A-end
b-end''';
      final day = Day12();

      final solution = day.solveFirstPuzzle(smallExample);

      expect(solution, equals('10'));
    });

    test('solveFirstPuzzle - medium example input - returns expected result', () {
      var medium = '''dc-end
HN-start
start-kj
dc-start
dc-HN
LN-dc
HN-end
kj-sa
kj-HN
kj-dc''';
      final day = Day12();

      final solution = day.solveFirstPuzzle(medium);

      expect(solution, equals('19'));
    });

    test('solveFirstPuzzle - large example input - returns expected result', () {
      var large = '''fs-end
he-DX
fs-he
start-DX
pj-DX
end-zg
zg-sl
zg-pj
pj-he
RW-he
fs-DX
pj-RW
zg-RW
start-pj
he-WI
zg-he
pj-fs
start-RW''';
      final day = Day12();

      final solution = day.solveFirstPuzzle(large);

      expect(solution, equals('226'));
    });

    test('solveSecondPuzzle - small example input - returns expected result', () {
      var smallExample = '''start-A
start-b
A-c
A-b
b-d
A-end
b-end''';
      final day = Day12();

      final solution = day.solveSecondPuzzle(smallExample);

      expect(solution, equals('36'));
    });

    test('solveSecondPuzzle - medium example input - returns expected result', () {
      var medium = '''dc-end
HN-start
start-kj
dc-start
dc-HN
LN-dc
HN-end
kj-sa
kj-HN
kj-dc''';
      final day = Day12();

      final solution = day.solveSecondPuzzle(medium);

      expect(solution, equals('103'));
    });

    test('solveSecondPuzzle - large example input - returns expected result', () {
      var large = '''fs-end
he-DX
fs-he
start-DX
pj-DX
end-zg
zg-sl
zg-pj
pj-he
RW-he
fs-DX
pj-RW
zg-RW
start-pj
he-WI
zg-he
pj-fs
start-RW''';
      final day = Day12();

      final solution = day.solveSecondPuzzle(large);

      expect(solution, equals('3509'));
    });
  });
}
