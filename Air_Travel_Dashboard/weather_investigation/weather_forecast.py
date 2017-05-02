
import urllib2
import json
import csv
import requests

# Import airports with lat lon
with open('weather_data/airports.csv', mode='r') as infile:
    reader = csv.reader(infile)
    airports = dict((rows[2],(rows[18], rows[23])) for rows in reader)

# 25 Busiest US Airports
top25 = ['ATL', 'ORD', 'DFW', 'DEN', 'LAX', 'PHX', 'IAH', 'LAS', 'DTW', 'MSP', 'EWR', 'SLC',
    'SFO', 'MCO', 'BOS', 'CLT', 'JFK', 'LGA', 'BWI', 'SEA', 'PHL', 'SAN', 'MDW', 'DCA', 'TPA']

# Import likelihood results
with open('flight_app/final_csv/Q3_likelihood_based_on_depth.csv', mode = 'r') as infile:
    reader = csv.reader(infile)
    likelihood_data = dict((rows[0],(rows[1], rows[2], rows[3], rows[4], rows[5], rows[6], rows[7], rows[8])) for rows in reader)
#likelihood_data = csv.reader(open('/flight_app/final_csv/Q3_likelihood_based_on_depth.csv', 'rb'))

# Import volume of flights
volume = {}
with open('flight_app/final_csv/top25airportsdep.csv', mode = 'r') as infile:
    reader = csv.reader(infile)
    reader.next()
    for rows in reader:
        volume[rows[1]] = (int(rows[2]) + int(rows[3]) + int(rows[4]) + int(rows[5]) + int(rows[6]) + int(rows[7]) + int(rows[8]) + int(rows[9]) + int(rows[10]) + int(rows[11]))/3650

# Get weather data

# Set some empty dictionaries to populate
rain = {}
likelihood = {}
delays = {}
headers = ['Origin','','','','','','','','','','']

# Iterate through 25 busiest airports by 3 leter code
for code in top25:
    lat = airports[code][0]
    lon = airports[code][1]
    # Get weather data for each airport based on airport lat/lon
    f = urllib2.urlopen('http://api.wunderground.com/api/bd7371e9065e60d4/forecast10day/q/{0},{1}.json'.format(lat, lon))
    json_string = f.read()
    parsed_json = json.loads(json_string)

    # Assmeble daily rainfall depth
    rain_temp = []
    j = 1 # set counter
    # Iterate through days of 10 day forecast
    for day in parsed_json['forecast']['simpleforecast']['forecastday']:
        rain_temp.append(float(day['qpf_allday']['mm']))
        headers[j] = day['date']['weekday'] # Add date to be header of export
        j += 1
    rain[code] = rain_temp

    # Assemble delay likelihood per day based on rainfall depth
    likelihood_temp = []
    for i in range(len(rain_temp)):
        if rain_temp[i] == 0:
            likelihood_temp.append(float(likelihood_data[code][0]))
        elif rain_temp[i] <= 6.3:
            likelihood_temp.append(float(likelihood_data[code][1]))
        elif rain_temp[i] <= 12.7:
            likelihood_temp.append(float(likelihood_data[code][2]))
        elif rain_temp[i] <= 25.4:
            likelihood_temp.append(float(likelihood_data[code][3]))
        elif rain_temp[i] <= 38.1:
            likelihood_temp.append(float(likelihood_data[code][4]))
        elif rain_temp[i] <= 50.8:
            likelihood_temp.append(float(likelihood_data[code][5]))
        elif rain_temp[i] <= 76.2:
            likelihood_temp.append(float(likelihood_data[code][6]))
        else:
            likelihood_temp.append(float(likelihood_data[code][7]))
    likelihood[code] = likelihood_temp

    # Calculate delays per day based on delay likelihood and forecasted depth
    delays_temp = []
    for i in range(len(rain_temp)):
        delays_temp.append(round(volume[code] * likelihood_temp[i],0))
    delays[code] = delays_temp

    f.close()

# Export Delays with a header.
with open('flight_app/final_csv/Q4_forecast_delays.csv', 'wb') as outfile:
    w = csv.writer(outfile)
    w.writerow(headers)
    for key in delays.keys():
        w.writerow((key, delays[key][0], delays[key][1], delays[key][2], delays[key][3], delays[key][4], delays[key][5], delays[key][6], delays[key][7], delays[key][8], delays[key][9]))

# Export predicted rainfall
with open('flight_app/final_csv/Q5_forecast_rain.csv', 'wb') as outfile:
    w = csv.writer(outfile)
    w.writerow(headers)
    for key in rain.keys():
        w.writerow((key, delays[key][0], delays[key][1], delays[key][2], delays[key][3], delays[key][4], delays[key][5], delays[key][6], delays[key][7], delays[key][8], delays[key][9]))
