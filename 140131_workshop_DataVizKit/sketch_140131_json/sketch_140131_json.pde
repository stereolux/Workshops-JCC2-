/**
 * http://tryit.sunlightfoundation.com/influenceexplorer
 * Returns the top contributing organizations, ranked by total dollars given.
 * An organization's giving is broken down into money given directly (by the organization's PAC)
 * versus money given by individuals employed by or associated with the organization. 
 */
 
 // other possible call:
 // http://transparencydata.com/api/1.0/entities.json?search=Bloomberg&type=politician&apikey=f02c91d9cd13472eb8a1822a5c8e5450
 
// data object holding json data
JSONArray jsonData;

String entityID = "4148b26f6f1c437cb50ea9ca4699417a";
int cycle = 2012;
int limit = 10;

void setup() {

  size(1024, 768);
  
  // create the api call
  String apiCall = "http://transparencydata.com/api/1.0/aggregates/pol/" + entityID + "/contributors.json"
    + "?cycle=" + cycle
    + "&limit=" + limit
    + "&apikey=f02c91d9cd13472eb8a1822a5c8e5450";
  
  // print out the api call. you can put it in the browser and see the raw data
  println(apiCall);
  
  // get the data into the json object
  jsonData = loadJSONArray(apiCall);


  // print out the data for testing purpose
  for (int i = 0; i < jsonData.size(); i++) {
    
    JSONObject contributor = jsonData.getJSONObject(i); 

    String name = contributor.getString("name");
    float total_amount = contributor.getFloat("total_count");
    int total_count = contributor.getInt("total_count");
    
    println(name + ", " + total_amount + ", " + total_count);
  }
  
}

void draw() {
  background(255);
  
  noStroke();
  fill(150);
  
  for (int i = 0; i < jsonData.size(); i++) {
    
    JSONObject contributor = jsonData.getJSONObject(i); 

    String name = contributor.getString("name");
    float total_amount = contributor.getFloat("total_count");
    int total_count = contributor.getInt("total_count");
    
    float barWidth = total_amount*0.1;
    
    // draw name of contributor
    text(name, 20, 113 + i*20);
    
    // draw amount behind bar
    text(total_amount + "$", 200 + barWidth + 5, 113 + i*20);
    
    // draw bar chart
    rect(200, 100 + i*20, barWidth, 15);
  }

}
