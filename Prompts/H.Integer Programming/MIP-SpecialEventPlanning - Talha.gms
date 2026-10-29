$ontext
Special-Event Park-and-Ride Planning Problem
CEE 6410/5410
David Rosenberg
October 10, 2026

This problem was contributed by Dr. Ran Sun and expanded by Dr. David Rosenberg

Learning objectives.
Students will be able to:
•   Define dimensions, decision variables and an objective function;
•   Formulate demand, capacity, and service-quality constraints;
•   Solve a small linear program;
•   Identify constraints;

Problem Statement
State Department of Transportation guidance for special events emphasizes advance parklotanning for transportation demand, traffic, parking, transit operations, and seating.

Passengers must also be assigned in full bus-loads of 50 passengers per bus.

Additionally, the event parklotanners must rent and bring in grandstands for the attendees. They have 2 potential venders. Each vender has an up-front reservation cost, number of seats per grandstand, and cost to load, ship, and setup a grandstand.

Vendor  Reservation cost ($)    Seats per grandstand    Cost to load, ship, and setup ($ per grandstand)
PurpleRain $1,000                   100                 200
Blue Sky    $1,500                  200                 300

Full details at https://usu.instructure.com/courses/818402/files/100525844?wrap=1

David E Rosenberg
david.rosenberg@usu.edu

Model Completed By
Talha Quddoos
talha.quddoos@usu.edu
October 09, 2026

$offtext

* 1. DEFINE the SETS or Dimensions
SETS
    i Parking Lots            /north, south, west/
    j Vendors of grandstands  /PurpleRain, BlueSky/;

* 2. DEFINE input data
PARAMETERS
   Capacity(i)          Parking lot capacity (each Number is person)                     /north 600,south 500, west  600/
   Cost(i)              Cost per passenger from parking lot ($ per person)               /north 4,south 5, west  7/
   TravelTime(i)        Travel time from parking lot (minutes)                           /north 20,south 12, west  8/
   ReservationCost(j)   Cost to reserve grandstands from vendor ($)                      /PurpleRain 1000, BlueSky    1500/    
   Seats(j)             Seats per grandstand (number)                                    /PurpleRain 100, BlueSky    200/   
   UnitCost(j)          Cost per grandstand to load ship and setup ($ per grandstand)    /PurpleRain 200, BlueSky    300/    
   MaxAverageTime       Maximum average travel time for all pasengers (minutes)          /13/
   Attendees            Number of attendees                                              /1200/
   BusCapacity          Bus Capacity (Passengers per Bus)                                /50/;


* 3. DEFINE the variables
Variables
    ECOST    Event Expense ($)
    Buses(i) Number of buses from Parking Lot (i)
    GS(j)    Number of Grandstands from a Vendor (j)
    VSelect(j)     Vendor Selection Binary (1=yes  0=No)
    

;
Integer Variable Buses, GS;
Binary Variable VSelect;


* 4. COMBINE variables and data in equations
*EQUATIONS
Equations
   Expense         Total Event Cost ($) and obj. function 
   CapLimit(i)     C: Max capacity of parking space
   TTimeLimit      C: Max Avg. Travel Time (mins)
   GSLimitSeats    C: Grandstand Limit Seats (Number)
   VendorLink(j)   C: Linking Vendor to Binary
   RshipLimit      C: All buses ride at capacity
;

*Obj Function   
Expense..          sum(i,Cost(i)*Buses(i)*BusCapacity)+sum(j,ReservationCost(j)*VSelect(j) + UnitCost(j)* GS(j)) =e=  ECOST ;

*Constraints   
CapLimit(i)..         BusCapacity * Buses(i)                          =l=  Capacity(i) ;
TTimeLimit..          sum(i, TravelTime(i) * Buses(i) * BusCapacity)  =l=  MaxAverageTime*Attendees;
GSLimitSeats..        sum(j, GS(j) * Seats(j))                        =g=  Attendees;
VendorLink(j)..       GS(j)  =l= (Attendees/Seats(j)) * VSelect(j);
RshipLimit..          sum(i, Buses(i) * BusCapacity)                   =g=  Attendees;

* 5. DEFINE the MODEL from the EQUATIONS
model EventPlanning /all/;


* 6. Solve the Model as a Mixed Integer Program
solve EventPlanning using mip minimize ECOST;

* 7. Disparklotay the decision variable values in the list file
display GS.L, Buses.L, ECOST.L;

* Dump all input data and results to a GAMS gdx file
Execute_Unload "MIP-SpecialEvent_Talha.gdx";
* Dump the gdx file to an Excel workbook
Execute "gdx2xls MIP-SpecialEvent_Talha.gdx"
