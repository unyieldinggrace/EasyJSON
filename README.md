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
  "MinutesToBuild", JVal.Double,  3.25,
  "Book",           JVal.Object,  new Book(123, "Not a Chance", "R.C. Sproul"), // Some GObject
  "Fruits",         JVal.Array,   JVal.String, listOfFruits // Some Gee.Collection<string>
);

stdout.printf("%s\n", obj.to_string());
```

### Output:

```javascript
{
  "ProductID" : 12345,
  "Name" : "WidgetTransformer",
  "MinutesToBuild" : 3.25,
  "Book" : {
    "BookID" : 123,
    "Title": "Not a Chance",
    "Author": "R.C. Sproul"
  },
  "Fruits" : ["apple", "banana", "cherry"]
}
```

This is just a taste, the example code in ```JSONDemo.vala``` covers just about every possibility.

### Compiling:
To compile and run the demo in this repo, use the following commands:
```bash
valac JSONObject.vala JSONDemo.vala --pkg json-glib-1.0 --pkg gee-1.0 -o JSONDemo
./JSONDemo
```

On Ubuntu you will need to install the following packages:
```
valac
libjson-glib-1.0-0
libjson-glib-dev
libgee-dev
```

### How it works:

Basically, it uses a variable-length argument list to construct a JSON object.

You first give the name of the next key as a string (e.g. ```"ProductID"```).  After this you give the type of value you are going to add (e.g. ```JVal.Int```). this allows statically-typed Vala to know what type of argument to expect next in the list.  Finally, you give the value itself (e.g. ```12345```).

### Supported types:

Currently, all the basic JSON types (```String```, ```Int``` and ```Double```, ```Bool```, ```Object```, ```Array```) are supported.  There are a couple of caveats:
* Arrays of arrays are not supported (though arrays of objects are fine)
* Arrays of null values are not supported

### The Big Gotcha:

Using this method to generate JSON can result in runtime errors (including segfaults!) if you pass in incorrect arguments.  The whole point is that the compiler doesn't what order the different argument types must come in (hence the need for ```JVal```s).  If you say you're going to pass in an integer with ```JVal.Int```, then pass in a ```double```, things will explode at ***runtime***, but the Vala compiler will not say a word.  The best safeguard is make sure that all calls to ```new JSONObject()``` are executed in a unit test.
