
XML xml;

void setup() {
  xml = loadXML("books.xml");
  XML[] children = xml.getChildren("book");

  println("Author's Names version 1:");
  for (int i = 0; i < children.length; i++) {
    println(children[i].getChild("author").getChild(0));
  }

  println("\nAuthor's Names version 2:");
  for (int i = 0; i < children.length; i++) {
    println(children[i].getChild("author").getContent());
  }

  println("\nAuthor's Names version 3:");
  for (int i = 0; i < children.length; i++) {
    println(children[i].getChild(1).getChild(0));
  }

  println("\nAuthor's Names version 4:");
  for (int i = 0; i < children.length; i++) {
    println(children[i].getChild(1).getContent());
  }
}