/datum/component/butchering
	var/speed = 80 //time in deciseconds taken to butcher something
	var/effectiveness = 100 //percentage effectiveness; numbers above 100 yield extra drops
	var/bonus_modifier = 0 //percentage increase to bonus item chance
	var/butcher_sound = 'sound/effects/butcher.ogg' //sound played when butchering
	var/butchering_enabled = TRUE
	var/can_be_blunt = FALSE

/datum/component/butchering/Initialize(_speed, _effectiveness, _bonus_modifier, _butcher_sound, disabled, _can_be_blunt)
	if(_speed)
		speed = _speed
	if(_effectiveness)
		effectiveness = _effectiveness
	if(_bonus_modifier)
		bonus_modifier = _bonus_modifier
	if(_butcher_sound)
		butcher_sound = _butcher_sound
	if(disabled)
		butchering_enabled = FALSE
	if(_can_be_blunt)
		can_be_blunt = _can_be_blunt
	if(isitem(parent))
		RegisterSignal(parent, COMSIG_ITEM_ATTACK, PROC_REF(onItemAttack))

/datum/component/butchering/proc/onItemAttack(obj/item/source, mob/living/M, mob/living/user)
	SIGNAL_HANDLER

	if(user.a_intent != INTENT_HARM)
		return
	if(M.stat == DEAD && (M.butcher_results || M.guaranteed_butcher_results)) //can we butcher it?
		if(butchering_enabled && (can_be_blunt || source.get_sharpness()))
			INVOKE_ASYNC(src, PROC_REF(startButcher), source, M, user)
			return COMPONENT_CANCEL_ATTACK_CHAIN

	if(ishuman(M) && source.force && source.get_sharpness())
		var/mob/living/carbon/human/H = M
		if((user.pulling == H && user.grab_state >= GRAB_AGGRESSIVE) && user.zone_selected == BODY_ZONE_HEAD) // Only aggressive grabbed can be sliced.
			if(HAS_TRAIT(user, TRAIT_PACIFISM))
				to_chat(user, span_warning("You don't want to harm other living beings!"))
				return COMPONENT_CANCEL_ATTACK_CHAIN

			if(H.has_status_effect(/datum/status_effect/neck_slice))
				return

			INVOKE_ASYNC(src, PROC_REF(startNeckSlice), source, H, user)
			return COMPONENT_CANCEL_ATTACK_CHAIN

/datum/component/butchering/proc/startButcher(obj/item/source, mob/living/M, mob/living/user)
	to_chat(user, "<span class='notice'>You begin to butcher [M]...</span>")
	playsound(M.loc, butcher_sound, 50, TRUE, -1)
	if(do_mob(user, M, speed) && M.Adjacent(source))
		Butcher(user, M)

/datum/component/butchering/proc/startNeckSlice(obj/item/source, mob/living/carbon/human/H, mob/living/user)
	if(INTERACTING_WITH(user, H))
		to_chat(user, span_warning("You're already interacting with [H]!"))
		return

	user.visible_message(span_danger("[user] is slitting [H]'s throat!"), \
					span_danger("You start slicing [H]'s throat!"), \
					span_hear("You hear a cutting noise!"), ignored_mobs = H)
	H.show_message(span_userdanger("Your throat is being slit by [user]!"), MSG_VISUAL, \
					span_userdanger("Something is cutting into your neck!"), NONE)
	log_combat(user, H, "attempted throat slitting", source)

	playsound(H.loc, butcher_sound, 50, TRUE, -1)
	if(do_after(user, clamp(200 / source.force, 30, 100), H) && H.Adjacent(source))
		if(H.has_status_effect(/datum/status_effect/neck_slice))
			user.show_message(span_warning("[H]'s neck has already been already cut, you can't make the bleeding any worse!"), MSG_VISUAL, \
							span_warning("Their neck has already been already cut, you can't make the bleeding any worse!"))
			return

		H.visible_message(span_danger("[user] slits [H]'s throat!"), \
					span_userdanger("[user] slits your throat..."))
		log_combat(user, H, "wounded via throat slitting", source)
		H.apply_damage(source.force, BRUTE, BODY_ZONE_HEAD, wound_bonus=CANT_WOUND) // easy tiger, we'll get to that in a sec
		var/obj/item/bodypart/slit_throat = H.get_bodypart(BODY_ZONE_HEAD)
		if(slit_throat)
			var/datum/wound/slash/critical/screaming_through_a_slit_throat = new
			screaming_through_a_slit_throat.apply_wound(slit_throat)
		H.apply_status_effect(/datum/status_effect/neck_slice)

/datum/component/butchering/proc/Butcher(mob/living/butcher, mob/living/meat)
	var/meat_quality = 50 + (bonus_modifier/10) //increases through quality of butchering tool, and through if it was butchered in the kitchen or not
	if(istype(get_area(butcher), /area/service/kitchen))
		meat_quality = meat_quality + 10
	var/turf/T = meat.drop_location()
	var/final_effectiveness = effectiveness - meat.butcher_difficulty
	var/bonus_chance = max(0, (final_effectiveness - 100) + bonus_modifier) //so 125 total effectiveness = 25% extra chance
	var/list/butchered_items = list()
	for(var/V in meat.butcher_results)
		var/obj/bones = V
		var/amount = meat.butcher_results[bones]
		for(var/_i in 1 to amount)
			if(!prob(final_effectiveness))
				if(butcher)
					to_chat(butcher, "<span class='warning'>You fail to harvest some of the [initial(bones.name)] from [meat].</span>")
			else if(prob(bonus_chance))
				if(butcher)
					to_chat(butcher, "<span class='info'>You harvest some extra [initial(bones.name)] from [meat]!</span>")
				for(var/i in 1 to 2)
					butchered_items += new bones (T)

			else
				butchered_items += new bones (T)
		meat.butcher_results.Remove(bones) //in case you want to, say, have it drop its results on gib
	for(var/V in meat.guaranteed_butcher_results)
		var/obj/sinew = V
		var/amount = meat.guaranteed_butcher_results[sinew]
		for(var/i in 1 to amount)
			butchered_items += new sinew (T)
		meat.guaranteed_butcher_results.Remove(sinew)
	for(var/butchered_item in butchered_items)
		if(isfood(butchered_item))
			var/obj/item/reagent_containers/food/butchered_meat = butchered_item
			butchered_meat.food_quality = meat_quality
	if(butcher)
		meat.visible_message("<span class='notice'>[butcher] butchers [meat].</span>")
	ButcherEffects(meat)
	meat.harvest(butcher)
	meat.gib(FALSE, FALSE, TRUE)

/datum/component/butchering/proc/ButcherEffects(mob/living/meat) //extra effects called on butchering, override this via subtypes
	return

///Special snowflake component only used for the recycler.
/datum/component/butchering/recycler

/datum/component/butchering/recycler/Initialize(_speed, _effectiveness, _bonus_modifier, _butcher_sound, disabled, _can_be_blunt)
	if(!istype(parent, /obj/machinery/recycler)) //EWWW
		return COMPONENT_INCOMPATIBLE
	. = ..()
	if(. == COMPONENT_INCOMPATIBLE)
		return
	RegisterSignal(parent, COMSIG_MOVABLE_CROSSED, PROC_REF(onCrossed))

/datum/component/butchering/recycler/proc/onCrossed(datum/source, mob/living/L)
	if(!istype(L))
		return
	var/obj/machinery/recycler/eater = parent
	if(eater.safety_mode || (eater.machine_stat & (BROKEN|NOPOWER))) //I'm so sorry.
		return
	if(L.stat == DEAD && (L.butcher_results || L.guaranteed_butcher_results))
		Butcher(parent, L)
