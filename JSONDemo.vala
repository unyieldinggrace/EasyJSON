using GLib;
using EasyJSON;

class JSONDemo : Object {

    public static int main(string[] args) {
  		var obj = new JSONObject(
        "ProductID", JVal.Int, 12345,
        "Name", JVal.String, "WidgetTransformer",
        "MinutesToBuild", JVal.Double, 3.25
      );

      stdout.printf("%s\n", obj.to_string());
      return 0;
    }

}
