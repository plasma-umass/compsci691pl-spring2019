# Interfaces for Polygon

Implement a type Polygon that is defined by three or more points defined as Positions 
(where Position is a type as defiend in the book), and then implement the
Ord and Eq interfaces for Polygon, where an ordering is defined as the number of sides. 

For instance, given:
	
	triangle1 : Polygon
	triangle1 = Simp (0,0) (0,3) (3,0)

	triangle2 : Polygon
	triangle2 = Simp (1,0) (10,10) (9,3)

	square : Polygon
	square : Ext (2,0) (Simp (2,2) (0,2) (0,0))

`triangle1` should equal `triangle2` and be less than `square`


