namespace EasyJSON {

  class JSONObject {

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
              string value = args.arg();
              this.builder.add_string_value(value);
              break;

            case JVal.Int:
              int value = args.arg();
              this.builder.add_int_value(value);
              break;

            case JVal.Double:
              double value = args.arg();
              this.builder.add_double_value(value);
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

  }

  enum JVal {
    String,
    Int,
    Double,

    // support for these is planned (or you could fork the code!)
    Array,
    Object
  }

}
