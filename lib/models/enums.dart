enum Zoom {
  min(height: 682),
  midLow(height: 970),
  midHigh(height: 1258),
  max(height: 1642);

  const Zoom({required this.height});
  final double height;
}

enum WeekDays {
  D(numeroDia: 0, diaCompleto: 'Domingo'),
  L(numeroDia: 1, diaCompleto: 'Lunes'),
  M(numeroDia: 2, diaCompleto: 'Martes'),
  X(numeroDia: 3, diaCompleto: 'Miércoles'),
  J(numeroDia: 4, diaCompleto: 'Jueves'),
  V(numeroDia: 5, diaCompleto: 'Viernes'),
  S(numeroDia: 6, diaCompleto: 'Sábado');

  const WeekDays({required this.diaCompleto, required this.numeroDia});
  final String diaCompleto;
  final int numeroDia;
}

enum TimeSlot {
  h0000(i: 0, hour: 0, time: '00:00 - 00:15', start: '00:00', end: '00:15', timeOfDay: 'AM'),
  h0015(i: 1, hour: 0, time: '00:15 - 00:30', start: '00:15', end: '00:30', timeOfDay: 'AM'),
  h0030(i: 2, hour: 0, time: '00:30 - 00:45', start: '00:30', end: '00:45', timeOfDay: 'AM'),
  h0045(i: 3, hour: 0, time: '00:45 - 01:00', start: '00:45', end: '01:00', timeOfDay: 'AM'),
  h0100(i: 4, hour: 1, time: '01:00 - 01:15', start: '01:00', end: '01:15', timeOfDay: 'AM'),
  h0115(i: 5, hour: 1, time: '01:15 - 01:30', start: '01:15', end: '01:30', timeOfDay: 'AM'),
  h0130(i: 6, hour: 1, time: '01:30 - 01:45', start: '01:30', end: '01:45', timeOfDay: 'AM'),
  h0145(i: 7, hour: 1, time: '01:45 - 02:00', start: '01:45', end: '02:00', timeOfDay: 'AM'),
  h0200(i: 8, hour: 2, time: '02:00 - 02:15', start: '02:00', end: '02:15', timeOfDay: 'AM'),
  h0215(i: 9, hour: 2, time: '02:15 - 02:30', start: '02:15', end: '02:30', timeOfDay: 'AM'),
  h0230(i: 10, hour: 2, time: '02:30 - 02:45', start: '02:30', end: '02:45', timeOfDay: 'AM'),
  h0245(i: 11, hour: 2, time: '02:45 - 03:00', start: '02:45', end: '03:00', timeOfDay: 'AM'),
  h0300(i: 12, hour: 3, time: '03:00 - 03:15', start: '03:00', end: '03:15', timeOfDay: 'AM'),
  h0315(i: 13, hour: 3, time: '03:15 - 03:30', start: '03:15', end: '03:30', timeOfDay: 'AM'),
  h0330(i: 14, hour: 3, time: '03:30 - 03:45', start: '03:30', end: '03:45', timeOfDay: 'AM'),
  h0345(i: 15, hour: 3, time: '03:45 - 04:00', start: '03:45', end: '04:00', timeOfDay: 'AM'),
  h0400(i: 16, hour: 4, time: '04:00 - 04:15', start: '04:00', end: '04:15', timeOfDay: 'AM'),
  h0415(i: 17, hour: 4, time: '04:15 - 04:30', start: '04:15', end: '04:30', timeOfDay: 'AM'),
  h0430(i: 18, hour: 4, time: '04:30 - 04:45', start: '04:30', end: '04:45', timeOfDay: 'AM'),
  h0445(i: 19, hour: 4, time: '04:45 - 05:00', start: '04:45', end: '05:00', timeOfDay: 'AM'),
  h0500(i: 20, hour: 5, time: '05:00 - 05:15', start: '05:00', end: '05:15', timeOfDay: 'AM'),
  h0515(i: 21, hour: 5, time: '05:15 - 05:30', start: '05:15', end: '05:30', timeOfDay: 'AM'),
  h0530(i: 22, hour: 5, time: '05:30 - 05:45', start: '05:30', end: '05:45', timeOfDay: 'AM'),
  h0545(i: 23, hour: 5, time: '05:45 - 06:00', start: '05:45', end: '06:00', timeOfDay: 'AM'),
  h0600(i: 24, hour: 6, time: '06:00 - 06:15', start: '06:00', end: '06:15', timeOfDay: 'AM'),
  h0615(i: 25, hour: 6, time: '06:15 - 06:30', start: '06:15', end: '06:30', timeOfDay: 'AM'),
  h0630(i: 26, hour: 6, time: '06:30 - 06:45', start: '06:30', end: '06:45', timeOfDay: 'AM'),
  h0645(i: 27, hour: 6, time: '06:45 - 07:00', start: '06:45', end: '07:00', timeOfDay: 'AM'),
  h0700(i: 28, hour: 7, time: '07:00 - 07:15', start: '07:00', end: '07:15', timeOfDay: 'AM'),
  h0715(i: 29, hour: 7, time: '07:15 - 07:30', start: '07:15', end: '07:30', timeOfDay: 'AM'),
  h0730(i: 30, hour: 7, time: '07:30 - 07:45', start: '07:30', end: '07:45', timeOfDay: 'AM'),
  h0745(i: 31, hour: 7, time: '07:45 - 08:00', start: '07:45', end: '08:00', timeOfDay: 'AM'),
  h0800(i: 32, hour: 8, time: '08:00 - 08:15', start: '08:00', end: '08:15', timeOfDay: 'AM'),
  h0815(i: 33, hour: 8, time: '08:15 - 08:30', start: '08:15', end: '08:30', timeOfDay: 'AM'),
  h0830(i: 34, hour: 8, time: '08:30 - 08:45', start: '08:30', end: '08:45', timeOfDay: 'AM'),
  h0845(i: 35, hour: 8, time: '08:45 - 09:00', start: '08:45', end: '09:00', timeOfDay: 'AM'),
  h0900(i: 36, hour: 9, time: '09:00 - 09:15', start: '09:00', end: '09:15', timeOfDay: 'AM'),
  h0915(i: 37, hour: 9, time: '09:15 - 09:30', start: '09:15', end: '09:30', timeOfDay: 'AM'),
  h0930(i: 38, hour: 9, time: '09:30 - 09:45', start: '09:30', end: '09:45', timeOfDay: 'AM'),
  h0945(i: 39, hour: 9, time: '09:45 - 10:00', start: '09:45', end: '10:00', timeOfDay: 'AM'),
  h1000(i: 40, hour: 10, time: '10:00 - 10:15', start: '10:00', end: '10:15', timeOfDay: 'AM'),
  h1015(i: 41, hour: 10, time: '10:15 - 10:30', start: '10:15', end: '10:30', timeOfDay: 'AM'),
  h1030(i: 42, hour: 10, time: '10:30 - 10:45', start: '10:30', end: '10:45', timeOfDay: 'AM'),
  h1045(i: 43, hour: 10, time: '10:45 - 11:00', start: '10:45', end: '11:00', timeOfDay: 'AM'),
  h1100(i: 44, hour: 11, time: '11:00 - 11:15', start: '11:00', end: '11:15', timeOfDay: 'AM'),
  h1115(i: 45, hour: 11, time: '11:15 - 11:30', start: '11:15', end: '11:30', timeOfDay: 'AM'),
  h1130(i: 46, hour: 11, time: '11:30 - 11:45', start: '11:30', end: '11:45', timeOfDay: 'AM'),
  h1145(i: 47, hour: 11, time: '11:45 - 12:00', start: '11:45', end: '12:00', timeOfDay: 'AM'),
  h1200(i: 48, hour: 12, time: '12:00 - 12:15', start: '12:00', end: '12:15', timeOfDay: 'PM'),
  h1215(i: 49, hour: 12, time: '12:15 - 12:30', start: '12:15', end: '12:30', timeOfDay: 'PM'),
  h1230(i: 50, hour: 12, time: '12:30 - 12:45', start: '12:30', end: '12:45', timeOfDay: 'PM'),
  h1245(i: 51, hour: 12, time: '12:45 - 13:00', start: '12:45', end: '13:00', timeOfDay: 'PM'),
  h1300(i: 52, hour: 13, time: '13:00 - 13:15', start: '13:00', end: '13:15', timeOfDay: 'PM'),
  h1315(i: 53, hour: 13, time: '13:15 - 13:30', start: '13:15', end: '13:30', timeOfDay: 'PM'),
  h1330(i: 54, hour: 13, time: '13:30 - 13:45', start: '13:30', end: '13:45', timeOfDay: 'PM'),
  h1345(i: 55, hour: 13, time: '13:45 - 14:00', start: '13:45', end: '14:00', timeOfDay: 'PM'),
  h1400(i: 56, hour: 14, time: '14:00 - 14:15', start: '14:00', end: '14:15', timeOfDay: 'PM'),
  h1415(i: 57, hour: 14, time: '14:15 - 14:30', start: '14:15', end: '14:30', timeOfDay: 'PM'),
  h1430(i: 58, hour: 14, time: '14:30 - 14:45', start: '14:30', end: '14:45', timeOfDay: 'PM'),
  h1445(i: 59, hour: 14, time: '14:45 - 15:00', start: '14:45', end: '15:00', timeOfDay: 'PM'),
  h1500(i: 60, hour: 15, time: '15:00 - 15:15', start: '15:00', end: '15:15', timeOfDay: 'PM'),
  h1515(i: 61, hour: 15, time: '15:15 - 15:30', start: '15:15', end: '15:30', timeOfDay: 'PM'),
  h1530(i: 62, hour: 15, time: '15:30 - 15:45', start: '15:30', end: '15:45', timeOfDay: 'PM'),
  h1545(i: 63, hour: 15, time: '15:45 - 16:00', start: '15:45', end: '16:00', timeOfDay: 'PM'),
  h1600(i: 64, hour: 16, time: '16:00 - 16:15', start: '16:00', end: '16:15', timeOfDay: 'PM'),
  h1615(i: 65, hour: 16, time: '16:15 - 16:30', start: '16:15', end: '16:30', timeOfDay: 'PM'),
  h1630(i: 66, hour: 16, time: '16:30 - 16:45', start: '16:30', end: '16:45', timeOfDay: 'PM'),
  h1645(i: 67, hour: 16, time: '16:45 - 17:00', start: '16:45', end: '17:00', timeOfDay: 'PM'),
  h1700(i: 68, hour: 17, time: '17:00 - 17:15', start: '17:00', end: '17:15', timeOfDay: 'PM'),
  h1715(i: 69, hour: 17, time: '17:15 - 17:30', start: '17:15', end: '17:30', timeOfDay: 'PM'),
  h1730(i: 70, hour: 17, time: '17:30 - 17:45', start: '17:30', end: '17:45', timeOfDay: 'PM'),
  h1745(i: 71, hour: 17, time: '17:45 - 18:00', start: '17:45', end: '18:00', timeOfDay: 'PM'),
  h1800(i: 72, hour: 18, time: '18:00 - 18:15', start: '18:00', end: '18:15', timeOfDay: 'PM'),
  h1815(i: 73, hour: 18, time: '18:15 - 18:30', start: '18:15', end: '18:30', timeOfDay: 'PM'),
  h1830(i: 74, hour: 18, time: '18:30 - 18:45', start: '18:30', end: '18:45', timeOfDay: 'PM'),
  h1845(i: 75, hour: 18, time: '18:45 - 19:00', start: '18:45', end: '19:00', timeOfDay: 'PM'),
  h1900(i: 76, hour: 19, time: '19:00 - 19:15', start: '19:00', end: '19:15', timeOfDay: 'PM'),
  h1915(i: 77, hour: 19, time: '19:15 - 19:30', start: '19:15', end: '19:30', timeOfDay: 'PM'),
  h1930(i: 78, hour: 19, time: '19:30 - 19:45', start: '19:30', end: '19:45', timeOfDay: 'PM'),
  h1945(i: 79, hour: 19, time: '19:45 - 20:00', start: '19:45', end: '20:00', timeOfDay: 'PM'),
  h2000(i: 80, hour: 20, time: '20:00 - 20:15', start: '20:00', end: '20:15', timeOfDay: 'PM'),
  h2015(i: 81, hour: 20, time: '20:15 - 20:30', start: '20:15', end: '20:30', timeOfDay: 'PM'),
  h2030(i: 82, hour: 20, time: '20:30 - 20:45', start: '20:30', end: '20:45', timeOfDay: 'PM'),
  h2045(i: 83, hour: 20, time: '20:45 - 21:00', start: '20:45', end: '21:00', timeOfDay: 'PM'),
  h2100(i: 84, hour: 21, time: '21:00 - 21:15', start: '21:00', end: '21:15', timeOfDay: 'PM'),
  h2115(i: 85, hour: 21, time: '21:15 - 21:30', start: '21:15', end: '21:30', timeOfDay: 'PM'),
  h2130(i: 86, hour: 21, time: '21:30 - 21:45', start: '21:30', end: '21:45', timeOfDay: 'PM'),
  h2145(i: 87, hour: 21, time: '21:45 - 22:00', start: '21:45', end: '22:00', timeOfDay: 'PM'),
  h2200(i: 88, hour: 22, time: '22:00 - 22:15', start: '22:00', end: '22:15', timeOfDay: 'PM'),
  h2215(i: 89, hour: 22, time: '22:15 - 22:30', start: '22:15', end: '22:30', timeOfDay: 'PM'),
  h2230(i: 90, hour: 22, time: '22:30 - 22:45', start: '22:30', end: '22:45', timeOfDay: 'PM'),
  h2245(i: 91, hour: 22, time: '22:45 - 23:00', start: '22:45', end: '23:00', timeOfDay: 'PM'),
  h2300(i: 92, hour: 23, time: '23:00 - 23:15', start: '23:00', end: '23:15', timeOfDay: 'PM'),
  h2315(i: 93, hour: 23, time: '23:15 - 23:30', start: '23:15', end: '23:30', timeOfDay: 'PM'),
  h2330(i: 94, hour: 23, time: '23:30 - 23:45', start: '23:30', end: '23:45', timeOfDay: 'PM'),
  h2345(i: 95, hour: 23, time: '23:45 - 00:00', start: '23:45', end: '00:00', timeOfDay: 'PM');

  const TimeSlot({
    required this.i,
    required this.hour,
    required this.time,
    required this.start,
    required this.end,
    required this.timeOfDay,
  });
  final int i;
  final int hour;
  final String time;
  final String start;
  final String end;
  final String timeOfDay;
}
