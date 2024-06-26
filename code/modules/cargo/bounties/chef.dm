//Moved (most) bounties requiring botany to gardencook.dm Roundstart cook bounties go here.

/datum/bounty/item/chef/soup
	name = "Soup"
	description = "To quell the homeless uprising, Nanotrasen will be serving soup to all underpaid workers. Ship any type of soup. Do NOT ship bowls of water."
	reward = 4000
	required_count = 4
	wanted_types = list(/obj/item/reagent_containers/food/snacks/soup)
	exclude_types = list(/obj/item/reagent_containers/food/snacks/soup/wish)

/datum/bounty/item/chef/icecreamsandwich
	name = "Ice Cream Sandwiches"
	description = "Upper management has been screaming non-stop for ice cream. Please send some."
	reward = 4300
	required_count = 5
	wanted_types = list(/obj/item/reagent_containers/food/snacks/icecreamsandwich)

/datum/bounty/item/chef/bread
	name = "Bread"
	description = "Problems with central planning have led to bread prices skyrocketing. Ship some bread to ease tensions."
	reward = 2800
	wanted_types = list(/obj/item/reagent_containers/food/snacks/store/bread, /obj/item/reagent_containers/food/snacks/breadslice, /obj/item/reagent_containers/food/snacks/bun, /obj/item/reagent_containers/food/snacks/pizzabread, /obj/item/reagent_containers/food/snacks/rawpastrybase)

/datum/bounty/item/chef/pie
	name = "Pie"
	description = "3.14159? No! CentCom management wants edible pie! Ship a whole one."
	reward = 3142
	wanted_types = list(/obj/item/reagent_containers/food/snacks/pie)

/datum/bounty/item/gardencook/khinkali
	name = "Khinkali"
	description = "Requesting -some khinki stuff- for a private staff party at Centcom."
	reward = 4900
	required_count = 6
	wanted_types = list(/obj/item/reagent_containers/food/snacks/khinkali)

/datum/bounty/item/chef/salad
	name = "Salad or Rice Bowls"
	description = "CentCom management is going on a health binge. Your order is to ship salad or rice bowls."
	reward = 3600
	required_count = 3
	wanted_types = list(/obj/item/reagent_containers/food/snacks/salad)

// /datum/bounty/item/chef/cubancarp
// 	name = "Cuban Carp"
// 	description = "To celebrate the birth of Castro XXVII, ship one cuban carp to CentCom."
// 	reward = 3000
// 	wanted_types = list(/obj/item/reagent_containers/food/snacks/cubancarp)

/datum/bounty/item/chef/hotdog
	name = "Hot Dog"
	description = "Nanotrasen is conducting taste tests to determine the best hot dog recipe. Ship your station's version to participate."
	reward = 6500
	wanted_types = list(/obj/item/reagent_containers/food/snacks/hotdog)

/datum/bounty/item/chef/muffin
	name = "Muffins"
	description = "The Muffin Man is visiting CentCom, but he's forgotten his muffins! Your order is to rectify this."
	reward = 7500
	required_count = 3
	wanted_types = list(/obj/item/reagent_containers/food/snacks/muffin)

/datum/bounty/item/chef/chawanmushi
	name = "Chawanmushi"
	description = "Nanotrasen wants to improve relations with its sister company, Japanotrasen. Ship Chawanmushi immediately."
	reward = 7000
	wanted_types = list(/obj/item/reagent_containers/food/snacks/chawanmushi)

/datum/bounty/item/chef/kebab
	name = "Kebabs"
	description = "Remove all kebab from station you are best food. Ship to CentCom to remove from the premises."
	reward = 4500
	required_count = 3
	wanted_types = list(/obj/item/reagent_containers/food/snacks/kebab)

/datum/bounty/item/chef/soylentgreen
	name = "Soylent Green"
	description = "CentCom has heard wonderful things about the product 'Soylent Green', and would love to try some. If you endulge them, expect a pleasant bonus."
	reward = 5900
	wanted_types = list(/obj/item/reagent_containers/food/snacks/soylentgreen)

/datum/bounty/item/chef/pancakes
	name = "Pancakes"
	description = "Here at Nanotrasen we consider employees to be family. And you know what families love? Pancakes. Ship a baker's dozen."
	reward = 7000
	required_count = 13
	wanted_types = list(/datum/crafting_recipe/food/pancakes)

/datum/bounty/item/chef/nuggies
	name = "Chicken Nuggets"
	description = "The vice president's son won't shut up about chicken nuggies. Would you mind shipping some?"
	reward = 5900
	required_count = 6
	wanted_types = list(/obj/item/reagent_containers/food/snacks/nugget)

/datum/bounty/item/chef/khachapuri
	name = "Khachapuri"
	description = "Bread and eggs. Bread and eggs. Bread and eggs. Also, cheese."
	reward = 4700
	required_count = 2
	wanted_types = list(/obj/item/reagent_containers/food/snacks/khachapuri)

/datum/bounty/item/chef/ratkebab
	name = "Rat Kebabs"
	description = "Centcom is requesting some -special- kebabs for it's service staff."
	reward = 4500
	required_count = 3
	wanted_types = list(/obj/item/reagent_containers/food/snacks/kebab/rat)

/datum/bounty/item/chef/benedict
	name = "Eggs Benedict"
	description = "Command requires a high-calory breakfast item. Ship it right away."
	reward = 4400
	wanted_types = list(/obj/item/reagent_containers/food/snacks/benedict)

/datum/bounty/item/chef/braincake
	name = "Brain Cake"
	description = "The science division requires a brain cake for testing purposes. Don't ask."
	reward = 4000
	wanted_types = list(/obj/item/reagent_containers/food/snacks/store/cake/brain)

/datum/bounty/item/chef/waffles
	name = "Waffles"
	description = "Security staff at Centcom are looking for a fun treat. Ship us some waffles so they can fill the cells."
	reward = 3800
	wanted_types = list(/obj/item/reagent_containers/food/snacks/waffles)

/datum/bounty/item/chef/sugarcookie
	name = "Sugar Cookies"
	description = "Everyone needs a little sugar in their life. Ship some sweets to Command so we can satiate our sweet tooth."
	reward = 3400
	required_count = 6
	wanted_types = list(/obj/item/reagent_containers/food/snacks/sugarcookie)

/datum/bounty/item/chef/bbqribs
	description = "There's a debate around command as to weather or not ribs should be considered finger food, and we need a few delicious racks to process."
	reward = 3000
	required_count = 3
	wanted_types = list(/obj/item/reagent_containers/food/snacks/bbqribs)

/datum/bounty/item/chef/corgifarming //Butchering is a chef's job.
	name = "Corgi Hides"
	description = "Admiral Weinstein's space yacht needs new upholstery. A dozen Corgi furs should do just fine."
	reward = 70000 //that's a lot of dead dogs
	required_count = 12
	wanted_types = list(/obj/item/stack/sheet/animalhide/corgi)
