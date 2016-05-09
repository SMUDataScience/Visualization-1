Table table;
String filename = "AccidentData";
void setup() {
  table = loadTable(filename+".csv");
  // 2 is months column
  // 41 is fatals column
  int[] monthFatals = new int[12];
  // start i as 1 to avoid initial row of labels
  for (int i=1; i<table.getRowCount(); i++) {
    switch(table.getInt(i, 2)) {
    case 1:
      monthFatals[0] += table.getInt(i, 41);
      break;
    case 2:
      monthFatals[1] += table.getInt(i, 41);
      break;
    case 3:
      monthFatals[2] += table.getInt(i, 41);
      break;
    case 4:
      monthFatals[3] += table.getInt(i, 41);
      break;
    case 5:
      monthFatals[4] += table.getInt(i, 41);
      break;
    case 6:
      monthFatals[5] += table.getInt(i, 41);
      break;
    case 7:
      monthFatals[6] += table.getInt(i, 41);
      break;
    case 8:
      monthFatals[7] += table.getInt(i, 41);
      break;
    case 9:
      monthFatals[8] += table.getInt(i, 41);
      break;
    case 10:
      monthFatals[9] += table.getInt(i, 41);
      break;
    case 11:
      monthFatals[10] += table.getInt(i, 41);
      break;
    case 12:
      monthFatals[11] += table.getInt(i, 41);
      break;
    }
  }

  println(monthFatals);
}