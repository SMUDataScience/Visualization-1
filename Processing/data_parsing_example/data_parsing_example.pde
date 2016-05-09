void setup() {

  String lines[] = loadStrings("AccidentData.csv");
  println("there are " + lines.length + " lines");

  ArrayList<ArrayList<Integer>> vals = new ArrayList<ArrayList<Integer>>();

  for (int i = 0; i < lines.length; i++) {
    String[] temp = split(lines[i], ",");
    ArrayList<Integer> val = new ArrayList<Integer>();
    for (int j=0; j<temp.length; j++) {
      val.add(new Integer(int(temp[j])));
    }
    vals.add(val);
  }
  // fatals is at [41]

  // get cumulative fatals ver month
  for (int i = 0; i < vals.size(); i++) {
    for (int j = 0; j < vals.get(i).size(); j++) {
      println(vals.get(i).size());
      //  println(vals.get(i).get(j));
      //
    }
  }
}

void draw() {
}