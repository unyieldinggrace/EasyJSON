## EasyJSON for Vala

This class adds syntactic sugar to JSON-Glib.  It's mainly meant for making it
easy to generate JSON documents for sending to single-page web applications.

### Example usage:
```vala
using EasyJSON;
...
var obj = new JSONObject(
  "ProductID",      JVal.Int,     12345,
  "Name",           JVal.String,  "WidgetTransformer",
  "MinutesToBuild", JVal.Double,  3.25
);

stdout.printf("%s\n", obj.to_string());
```

### Output:

```javascript
{
  "ProductID" : 12345,
  "Name" : "WidgetTransformer",
  "MinutesToBuild" : 3.25
}
```

### Compiling:
To compile and run the demo in this repo, use the following commands:
```bash
valac JSONObject.vala JSONDemo.vala --pkg json-glib-1.0 -o JSONDemo
./JSONDemo
```

On Ubuntu you will need to install the following packages:
```
valac
libjson-glib-1.0-0
libjson-glib-dev
```

### How it works:

Basically, it uses a variable-length argument list to construct a JSON object.

You first give the name of the next key as a string (e.g. ```"ProductID"```).  After this you give the type of value you are going to add (e.g. ```JVal.Int```). this allows statically-typed Vala to know what type of argument to expect next in the list.  Finally, you give the value itself (e.g. ```12345```).

### Supported types:

Currently, only ```String```, ```Int``` and ```Double``` are supported (because this was meant to be a proof of concept).  Support is planned for ```Array``` and ```Object```, and I'll add it when I have a spare moment.  Or you could fork the code ;)
