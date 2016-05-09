int PlanetCount = 30;
float planetMassMin = 12;
float planetMassMax = 70;
String[] composition = {"fire", "stone", "ice", "water", "lava", "gas", "metal", "salt"};
//String[] composition = {"stone"};

JSONArray values;

void setup() {

  values = new JSONArray();

  for (int i = 0; i < PlanetCount; i++) {
    JSONObject planet = new JSONObject();
    planet.setFloat("mass", random(planetMassMin, planetMassMax));
    planet.setString("composition", composition[int(random(composition.length))]);
    planet.setInt("id", i);

    values.setJSONObject(i, planet);
  }

  saveJSONArray(values, "data/planets.json");
}