# Import Statements
from decimal import Decimal

# Set Constants
reclaimed_eff = Decimal(0.85)
wastewater_eff = Decimal(0.85)

# Class setups
class Assumptions:
    '''Establish assumptions per land use with the following items from an
    input list:
        LU, FAR, pop_density, num_stories, demands, percent_pot,
        percent_softscape, percent_irr)'''
    def __init__(self, data):
        self.LU_type = data[0]
        self.FAR = Decimal(data[1])
        self.pop_density = Decimal(data[2])
        self.num_stories = Decimal(data[3])
        self.internal_demands = Decimal(float(data[4])*0.264172) # convert L to gal
        self.percent_pot = Decimal(data[5])
        self.percent_softscape = Decimal(data[6])
        self.percent_irr = Decimal(data[7])

class Parcels:
    '''Create instances of parcels, base unit of analysis, from inputs'''
    def __init__(self, name, LU_type, acreage, assums):
        # Possible error if there is no matching land use controlled
        # in program_creation function in WB_functions.py
        for x in assums:
            # Establish which assumptions to use based on LU type
            if x.LU_type == LU_type:
                assums_use = x
                break
            else:
                pass
        self.name = name # unique parcel identifier
        self.LU_type = LU_type
        self.area = Decimal(acreage)
        self.demands(acreage, assums_use)

    def demands(self, area, assums_use):
        '''Create demands for each parcel'''
        self.built = Decimal(self.area * 43560 * assums_use.FAR)
        self.population = Decimal(self.built / assums_use.pop_density)
        self.footprint = Decimal(self.built / assums_use.num_stories)
        self.potable = Decimal(self.population * assums_use.internal_demands
                        * assums_use.percent_pot)
        self.nonpotable = Decimal(self.population * assums_use.internal_demands
                            * (1 - assums_use.percent_pot))
        self.wastewater = Decimal(self.potable + self.nonpotable) * wastewater_eff
        self.reclaimed = Decimal(self.wastewater * reclaimed_eff)
        self.rainwater = self.footprint
        self.irrarea = Decimal(self.area * assums_use.percent_softscape
                        * assums_use.percent_irr)

    def print_parcels(self):
        print('{:<15} | {:<15} {:>10,.0f}'.format(self.name, self.LU_type, self.area))

class LUTotals:
    '''Aggregate demands to project totals'''
    area = built = population = footprint = potable = nonpotable = 0
    wastewater = reclaimed = rainwater = irrarea = 0

    def __init__(self, LU_type, parcel_list):
        '''Aggregate demands by land use type'''
        self.LU_type = LU_type
        self.area = self.built = self.population = self.footprint = 0
        self.potable = self.nonpotable = self.wastewater = self.reclaimed = 0
        self.rainwater = self.irrarea = 0
        self.demands(parcel_list)

    def demands(self, parcel_list):
        for y in parcel_list:
            if y.LU_type == self.LU_type:
                self.area += y.area
                self.built += y.built
                self.population += y.population
                self.footprint += y.footprint
                self.potable += y.potable
                self.nonpotable += y.nonpotable
                self.wastewater += y.wastewater
                self.reclaimed += y.reclaimed
                self.rainwater += y.rainwater
                self.irrarea += y.irrarea
                LUTotals.area += y.area
                LUTotals.built += y.built
                LUTotals.population += y.population
                LUTotals.footprint += y.footprint
                LUTotals.potable += y.potable
                LUTotals.nonpotable += y.nonpotable
                LUTotals.wastewater += y.wastewater
                LUTotals.reclaimed += y.reclaimed
                LUTotals.rainwater += y.rainwater
                LUTotals.irrarea += y.irrarea
            else:
                pass

    def print_LUs(self):
        print('{:<15} | {:>10,.0f} {:>12,.0f} {:>10,.0f}'.format(self.LU_type,
                self.area, self.built, self.population))

    def print_demands(self):
        print("{:<13} | {:>13,.0f} {:>13,.0f} {:>13,.0f} | {:>13,.0f} {:>13,.0f} {:>13,.0f}".format(
        self.LU_type, self.potable, self.nonpotable, irr_vol(x.irrarea, Decimal(max(et))),
        x.wastewater, x.reclaimed, x.rainwater))

    @classmethod
    def print_totals(cls):
        print('-'*52)
        print('{:<15} | {:>10,.0f} {:>12,.0f} {:>10,.0f}\n'.format('Totals',
                cls.area, cls.built, cls.population))

class Month:
    '''Create classes to store monthly data including climate and days'''
    def __init__(self, name, days, precip, et):
        self.name = name
        self.days = days
        self.precip = precip
        self.et = et
