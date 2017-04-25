Michael Amodeo
Python Bridge Course
Midterm Project
Water Balance analysis

# Project Description
This project was created as a midterm assignment in my Python course. It was intended to exhibit our familiarity with the basic data structures in Python, including lists, dictionaries, and particularly classes. My project calculates water demands for a theoretical development in a location specified by the user. The development program is input as either a csv or txt file, with the additional functionality to allow manual input. A sample land use typology with water use and development assumptions is included but would be customized per project. The script pulls precipitation and evapotranspiration data from two different websites.

It should also be noted that the demand calculations may not be entirely correct. The assignment was primarily to show our knowledge of python materials, not necessarily domain knowledge. If this project were to be used to evaluate water demands for an actual development project, it should be reviewed for  accuracy.

# Execution Instructions
To run project, run the file "water_balance_run.py" from the command line. The project will then walk the user through additional prompts to perform the analysis:

1. First, the user will need to specify the zip code of the project site in a 5 digit format. The program will re-prompt the user if the zip code is not a valid US zip code. Once the program has a valid zip, it will pull climate data from online resources.

2. Next, the user will be asked to input a development program for analysis. This program can be a txt file with comma separated values or a csv file. One of each are provided for use in the project folder ("default_program"). An option also allows for use of a default program. The user also has the option to enter the acreage per land use type from a preset list of land use types.The program will then use this data to initialize class instances of parcels and land uses and calculate several different categories of water demands and potential supplies. This data is output in the form of several tables printed to the screen (scroll up to see them all!)

3. The program will also prompt the user to analyze the monthly irrigation demands to see if water recycled on site from wastewater flows is a viable supply for irrigation given the climate data and development program. This module will output a graph of potential reclaimed water supply vs irrigation demand. This graph is also saved as a PDF in the project folder ("irrigation.pdf").

# Internal Project Performance
Internally, the program also imports development assumptions per land use type from a file called "land_uses.txt". This file can be edited by a sophisticated user per project as assumptions change. However, for the purposes of this project, it is assumed that these assumptions will not change and the user is not given the ability to change them within the project.

There is also a version of the default program that has errors coded in to demonstrate the error checking of the program ("program_with_error.txt"). This file includes an invalid land use type, as well as an entry missing a proper acreage value. There are possible errors that are not controlled within the program coding (such as incorrect types), but those would cause failures by the interpreter. Again, it is assumed that the user supplies mostly correct data in the input files (numbers where there should be numbers).

# File Structure
"Water_balance_run.py" contains the majority of the coding for running the program. It also includes the data that would be specific to each project, as that would only be created once. Much of this data is in list format and is passed into the class initialization for calculation purposes. However, it is not contained within the classes as an attribute as each class instance would share the same values, potentially creating many unnecessary objects in memory.

"Water_balance_classes.py" includes the classes used in the program, with all initializations, attributes, and methods.

"WB_functions.py" contains a few additional functions that were not included within the classes. Some of these could be called at any time, and are thus included in this file.

"project_testing.ipynb" was used to test specific elements of code a few lines at a time. It can be ignored.

"free-zipcode-database-Primary.csv" is used by the program to verify that user input is a valid US zipcode and to give project location (city and state). Do not edit.
