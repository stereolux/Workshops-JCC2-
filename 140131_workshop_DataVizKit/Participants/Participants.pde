Table table;

void setup() {

  table = loadTable("JCC2.csv", "header, tsv");

  println(table.getRowCount() + " total rows in table"); 

  for (TableRow row : table.rows()) {

    String name = row.getString("Prénom");
    String position = row.getString("Position IP");
    String date = row.getString("Type de billet");

    println(name + " (" + position + ") subscriped on " + date);
  }
}

