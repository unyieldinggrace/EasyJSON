using GLib;
using Gee;
using EasyJSON;

class JSONDemo : Object {

    public static int main(string[] args) {
      var greenFruits = new ArrayList<string>();
      greenFruits.add("pear");
      greenFruits.add("honeydew");

      var primeNumbers = new ArrayList<int>();
      primeNumbers.add(2);
      primeNumbers.add(3);
      primeNumbers.add(5);
      primeNumbers.add(7);
      primeNumbers.add(11);

      var approximations = new ArrayList<double?>();
      approximations.add(3.142);
      approximations.add(6.667);
      approximations.add(0.5);

      var flags = new ArrayList<bool>();
      flags.add(true);
      flags.add(false);

      var library = new ArrayList<Book>();
      library.add(new Book(222, "The God Who Is There", "Francis Schaeffer"));
      library.add(new Book(333, "The God Delusion", "Richard Dawkins"));
      library.add(new Book(444, "Not a Chance", "R.C. Sproul"));

      var movies = new ArrayList<JSONObject>();
      movies.add(new JSONObject("Name", JVal.String, "Serenity", "Genre", JVal.String, "Sci-fi"));
      movies.add(new JSONObject("Name", JVal.String, "Shaun of the Dead", "Genre", JVal.String, "Commedy"));
      movies.add(new JSONObject("Name", JVal.String, "Taken", "Genre", JVal.String, "Action"));

  		var obj = new JSONObject(
        "ProductID",        JVal.Int,     12345,
        "Name",             JVal.String,  "WidgetTransformer",
        "MinutesToBuild",   JVal.Double,  3.25,
        "SomeRandomObject", JVal.Object,  new JSONObject("CustomerID", JVal.Int, 67890),
        "Book",             JVal.Object,  new Book(111, "According to Plan", "Graeme Goldsworthy"),
        "NullTest",         JVal.Null,
        "LikesChocolate",   JVal.Bool,    true,
        "GreenFruits",      JVal.Array,   JVal.String, greenFruits,
        "PrimeNumbers",     JVal.Array,   JVal.Int, primeNumbers,
        "Approximations",   JVal.Array,   JVal.Double, approximations,
        "Flags",            JVal.Array,   JVal.Bool, flags,
        "Library",          JVal.Array,   JVal.Object, library,
        "Movies",          JVal.Array,   JVal.Object, movies
      );

      stdout.printf("%s\n", obj.to_string());
      return 0;
    }

}

class Book : Object {

  public Book(int bookID, string title, string author) {
    this.BookID = bookID;
    this.Title = title;
    this.Author = author;
    this.LibraryID = 123;
  }

  public int BookID { get; set; }
  public string Title { get; set; }
  public string Author { get; set; }

  // private variables are not shown
  private int LibraryID { get; set; }

}
