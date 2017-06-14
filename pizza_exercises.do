* read csv tables and save to separate TEMP files
local tables eats frequents person serves
tempfile `tables'
foreach table in `tables' {
	import delimited "input/pizza/`table'.csv", clear delimiter(",") varnames(1) case(preserve)
	save ``table'', replace
	
	* what is in this string?
	di "`table'"
	* where is the tempfile?
	di "``table''"
}

* a.  Find all pizzerias frequented by at least one person under the age of 18.
use `person', clear

* since there is only one dataframe in memory at once, i don't have to say what dataframe i am referring to
keep if age<18
merge 1:m name using `frequents', keep(match)

list pizzeria

* b. Find the names of all females who eat either mushroom or pepperoni pizza (or both).
use `person', clear
keep if gender=="female"
merge 1:m name using `eats', keep(match)

keep if inlist(pizza,"mushroom","pepperoni")
* alternatively
keep if (pizza=="mushroom")|(pizza=="pepperoni")

list name
