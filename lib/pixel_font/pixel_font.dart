import 'alphabets.dart';
import 'numbers.dart';
import 'symbols.dart';

const int charWidth = 14;
const int charHeight = 18;
const int charGap = 2;

final Map<String, List<List<int>>> pixelFont = {
  ...alphabetFont,
  ...numberFont,
  ...symbolFont,
};
