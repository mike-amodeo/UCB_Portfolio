# Import Commands and Libraries
from lxml import html
from decimal import Decimal
import requests
import csv
import sys
#Import local project elements
from water_balance_classes import Assumptions, Parcels, LUTotals, Month
from WB_functions import storage, irr_vol, program_creation

# Constants
occupancy = Decimal(0.75) # hotels and schools only
months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug',
            'Sep', 'Oct', 'Nov', 'Dec']
days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

# Establish assumptions per land use type
with open("land_uses.txt","r") as infile:
    raw_input = infile.readlines()
    raw_data = [datum.strip('\n') for datum in raw_input]
    LUdata = [lines.split(', ') for lines in raw_data]

# Create lists of class objects for all land use assumptions
assums = []
LU = [] # list of all valid land uses
for uses in LUdata[1:]: # ignore header
    assums.append(Assumptions(uses))
    LU.append(assums[-1].LU_type)

# Establish Project Location Inputs
zip_code = str(input("\nPlease enter a 5 digit zip code for the project site: "))
# error handling - verify it is within a list of valid US zip codes
allzips=[]
locations = []
with open("free-zipcode-database-Primary.csv", newline='') as infile:
    data = csv.reader(infile, delimiter=',')
    for row in data:
        allzips.append(row[0])
        locations.append((row[0],row[2],row[3]))
while zip_code not in allzips:
    zip_code = str(input("Please enter a valid US five digit zip code: "))
location = locations[allzips.index(zip_code)][1] + ', ' + locations[allzips.index(zip_code)][2]

# Web scraping for climate data.
# Assign a list of values for evapotranspiration and precip by month.
args = {'ZipCode':zip_code}
page = requests.get(
    'https://www.melissadata.com/lookups/zipweather.asp', params=args)
tree = html.fromstring(page.content)
extracted = []
for x in range(4,16):
    extracted.append(tree.xpath(
        '//table[@class="Tableresultborder"]/tr['+str(x)+']/td[7]/b/text()'))
# Convert from list of lists into list of floats
precip=[]
for val in extracted:
    precip.append(float(val[0]))

#Sample Evapotranspiration Data - couldn't get webscraping to work
et = [0.04, 0.07, 0.1, 0.14, 0.17, 0.18, 0.2, 0.17, 0.16, 0.12,
        0.06, 0.04] # in/day

# Create list of months as class instances
month_list=[]
for x in range(0,12):
    month_list.append(Month(months[x], days[x], precip[x],
        Decimal(et[x])))
# Calculate total annual precip and evapotranspiration (inches)
precip_ann = sum(precip)
et_ann = Decimal(0)
for x in month_list:
    et_ann += x.days * x.et

# Input program
parcel_list = []
program = str(input('''\nPlease select the number of the option to create a development program:
    1. Import a text file of parcels,
    2. Use a default program, or
    3. Input acreage by land use? \n'''))
while program not in '123':
    program = str(input("Please enter 1, 2, or 3: "))
if program == '1':
    # Allow for import of text file, call instances of class parcels
    # Specify file name:
    prog_text = str(input("\nWhat is the full name of the program file? "))
    # Import data from file to list
    if prog_text.endswith('.csv'):
        with open(prog_text, newline='') as infile:
            data = csv.reader(infile, delimiter=',')
            parcel_list = program_creation(data, LU, assums)
    elif prog_text.endswith('.txt'):
        with open(prog_text,"r") as infile:
            raw_input = infile.readlines()
            data = list([datum.strip('\n').split(',') for datum in raw_input])
            # Create parcel list by class instances
            parcel_list = program_creation(data, LU, assums)
    else: # not a csv or txt file
        "Please run again with either a csv or txt file."
        sys.exit()
elif program == '2':
    # Create parcel instances from default text file
    with open("default_program.csv", newline='') as infile:
        data = csv.reader(infile, delimiter=',')
        parcel_list = program_creation(data, LU, assums)
elif program == '3':
    for use in LU:
        # Add input control for numbers
        acreage = float(input('Please enter the total area of {use} in acres: '.format(use=use)))
        parcel_list.append(Parcels('Parcel ' + str(use), use, acreage, assums))

# Create instances of totals (each land use is an instance)
totals = []
for use in LU:
    totals.append(LUTotals(str(use), parcel_list))

## OUTPUT
# Climate Table
print("\nMonthly climate data for {location} (inches): ".format(location = location))
print("-"*60)
print("{:^4} {:^4} {:^4} {:^4} {:^4} {:^4} {:^4} {:^4} {:^4} {:^4} {:^4} {:^4}".format(*months))
print("{:^4} {:^4} {:^4} {:^4} {:^4} {:^4} {:^4} {:^4} {:^4} {:^4} {:^4} {:^4}".format(*precip))
print("{:^4} {:^4} {:^4} {:^4} {:^4} {:^4} {:^4} {:^4} {:^4} {:^4} {:^4} {:^4}\n".format(*et))

# Program - Parcel Table
print('\nPROGRAM\n')
print('{:<15} | {:<15} {:>10}'.format('Parcel', 'Land Use Type', 'Area (ac)'))
print("-"*44)
# Call print function as a method for each instance
for x in parcel_list:
    x.print_parcels()
print()

# Program - Land Use Summary
print('\nPROGRAM SUMMARY\n')
print('{:<15} | {:^10} {:^12} {:^10}'.format('Land Use Type',
        'Area (ac)', 'Gross SF', 'Population'))
print("-"*52)
# Call print function as a method for each instance
for x in totals:
    x.print_LUs()
# Call print function as a class method to give project totals
LUTotals.print_totals()
print()

# Demands Table
col_headers = ['Land Use','Potable', 'Non-Potable', 'Irrigation', 'Wastewater',
    'Reclaimed', 'Rainwater']

print('\nDEMAND SUMMARY\n')
print("{:^13} | {:^41} | {:^41}".format('','Demands (Max Day gpd)','Potential Sources (Max Day gpd)'))
print("{:^13} | {:^13} {:^13} {:^13} | {:^13} {:^13} {:^13}".format(*col_headers))
print("-"*102)
# did not make this print a method within class because of nested function call
for x in totals:
    print("{:<13} | {:>13,.0f} {:>13,.0f} {:>13,.0f} | {:>13,.0f} {:>13,.0f} {:>13,.0f}".format(
    x.LU_type, x.potable, x.nonpotable, irr_vol(x.irrarea, Decimal(max(et))),
    x.wastewater, x.reclaimed, x.rainwater))
print("-"*102)
print('{:<13} | {:>13,.0f} {:>13,.0f} {:>13,.0f} | {:>13,.0f} {:>13,.0f} {:>13,.0f}\n'.format(
    'Totals', LUTotals.potable, LUTotals.nonpotable,
    irr_vol(LUTotals.irrarea, Decimal(max(et))), LUTotals.wastewater,
    LUTotals.reclaimed, LUTotals.rainwater))

# Ask to evaluate scenarios:
#   Reclaimed water for irrigation? Call function from external module
scen1 = str(input('''\nWould you like to know how much storage would be needed
to meet irrigation demand with reclaimed water? (yes or no) ''')).lower()

# Run Additional Scenarios
if scen1 == 'yes':
    print('\n' + storage(LUTotals.reclaimed, LUTotals.irrarea, month_list))
else:
    print('Have a nice day!\n')
