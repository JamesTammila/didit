String formatDate(String date) {
  final String day = DateTime.parse(date).day.toString();
  final int month = DateTime.parse(date).month;
  final String year = DateTime.parse(date).year.toString();
  switch (month) {
    case 1: return '$day Jan $year';
    case 2: return '$day Feb $year';
    case 3: return '$day Mar $year';
    case 4: return '$day Apr $year';
    case 5: return '$day May $year';
    case 6: return '$day Jun $year';
    case 7: return '$day Jul $year';
    case 8: return '$day Aug $year';
    case 9: return '$day Sep $year';
    case 10: return '$day Oct $year';
    case 11: return '$day Nov $year';
    case 12: return '$day Dec $year';
    default: throw Exception('Err');
  }
}