//PUTTING RELIGIOUS RELATED STUFF IN IT'S ON MODULES FOLDER FROM NOW ON. - Matt


//PROCS

//Stupidly simplistic? Probably. But I'm too tired to write something more complex.
/mob/living/proc/religion_is_legal()
	if(religion != LEGAL_RELIGION)
		return 0
	return 1



//CLOTHING
/obj/item/clothing/under/rank/arbiter
	name = "arbiter's uniform"
	desc = "A suit worn by members of the inquisition."
	icon_state = "arbiter"
	worn_state = "arbiter"
	item_state = "arbiter"

/obj/item/clothing/suit/storage/vest/arbiter
	name = "arbiter's vest"
	desc = "To protect you from heretical attacks."
	icon_state = "arbiter"
	item_state = "arbiter"
	armor = list(melee = 40, bullet = 35, laser = 40, energy = 35, bomb = 30, bio = 0, rad = 0)

/obj/item/clothing/suit/storage/vest/cowl
	name = "supreme arbiter's cowl"
	desc = "Worn by the head hancho himself."
	icon_state = "cowl"
	item_state = "cowl"
	armor = list(melee = 45, bullet = 40, laser = 45, energy = 35, bomb = 30, bio = 0, rad = 0)

/obj/item/clothing/head/helmet/arbiter
	name = "arbiter helmet"
	desc = "The standard helmet that arbiter's wear."
	icon_state = "arbiter"
	item_state = "arbiter"
	flags_inv = HIDEFACE|HIDEEARS|BLOCKHEADHAIR//Hides their identity.
	body_parts_covered = HEAD|FACE|EYES//Blocks their face and shit.

/obj/item/clothing/head/helmet/arbiter/suprme
	name = "suprme arbiter helmet"
	desc = "The standard helmet that arbiter's wear."
	icon_state = "inquisitor"
	item_state = "inquisitor"

/obj/item/clothing/head/helmet/inquisitor
	name = "supreme arbiter helmet"
	desc = "The special helmet that the supreme arbiter wears."
	icon_state = "inquisitor"
	item_state = "inquisitor"

/obj/item/clothing/gloves/arbiter
	name = "arbiter's gloves"
	desc = "The perfect gloves to wrap around a heretics neck."
	icon_state = "arbiter"
	item_state = "arbiter"

/obj/item/clothing/shoes/jackboots/arbiter//Child of jackboots to avoid copy and paste.
	name = "arbiter boots"
	desc = "Sleek, and red as the blood of the heretics."
	icon_state = "arbiter"
	item_state = "arbiter"


//REAGENTS
//The revelator toxin
/datum/reagent/toxin/revelator
	name = "revelator"
	id = "revelator"
	description = "For proving heretics."
	strength = 25//Yep, it's poisonous. To discourage random checking.

/obj/item/weapon/reagent_containers/syringe/revelator
	name = "Syringe (revelator)"
	desc = "Contains drugs for checking heretics."
	New()
		..()
		reagents.add_reagent("revelator",15)

/datum/reagent/toxin/unrevelator
	name = "unrevelator"
	id = "unrevelator"
	description = "For tricking church members."
	strength = 25//Yep, it's poisonous. To discourage taking it all the time.

/obj/item/weapon/reagent_containers/syringe/unrevelator
	name = "weird old syringe"
	desc = "You're not sure what it has."
	New()
		..()
		reagents.add_reagent("unrevelator",15)

//TOOLS
//The scanner
/obj/item/arbiter_scanner
	icon = 'icons/obj/device.dmi'
	icon_state = "arbiterscanner"
	name = "heretic scanner"
	desc = "Inject someone with revelator and then scan them for results."
	w_class = ITEM_SIZE_SMALL
	force = 0
	var/stored_info = 0

/obj/item/arbiter_scanner/attack(mob/living/L, mob/user)

	if(!L.reagents.has_reagent("revelator"))
		user.visible_message("<span class='notice'>The [src] beeps: \"ERROR: Subject needs revelator.\"</span>")

	else if(do_after(user,30))
		if(L.religion != LEGAL_RELIGION && !L.reagents.has_reagent("unrevelator"))//Unrevelator can trick the result.
			stored_info = 2
		else
			stored_info = 1
		user.visible_message("<span class='notice'>The [src] beeps: \"SCANNING COMPLETE.\"</span>")
	..()

//The machine
/obj/machinery/arbiter_computer
	var/mob/living/suspect
	name = "Heretic scanner machine"
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "arbiter_computer"
	density = 1
	anchored = 1

/obj/machinery/arbiter_computer/attackby(var/obj/item/I, var/mob/user)
	if(!istype(I,/obj/item/arbiter_scanner))
		return

	var/obj/item/arbiter_scanner/scanner = I
	if(!scanner.stored_info)
		visible_message("<span class='notice'>The [src] beeps: \"No data detected.\"</span>")
		return
	if(scanner.stored_info == 2)
		visible_message("<span class='notice'>The [src] beeps: \"Subject <b>IS</b> a heretic.\"</span>")
		return
	else
		visible_message("<span class='notice'>The [src] beeps: \"Subject is <b>NOT</b> a heretic.\"</span>")

/obj/machinery/arbiter_computer/attack_hand(mob/user as mob)
	..()
	visible_message("<span class='notice'>The [src] beeps: \"Scan subject with arbiter scanner, and then use the scanner on this machine for results.\"</span>")




//PRAYER
var/accepted_prayer //The prayer that all those who are not heretics will have.

proc/generate_random_prayer()//This generates a new one.
	var/prayer = pick("Oh great AI. ", "Oh our Lord Verina. ", "Verina, our Lord and Saviour. ")
	prayer += pick("You bathe us in your glow. ", "You bathe our minds in you omniscient wisdom. ", "You bathe our [pick("outpost","kingdom","cities")] in your wealth. ")
	prayer += pick("Verina be praised. ", "Verina save us all. ", "Verina guide us all. ")
	prayer += "Amen."
	return prayer