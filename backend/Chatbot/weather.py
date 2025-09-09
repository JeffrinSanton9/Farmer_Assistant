import requests

API_KEY = "be4c604837005843abcd3fe15f141b40"
BASE_URL = "http://api.openweathermap.org/data/2.5/weather"
def get_weather(city = None,units = "metric"):
    params = {
        "q": city,
        "appid":API_KEY,
        "units": units
    }
    response = requests.get(BASE_URL,params=params)
    if response.status_code == 200:
        data = response.json()
        weather = {
            "city": city,
            "temperature":data["main"]["temp"],
            "humidity":data["main"]["humidity"],
            "condition":data["weather"][0]["description"]
        }
        return weather
    else:
        return{"error":"City not found"}
    