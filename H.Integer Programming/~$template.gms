$onText

This is a simple supply chain production planning model, as a linear optimization problem.

Our enterprise is a leading supplier of lighting systems.

There are 3 products with a sales forecast for the upcoming year. Sales forecasted customer demand to be:

    rear lamp: 1400 pcs
    head lamp: 1300 pcs
    interior lighting: 1450 pcs


There are 3 factories in three different countries. Each plant is available for 360 time units within given period.

Processing time of product in production is measured in units of time per piece produced:

    rear lamp: 0.30
    head lamp: 0.25
    interior lighting: 0.45


All products are transported to the central distribution center, located in Germany.
Sourcing costs (incl. production costs) per unit (piece) differ by product and factory:

                    rear lamp       head lamp       interior lighting
factory Spain          0.57             0.55                0.75            
factory Poland         0.25             0.22                0.60   
factory Italy          0.45             0.45                0.45

The unit-based sales revenues by product are estimated to be as follows:

    rear lamp: 1.5
    head lamp: 2.0
    interior lighting: 3.5


Considering this, what is the optimal sourcing and production plan?

$offText

*    defining indices for factory and product set

set
    i factories /spain, poland, italy/
    j products /rear, head, interior/;

    defining maximum available time unit

scalar
    time available time units /360/;

*    defining parameters and data for demand, processing times, product prices and schedule slots

parameter
    demand(j)    customer demand                               /rear 1400, head 1300, interior 1450/
    procTime(j)  processing times                              /rear 0.30, head 0.25, interior 0.45/
    prices(j)    sales revenue by product                      /rear 1.50, head 2.00, interior 3.50/;

*   defining sourcing costs as a table

table c(i,j) sourcing cost by unit from factory to distribution center
        rear    head    interior
spain   0.57    0.55    0.75
poland  0.25    0.22    0.60
italy   0.45    0.45    0.45;

*    decision variable specifying number of pieces to be produced at given factory

integer variable
    volume(i,j) volume of product j produced at and transported from factory i;

volume.lo(i,j) = 0;

*    variable for measuring the profit (this variable will be the goal being optimized)

variable
    profit profit measured as sales revenue less sourcing costs;

    modeling the equations and constraints

equation
    profitability profit from sales after transport and production costs
    market(j) market demand per product
    mfgcapacity(i) equation for modeling capacity constraints at factories;

profitability..     sum(i,sum(j,volume(i,j)*(prices(j)-c(i,j)))) =e= profit;
market(j)..         sum(i,volume(i,j)) =l= demand(j);
mfgcapacity(i)..    sum(j,procTime(j)*volume(i,j)) =l= time;
    

    construct the model

model supplychainmodel /all/;

    solve the problem using linear programming (maximize profit)

solve supplychainmodel using mip maximize profit;