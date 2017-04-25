# Import Statements
from water_balance_classes import Parcels
from decimal import Decimal
import numpy as np
import matplotlib.pyplot as plt
import sys

# Set Constant
irr_eff = Decimal(0.65)

def program_creation(data, LU, assums):
    '''Create development program based on input file'''
    parcel_list = []
    for row in data:
        try:
            if len(row) != 3:
                raise Exception('Input data should have parcel name, land use type, and then acreage')
            elif row[1] not in LU:
                raise Exception('Invalid input land use type: {use}'.format(use = row[1]))
            else:
                parcel_list.append(Parcels(row[0], row[1], row[2], assums))
        except Exception as e:
            print(e)
            sys.exit()
    return(parcel_list)

def irr_vol(irr_area, et):
    '''Calculate an irrigation demand volume based on a given et value'''
    irr_total = Decimal(irr_area * 43560 * et/12 / irr_eff / Decimal(7.48052))
    return(irr_total)

def storage(recl, irr, month_list):
    '''Calculate storage requirement based on reclaimed water supply and irrigation demand'''
    deficit = []
    surplus = []
    reclaimed = []
    irrigation = []

    # Calculate monthly irrigation demands and determine surplus or deficit
    # Create list of each from January to December
    for month in month_list:
        reclaimed.append(recl * month.days)
        irrigation.append(irr_vol(irr, month.et) * month.days)
        # If supply exceeds demand, add surplus value.
        if reclaimed[-1] > irrigation[-1]:
            surplus.append(reclaimed[-1] - irrigation[-1])
            deficit.append(Decimal(0))
        # If demand exceeds supply, add deficit value
        else:
            surplus.append(Decimal(0))
            deficit.append(irrigation[-1] - reclaimed[-1])

    #Print a plot of monthly reclaimed water supply vs irrigation demand
    months=[]
    for x in month_list:
        months.append(x.name)
    z = range(12)
    plt.plot(z, reclaimed, 'r--', linewidth = 2.0, label = 'Reclaimed Water')
    plt.plot(z, irrigation, 'g--', linewidth = 2.0, label = 'Irrigation Demand')
    plt.xticks(z, months)
    plt.legend()
    plt.ylabel('Gallons')
    plt.show()
    plt.savefig('irrigation.pdf')

    # If demand never exceeds supply:
    if sum(deficit) == 0:
        return('''There is enough reclaimed water to account for irrigation every month
        without the need for significant storage.\n''')
    # If total demand exceeds total supply:
    elif sum(deficit) > sum(reclaimed):
        return('''There is not enough reclaimed water to meet irrigation demand.
        Consider supplementing with harvested rainwater.\n''')
    else:
        # Define water year. Start with first month with a deficit following a surplus
        # Reorder deficit and surplus lists to align with water year
        year_start = 0
        for x in range(1,12):
            if deficit[x] > 0 and deficit[x-1] == 0:
                year_start = x
                break
            else:
                pass
        def_year = deficit[year_start:]
        def_year.extend(deficit[0:year_start])
        surp_year = surplus[year_start:]
        surp_year.extend(surplus[0:year_start])
        # Initialize volume to 0
        storage_volume = 0
        # Add all monthly surpluses to storage volume to get max possible storage
        for x in surp_year:
            storage_volume += x
        # Calculate volume at beginning and end of each month
        storage_start = [storage_volume]
        storage_end = [storage_start[0] - def_year[0] + surp_year[0]]
        for x in range(1,12):
            storage_start.append(storage_end[x-1])
            storage_end.append(min(storage_start[x] - def_year[x] + surp_year[x], storage_volume))
        # Required storage equals the max volume less the amount of water at end of year
        storage_needed = storage_volume - min(storage_end)
        return ('The needed storage volume is {volume:,.0f} gallons.\n'.format(volume = storage_needed))
