using GLib;
using EasyJSON;

class JSONDemo : Object {

    public static int main(string[] args) {
      int[] manufacturerIDs = {111, 222, 333};

      var book = new Book(1, 2);

  		var obj = new JSONObject(
        "ProductID", JVal.Int, 12345,
        "Name", JVal.String, "WidgetTransformer",
        "MinutesToBuild", JVal.Double, 3.25,
        "SomeRandomObject", JVal.Object, new JSONObject("CustomerID", JVal.Int, 67890),
        "Book", JVal.Object, book
        "ManufacturerIDs", JVal.Array, JVal.Int, manufacturerIDs
      );

      stdout.printf("%s\n", obj.to_string());
      return 0;
    }

}

class Book : Object {

  public Book(int bookID, int libraryID) {
    this.BookID = bookID;
    this.LibraryID = libraryID;
  }

  public int BookID { get; set; }
  private int LibraryID { get; set; }

}
