import 'alphabets.dart';
import 'numbers.dart';
import 'symbols.dart';

const int charWidth = 7;
const int charHeight = 9;
const int charGap = 1;

final Map<String, List<List<int>>> pixelFont = {
  ...alphabetFont,
  ...numberFont,
  ...symbolFont,
};
