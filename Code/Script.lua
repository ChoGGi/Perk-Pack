function OnMsg.ClassesPostprocess()
	local anyAdded = false
	-- Ideas / TODO
	-- Get long-lived working
	--
	--[[
	Adds 12+ new perks, flaws, and quirks (including rare and uncommon traits). Does not require a new game, although new traits will only appear in the applicant pool as new applicants are generated.

	 - Nightowl (reduced penalties working at night)
	 - Kelptomaniac (occasionally steals resources)
	 - Self-Taught (can learn specializations by working, can know multiple specializations)
	 - Teetotaller (does not visit the bar)
	 - Couch Potato (does not exercise)
	 - Fancy (bonus sanity when visiting Luxury, more likely to visit Luxury)
	 - Laid Back (more likely to visit Relaxation)
	 - Child at Heart (will visit Playgrounds)
	 - Ugly (reduced birth rate)
	 - Jack of all Trades (reduced non-specialist penalty, can never specialize)
	 - Handyman (reduces maintenance, chance to fix malfunctions)
	 - Light Sleeper (reduced comfort from rest)
	 - Heavy Sleeper (bonus sanity when resting)
	 - Wanderer (will never take a residence)
	--]]

	ModLog("Perk Pack Init")
	local translateID = 68461000
	PlaceObj('TraitPreset', {
		display_name = "Nightowl",
		id = "Nightowl",
		description = T(translateID+10, "Sanity loss from working during dark hours reduced."),
		group = "Positive",
		weight = 30,
		rare = false,
		auto = true,
		initial_filter = false,
		incompatible = {}
	})
	PlaceObj('TraitPreset', {
		display_name = "Kleptomaniac",
		id = "Kleptomaniac",
		description = T(translateID+11, "Occasionally steals resources. +Shopping"),
		group = "Negative",
		weight = 30,
		rare = false,
		auto = true,
		show_in_traits_ui = true,
		add_interest = "interestShopping",
		initial_filter = false,
		incompatible = {}
	})
	PlaceObj('TraitPreset', {
		display_name = "SelfTaught",
		id = "SelfTaught",
		description = T(translateID+12, "Slowly learns a new specialization by working. Can retain multiple specializations, but it takes a workshift to switch."),
		group = "Positive",
		weight = 30,
		rare = true,
		auto = true,
		show_in_traits_ui = true,
		hidden_on_start = true,
		add_interest = "",
		initial_filter = false,
		incompatible = { "JackAllTrades" }
	})
	PlaceObj('TraitPreset', {
		display_name = "Teetotaller",
		id = "Teetotaller",
		description = T(translateID+13, "Suffers from thirst instead of enjoying it. -Drinking"),
		group = "other",
		weight = 30,
		rare = false,
		auto = true,
		show_in_traits_ui = true,
		remove_interest = "interestDrinking",
		initial_filter = false,
		incompatible = { "Alcoholic" }
	})
	PlaceObj('TraitPreset', {
		display_name = "CouchPotato",
		id = "CouchPotato",
		description = T(translateID+14, "Power saving mode. -Exercise"),
		group = "other",
		weight = 30,
		rare = false,
		auto = true,
		show_in_traits_ui = true,
		remove_interest = "interestExercise",
		initial_filter = false,
		incompatible = { "Fit" }
	})
	PlaceObj('TraitPreset', {
		display_name = "Fancy",
		id = "Fancy",
		description = T(translateID+15, "Gains bonus sanity when buying expensive things. +Luxury"),
		group = "Positive",
		weight = 30,
		rare = false,
		auto = true,
		show_in_traits_ui = true,
		add_interest = "interestLuxury",
		initial_filter = false,
		param = 5,
	})
	local Fancy = TraitPresets.Fancy
	ColonistStatReasons[Fancy.id] = T{
	  translateID+1,
	  string.format("<green>Shiny things are the best. <amount> (%s)</green>",Fancy.display_name)
	}
	PlaceObj('TraitPreset', {
		display_name = "LaidBack",
		id = "LaidBack",
		description = T(translateID+16, "Relax man, don't have a cow. +Relaxation"),
		group = "Positive",
		weight = 30,
		rare = false,
		auto = true,
		show_in_traits_ui = true,
		add_interest = "interestRelaxation",
		initial_filter = false,
		param = 5,
	})
	local LaidBack = TraitPresets.LaidBack
	ColonistStatReasons[LaidBack.id] = T{
	  translateID+2,
	  string.format("<green>Relaxing... <amount> (%s)</green>",LaidBack.display_name)
	}
	PlaceObj('TraitPreset', {
		display_name = "ChildAtHeart",
		id = "ChildAtHeart",
		description = T(translateID+17, "Will visit playgrounds. +Play"),
		group = "other",
		weight = 30,
		rare = true,
		auto = true,
		show_in_traits_ui = true,
		hidden_on_start = true,
		add_interest = "interestPlaying",
		initial_filter = false,
	})
	PlaceObj('TraitPreset', {
		display_name = "Ugly",
		id = "Ugly",
		description = T(translateID+18, "Greatly reduced birth rate."),
		group = "other",
		weight = 30,
		rare = false,
		auto = true,
		show_in_traits_ui = true,
		add_interest = "",
		initial_filter = false,
		modify_amount = -1 * TraitPresets.Sexy.modify_amount,
		modify_property = TraitPresets.Sexy.modify_property,
	})
	PlaceObj('TraitPreset', {
		display_name = "Jack of all Trades",
		id = "JackAllTrades",
		description = T(translateID+19, "Master of none."),
		group = "Positive",
		weight = 30,
		rare = false,
		auto = true,
		show_in_traits_ui = true,
		add_interest = "",
		initial_filter = false,
		incompatible = { "Botanist,Medic,Geologist,Officer,Engineer,Scientist,SelfTaught" }
	})
	PlaceObj('TraitPreset', {
		display_name = "Handyman",
		id = "Handyman",
		description = T(translateID+20, "Proactively performs maintenance while working. Has a chance to fix malfunctioned buildings."),
		group = "Positive",
		weight = 30,
		rare = false,
		auto = true,
		show_in_traits_ui = true,
		add_interest = "",
		initial_filter = false,
		incompatible = { "Idiot" },
		param = 25
	})
	PlaceObj('TraitPreset', {
		display_name = "Light Sleeper",
		id = "LightSleeper",
		description = T(translateID+21, "Reduced comfort gained when resting."),
		group = "Negative",
		weight = 10,
		rare = false,
		auto = true,
		show_in_traits_ui = true,
		add_interest = "",
		initial_filter = false,
		incompatible = { "HeavySleeper" }
	})
	local LightSleeper = TraitPresets.LightSleeper
	ColonistStatReasons[LightSleeper.id] = T{
	  translateID+3,
	  string.format("<green>Did not sleep well <amount> (%s)</green>",LightSleeper.display_name)
	}
	PlaceObj('TraitPreset', {
		display_name = "Heavy Sleeper",
		id = "HeavySleeper",
		description = T(translateID+21, "Increased sanity gained when resting."),
		group = "Positive",
		weight = 10,
		rare = false,
		auto = true,
		show_in_traits_ui = true,
		add_interest = "",
		initial_filter = false,
		incompatible = { "LightSleeper" }
	})
	local HeavySleeper = TraitPresets.HeavySleeper
	ColonistStatReasons[HeavySleeper.id] = T{
	  translateID+4,
	  string.format("<green>Slept very well <amount> (%s)</green>",HeavySleeper.display_name)
	}
	PlaceObj('TraitPreset', {
		display_name = "Wanderer",
		id = "Wanderer",
		description = T(translateID+22, "Does not require a residence and gains higher base health and sanity when resting, but may never gain any bonuses from having a residence."),
		group = "Positive",
		weight = 10,
		rare = false,
		auto = true,
		show_in_traits_ui = true,
		add_interest = "",
		initial_filter = false,
	})
	-- This one doesn't work correctly
	--if not TraitPresets.LongLived then
	--	local LongLived = ModItemTraitPreset:new()
	--	LongLived.name = "LongLived"
	--	LongLived.display_name = "Long Lived"
	--	LongLived.description = "Lives a lot longer than usual."
	--	LongLived.category = "Positive"
	--	LongLived.weight = 30
	--	LongLived.rare = true
	--	LongLived.auto = true
	--	LongLived.show_in_traits_ui = true
	--	LongLived.initial_filter = false
	--	LongLived.incompatible = "ChronicCondition"
	--	LongLived.daily_update_func = function(colonist, trait_id)
	--		ModLog("Long lived update")
	--		if colonist:Random(2) == 1 then
	--			colonist.age = colonist.age - 1
	--			colonist.sols = colonist.sols - 1
	--		end
	--	end
	--	TraitPresets.LongLived = LongLived
	--	anyAdded = true
	--end
	ModLog("Perk Pack completed")
end

local original_CheckCrimeEvents = Dome.CheckCrimeEvents
local original_ChangeWorkplacePerformance = Colonist.ChangeWorkplacePerformance
local original_CanTrain = MartianUniversity.CanTrain
local original_WorkCycle = Colonist.WorkCycle
local original_Rest = Colonist.Rest
local original_CanReserveResidence = Residence.CanReserveResidence
local original_IsHomeless = Colonist.IsHomeless
local original_Service = Residence.Service
local original_VisitService = Colonist.VisitService
local original_UpdateResidence = Colonist.UpdateResidence

function Colonist:IsHomeless()
	return original_IsHomeless(self) and not self.traits.Wanderer
end

function Colonist:UpdateResidence()
	if self.traits.Wanderer then
		self:SetResidence(false)
		self.city:RemoveFromLabel("Homeless", self)
		if self.dome then
			self.dome:RemoveFromLabel("Homeless", self)
		end
		self:Affect("StatusEffect_Homeless", false)
		return
	end
	original_UpdateResidence(self)
end

function Colonist:Rest()
	if (not self.traits.Wanderer) or self.traits.Rugged then
		original_Rest(self)
	else
		self:UpdateResidence()
		self.traits.Rugged = true
		original_Rest(self)
		local dome = self.dome
		local is_rapid_sleep = self.city:IsTechResearched("RapidSleep")
		local rest_duration = is_rapid_sleep and const.HourDuration or (7 * const.HourDuration)
		self:ChangeHealth(2 * self.DailyHealthRecover, "rest")
		local sanity_recover = self.DailySanityRecover
		self:ChangeSanity(is_rapid_sleep and 3 * sanity_recover or 2 * sanity_recover, "rest")
		if dome and dome.working then
			local commander_profile = GetCommanderProfile()
			local psyho = commander_profile.name == "psychologist" and commander_profile.param1 * stat_scale or 0
			self:ChangeSanity(psyho, "psychologist")
			self:ChangeSanity(dome.DailySanityRecoverDome, "dome")
		end

		self.traits.Rugged = nil
	end
end

function Residence:CanReserveResidence(unit)
	if unit.traits.Wanderer then
		unit:SetResidence(false)
--~ 		self.SetResidence(self,false)
		self.city:RemoveFromLabel("Homeless", unit)
--~ 		self.city:RemoveFromLabel("Homeless", self)
--~ 		if self.dome then
--~ 			self.dome:RemoveFromLabel("Homeless", self)
--~ 		end
		if unit.dome then
			unit.dome:RemoveFromLabel("Homeless", unit)
		end
--~ 		self:Affect("StatusEffect_Homeless", false)
		unit:Affect("StatusEffect_Homeless", false)
		return false
	end
	return original_CanReserveResidence(self, unit)
end

function Workplace:OnChangeWorkshift(old, new)
	if old then
		local martianborn_resilience = self.city:IsTechResearched("MartianbornResilience")
		local dark_penalty = IsDarkHour(self.city.hour - 4) and -g_Consts.WorkDarkHoursSanityDecrease
		local overtime = self.overtime[old]
		local outside_sanity_decrease = -g_Consts.OutsideWorkplaceSanityDecrease
		local is_outside_building = not self.parent_dome
		local workers = self.workers[old] or ""
--~ 		for _, worker in ipairs(self.workers[old]) do
		for i = 1, #workers do
			local worker = workers[i]
			local traits = worker.traits
			if dark_penalty then
				if traits.Nightowl then
					dark_penalty = dark_penalty / 4
				end
				worker:ChangeSanity(dark_penalty, "work in dark hours")
			end
			if overtime and worker:IsWorking() and not traits.Workaholic then
				worker:ChangeHealth(-g_Consts.WorkOvertimeHealth, "overtime")
				worker:ChangeSanity(-g_Consts.WorkOvertimeSanityDecrease, "overtime")
			end
			if is_outside_building and not (martianborn_resilience and traits.Martianborn) then
				worker:ChangeSanity(outside_sanity_decrease, "outside workplace")
			end
			--ModLog("Self Taught check: " .. tostring(traits.SelfTaught) .. ", building " .. self.specialist)
			if traits.SelfTaught and self.specialist ~= worker.specialist and self.specialist ~= "none" then
				local martianborn_adaptability = self.city:IsTechResearched("MartianbornAdaptability") and TechDef.MartianbornAdaptability.param1
				local gain_point = 20
				if martianborn_adaptability and traits.Martianborn then
					gain_point = gain_point + MulDivRound(martianborn_adaptability, gain_point, 100)
				end
				--ModLog("	gain_point " .. tostring(gain_point))
				gain_point = gain_point + MulDivRound(worker.performance, gain_point, 100)
				--ModLog("	gain_point " .. tostring(gain_point))
				worker.training_points = worker.training_points or {}
				worker.training_points["SelfTaught_" .. self.specialist] = (worker.training_points["SelfTaught_" .. self.specialist] or 0) + MulDivRound(gain_point, 3, g_Consts.WorkingHours)
				--ModLog("Senior age: " .. tostring(worker.MinAge_Senior))
				ModLog("	Self training progress: " .. tostring(worker.training_points["SelfTaught_" .. self.specialist]))
				if (worker.training_points and worker.training_points["SelfTaught_" .. self.specialist] or 0) >= 100 then
					worker.training_points["SelfTaught_" .. self.specialist] = 100
					worker:SetSpecialization(self.specialist)
				end
			end
			worker:InterruptVisit()
		end
	end
	RebuildInfopanel(self)
end

function Residence:Service(unit, duration)
	original_Service(self, unit, duration)
	if unit.traits.LightSleeper and unit.dome then
		unit:ChangeComfort((unit.residence.comfort_increase / -4), TraitPresets.LightSleeper.name)
	end
	if unit.traits.HeavySleeper and unit.dome then
		unit:ChangeSanity(5 * const.Scale.Stat, TraitPresets.HeavySleeper.name)
	end
end

local resources_query = {
	class = "ResourceStockpileBase",
	area = false,
	filter = function(o, dome)
		if IsKindOfClasses(o, "SharedStorageBaseVisualOnly", "CargoShuttle") then
			return false
		end
		if "BlackCube" == o.resource or "WasteRock" == o.resource then
			return false
		end
		local stored_amount = 0
		if IsKindOf(o, "ResourcePile") then
			return o.transport_request:GetTargetAmount() >= const.ResourceScale
		else
			return o:GetStoredAmount() >= const.ResourceScale
		end
	end
}

function Dome:CrimeEvents_KleptoTheft()
	resources_query.area = self
	resources_query.arearadius = self:GetOutsideWorkplacesDist() * const.HexHeight
	local resources_stockpile = GetObjects(resources_query, self)
	resources_query.area = false
	local count = #resources_stockpile
	if count <= 0 then
		return false
	end
	local rand_stockpile = 1 + self:Random(count)
	local stockpile = resources_stockpile[rand_stockpile]
	if IsKindOf(stockpile, "ResourcePile") then
		local stored_amount = stockpile.transport_request:GetTargetAmount()
		local rand_res_amount = (1 + self:Random(Min(stored_amount / const.ResourceScale, 5))) * const.ResourceScale
		stockpile:AddResource(-rand_res_amount, stockpile.resource)
		AddCustomOnScreenNotification("KleptomaniacStoleResources","Kleptomaniac Stole Resources",FormatResource(rand_res_amount, stockpile.resource, self) .. " stolen from " .. self:GetDisplayName())
		return true
	elseif IsKindOf(stockpile, "ResourceStockpile") then
		local storable_resource = stockpile.resource
		local stored_amount = stockpile:GetStoredAmount()
		local rand_res_amount = (1 + self:Random(Min(stored_amount / const.ResourceScale, 5))) * const.ResourceScale
		stockpile:AddResource(-rand_res_amount, storable_resource)
		AddCustomOnScreenNotification("KleptomaniacStoleResources","Kleptomaniac Stole Resources",FormatResource(rand_res_amount, storable_resource, self) .. " stolen from " .. self:GetDisplayName())
		return true
	else
		local storable_resources = stockpile.storable_resources
		local resource_count = #storable_resources
		local stored_amount = {}
		for i = 1, resource_count do
			local resource = storable_resources[i]
			local amount = stockpile:GetStoredAmount(resource)
			if amount >= const.ResourceScale then
				stored_amount[#stored_amount + 1] = {resource, amount}
			end
		end
		local rand_type = 1 + self:Random(#stored_amount)
		local resorce_type = stored_amount[rand_type]
		local rand_res_amount = (1 + self:Random(Min(resorce_type[2] / const.ResourceScale, 5))) * const.ResourceScale
		stockpile:AddResource(-rand_res_amount, resorce_type[1])
		AddCustomOnScreenNotification("KleptomaniacStoleResources","Kleptomaniac Stole Resources",FormatResource(rand_res_amount, resorce_type[1], self) .. " stolen from " .. self:GetDisplayName())
		return true
	end
end

function Dome:GetAdjustedKlepto()
	local stations = self.labels.SecurityStation or ""
	local sum = 0
	for i = 1, #stations do
		sum = sum + stations[i]:GetNegatedRenegades()
	end
	-- local count_renegades = #(self.labels.Kleptomaniac or "")
	local count_renegades = 0
	local colonists = self.labels.Colonist or ""
	for i = 1,#colonists do
--~ 	for i, colonist in ipairs(self.labels.Colonist) do
		local traits = colonists[i].traits
		if traits.Kleptomaniac then
			count_renegades = count_renegades + 1
		end
	end

	return Max(0, count_renegades - sum)
end

function Dome:CanPreventKleptoEvents()
	local officers = #(self.labels.security or "")
	local renegades = #(self.labels.Kleptomaniac or "")
	if officers <= renegades then
		return false
	end
	if officers > renegades * 3 then
		return false
	end
	local chance = MulDivRound(officers, 100, 6 * renegades)
	return chance >= Random(0, 100)
end

function Dome:CheckCrimeEvents()
	original_CheckCrimeEvents(self)
	local count = self:GetAdjustedKlepto()
	if count <= 2 then
		return
	end
	if self:CanPreventKleptoEvents() then
		AddCustomOnScreenNotification("KleptomaniaPrevented","Thieves Caught","Officers in " .. self:GetDisplayName() .. " prevented theft.")
		return
	end
	self:CrimeEvents_KleptoTheft()
end

function Colonist:VisitService(service)
	original_VisitService(self,service)
	if self:EnterBuilding(service) and IsValid(service) then
		local interest = self.daily_interest
		if self.traits.Fancy and service:IsOneOfInterests("interestLuxury") then
			local trait_fancy = TraitPresets.Fancy
			self:ChangeSanity(trait_fancy.param * const.Scale.Stat, trait_fancy.name)
		end
		if self.traits.LaidBack and service:IsOneOfInterests("interestRelaxation") then
			local trait_laidback = TraitPresets.LaidBack
			self:ChangeSanity(trait_laidback.param * const.Scale.Stat, trait_laidback.name)
		end
	end
end

function Colonist:ChangeWorkplacePerformance()
	local workplace = self.workplace
	if not workplace then
		return
	end
	original_ChangeWorkplacePerformance(self)
	if workplace.specialist ~= "none" and self.traits.JackAllTrades then
		local amount = g_Consts.NonSpecialistPerformancePenalty / 2
		local text = T{
			"<red>Wrong workplace specialization " .. -g_Consts.NonSpecialistPerformancePenalty .. "</color><newline><green>Jack of all Trades +" .. amount .. "</color>"
		}
		self:SetModifier("performance", "specialist_match", -g_Consts.NonSpecialistPerformancePenalty+amount, 0, text)
	end
end

function MartianUniversity:CanTrain(unit)
	return original_CanTrain(self, unit) and not unit.traits.JackAllTrades
end

local function Power(a, b)
	if b <= 0 then
		return 1;
	end
	local c = 1
	for x=1,b,1 do
		c = c * a
	end
	return c
end

function Colonist:WorkCycle()
	local workplace = self.workplace
	if not IsValid(workplace) then
		return
	end
	if IsValid(workplace) and workplace:IsKindOf("Workplace") then
		if self.traits.Handyman then
			local numHandy = 0;
			local curTime = self.city.day * const.HoursPerDay + self.city.hour
			for i = #workplace.workers[workplace.current_shift], 1, -1 do
				if workplace.workers[workplace.current_shift][i].traits.Handyman then
					numHandy = numHandy + 1
				end
			end
			numHandy = numHandy - 1
			local chance = (100 - floatfloor(Power(0.90,numHandy)*100)) + TraitPresets.Handyman.param
			if curTime > (workplace.lastRepair or 0) and workplace:IsMalfunctioned() and self:Random(100) < chance then
				workplace:Repair()
			end
			workplace.lastRepair = curTime
			if not workplace:IsMalfunctioned() then
				workplace:AccumulateMaintenancePoints(-1250)
			end
		end
	end
	original_WorkCycle(self)
end

-- not sure why you'd replace this?
--~ GlobalVar("g_ApplicantPool", {})

function OnMsg.NewHour()
	local pool = g_ApplicantPool or ""
	for i = #pool, 1, -1 do
		if pool[i][1].traits.JackAllTrades and pool[i][1].specialist ~= "none" then
			pool[i][1].traits.JackAllTrades = nil
		end
	end
end
function OnMsg.CityStart()
	local pool = g_ApplicantPool or ""
	for i = #pool, 1, -1 do
		if pool[i][1].traits.JackAllTrades and pool[i][1].specialist ~= "none" then
			pool[i][1].traits.JackAllTrades = nil
		end
	end
end

-- Mod metadata (these must match the values in metadata.lua) --
----------------------------------------------------------------
-- <id> should be the mod's generated id
-- For an in-development mod and for the first upload use `nil` (no quotes) as the <steam_id>
-- Once the mod has a steam_id in metadata.lua use that (as a string).
-- <author> name will always be checked.
local id = "Perk Pack"
local steam_id = "1342074775"
local author = "Draco18s"

--------------------------------------------------
-- Validation logic, don't edit below this line --
--------------------------------------------------

-- Debug
local logf = rawget(_G,"logf") or empty_func
local try = rawget(_G,"try") or empty_func

try(function()
    -- Find this mod in the ModsLoaded list
--~     local found, mod = 0, nil
--~     for i, v in ipairs(ModsLoaded) do
--~         if v.id == id then
--~             found, mod = i, v
--~             break
--~         end
--~     end
    local found,mod = table.find(ModsLoaded,"id","XGvmd8k")
		if found then
			mod = ModsLoaded[found]
		end

    if not mod then
        logf("Mod not found (%s by %s)", id, author)
        return
    end

    -- Check author and steam_id
    if mod.author == author and (not steam_id or mod.steam_id == steam_id) then
        logf("Mod validated (%s by %s @ %s)", id, author, tostring(steam_id))
        return
    end

    logf("Mod copy detected! (%s by %s @ %s)", mod.id, mod.author, tostring(mod.steam_id))

    -- Metadata doesn't match, so disable the mod and reload
    table.remove(ModsLoaded, found)

		-- AccountStorage access was blocked in DA update
--~     -- Also check the list in AccountStorage since that probably needs to be updated as well
--~     if AccountStorage.LoadMods[found] == mod.id then
--~         table.remove(AccountStorage.LoadMods, found)
--~         SaveAccountStorage()
--~     end

    ReloadLua()
end)
