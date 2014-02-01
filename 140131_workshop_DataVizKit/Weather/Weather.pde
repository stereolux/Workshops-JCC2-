void setup() {
  println( getWeather( "Nantes" ) );
  exit();
}

String getWeather(String where) {
  try {
    XML xml;
    String feed = ("http://api.openweathermap.org/data/2.5/weather?q=" + where + "&units=metric&mode=xml"); //Get the feed
    xml = loadXML(feed); //Stick the feed into a variable
    String weather = xml.getChild("weather").getString("value"); //this returns "broken clouds"
    String high = xml.getChild("temperature").getString("max"); // this returns "10"
    String low = xml.getChild("temperature").getString("min"); //this returns "4"
    String humidity = xml.getChild("humidity").getString("value"); //this returns "96"

    String weatherString = "The current weather in " + where + " is " + weather +
      " with a low of " + low + " degrees celcius, and a high of " + high + 
      " degrees celcius. Humidity will be at " + humidity + "%.";

    return weatherString;
  }
  catch (Exception e) {
    return "sorry, could not find the weather in " + where + " ( " + e + " )";
  }
}

