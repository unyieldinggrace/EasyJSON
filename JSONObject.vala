using Gee;

namespace EasyJSON {

  class JSONObject : GLib.Object {

    private Json.Builder builder;
    private Json.Generator generator;

    public JSONObject(string firstKey, ...) {
      this.builder = new Json.Builder();
      this.generator = new Json.Generator();

      this.builder.begin_object();
      var firstKeyUsed = false;

      var args = va_list();
      while (true) {
          string? key = null;
          if (firstKeyUsed) {
            key = args.arg();
          } else {
            key = firstKey;
            firstKeyUsed = true;
          }

          if (key == null) {
              break; // end of the list
          }

          this.builder.set_member_name(key);
          JVal type = args.arg();

          switch (type) {
            case JVal.String:
              string val = args.arg();
              this.builder.add_string_value(val);
              break;

            case JVal.Bool:
              bool val = args.arg();
              this.builder.add_boolean_value(val);
              break;

            case JVal.Null:
              this.builder.add_null_value();
              break;

            case JVal.Int:
              int val = args.arg();
              this.builder.add_int_value(val);
              break;

            case JVal.Double:
              double val = args.arg();
              this.builder.add_double_value(val);
              break;

            case JVal.Array:
              JVal arrayType = args.arg();
              switch (arrayType) {
                case JVal.String:
                  Collection<string> arrayValues = args.arg();
                  this.add_string_array(arrayValues);
                  break;

                case JVal.Bool:
                  Collection<bool> arrayValues = args.arg();
                  this.add_bool_array(arrayValues);
                  break;

                case JVal.Int:
                  Collection<int> arrayValues = args.arg();
                  this.add_int_array(arrayValues);
                  break;

                case JVal.Double:
                  Collection<double?> arrayValues = args.arg();
                  this.add_double_array(arrayValues);
                  break;

                case JVal.Object:
                  Collection<Object> arrayValues = args.arg();
                  this.add_object_array(arrayValues);
                  break;
              }

              break;

            case JVal.Object:
              JSONObject? val = args.arg();
              this.add_object(val);
              break;
          }
      }

      this.builder.end_object();
      this.generator.set_root(builder.get_root());
      this.generator.set_pretty(true);
    }

    public string to_string() {
      return this.generator.to_data(null);
    }

    public Json.Node? get_root_node() {
      return this.builder.get_root();
    }

    private void add_string_array(Collection<string> values) {
      this.builder.begin_array();
      foreach (string value in values) {
        this.builder.add_string_value(value);
      }

      this.builder.end_array();
    }

    private void add_int_array(Collection<int> values) {
      this.builder.begin_array();
      foreach (int value in values) {
        this.builder.add_int_value(value);
      }

      this.builder.end_array();
    }

    private void add_double_array(Collection<double?> values) {
      this.builder.begin_array();
      foreach (double value in values) {
        this.builder.add_double_value(value);
      }

      this.builder.end_array();
    }

    private void add_bool_array(Collection<bool> values) {
      this.builder.begin_array();
      foreach (bool value in values) {
        this.builder.add_boolean_value(value);
      }

      this.builder.end_array();
    }

    private void add_object_array(Collection<Object> values) {
      this.builder.begin_array();
      foreach (Object value in values) {
        this.add_object(value);
      }

      this.builder.end_array();
    }

    private void add_object(Object obj) {
      if (obj is JSONObject) {
        this.add_json_object(obj as JSONObject);
        return;
      }

      var rootNode = Json.gobject_serialize(obj);
      this.builder.add_value(rootNode);
    }

    private void add_json_object(JSONObject obj) {
      var rootNode = obj.get_root_node();
      if (rootNode == null) {
        this.builder.add_null_value();
      } else {
        this.builder.add_value(rootNode);
      }
    }

  }

  enum JVal {
    Null,
    Bool,
    Int,
    Double,
    String,
    Object,
    Array
  }

}
