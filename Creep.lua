--- 12/26/2015 work in progress. just trying to get the basics working at the moment.
---	12/29/2015 First rough build now working! 
--- 01/07/2016 v1.01 Fixed CCT index nil error viewable in the console when program was running. occurred whenever no target was currently selected.

Creep = { }
Creep.lastticks = 0
Creep.running = false
Creep.initialized = false

function Creep.ModuleInit()
	GUI_NewWindow("Creep",300,300,250,160)
	GUI_WindowVisible("Creep",true)	
	GUI_NewField("Creep","Target Name","TName","MainMenu")
	GUI_NewField("Creep","Target Health","CCTHP","MainMenu")
	GUI_NewField("Creep","Target       XYZ: ","TPos","MainMenu")
	GUI_NewField("Creep","    "," ","MainMenu")
	GUI_NewField("Creep","My Position XYZ: ","myposition","MainMenu")
	GUI_NewField("Creep","Distance","TDist","MainMenu")

	GUI_NewButton("Creep","Perform Creep","Creep.Teleport")
	RegisterEventHandler("Creep.Teleport", Creep.func)
end

function Creep.func ( arg ) -- perform the Teleport
	if ( arg == "Creep.Teleport" ) then local CCT = Player:GetTarget()
	
				if facing == "N" then d(Player:Teleport(CCT.pos.x, CCT.pos.y-90, CCT.pos.z))
				Player:SetFacingExact(CCT.pos.x,CCT.pos.y,CCT.pos.z,true) 
				elseif facing == "S" then d(Player:Teleport(CCT.pos.x, CCT.pos.y+90, CCT.pos.z))
				Player:SetFacingExact(CCT.pos.x,CCT.pos.y,CCT.pos.z,true) 
				elseif facing == "E" then d(Player:Teleport(CCT.pos.x-90, CCT.pos.y, CCT.pos.z)) 
				Player:SetFacingExact(CCT.pos.x,CCT.pos.y,CCT.pos.z,true) 
				elseif facing == "W" then d(Player:Teleport(CCT.pos.x+90, CCT.pos.y, CCT.pos.z))
				Player:SetFacingExact(CCT.pos.x,CCT.pos.y,CCT.pos.z,true) 
				elseif facing == "NE" then d(Player:Teleport(CCT.pos.x-90, CCT.pos.y-90, CCT.pos.z))
				Player:SetFacingExact(CCT.pos.x,CCT.pos.y,CCT.pos.z,true) 
				elseif facing == "NW" then d(Player:Teleport(CCT.pos.x+90, CCT.pos.y-90, CCT.pos.z)) 
				Player:SetFacingExact(CCT.pos.x,CCT.pos.y,CCT.pos.z,true) 
				elseif facing == "SE" then d(Player:Teleport(CCT.pos.x-90, CCT.pos.y+90, CCT.pos.z)) 
				Player:SetFacingExact(CCT.pos.x,CCT.pos.y,CCT.pos.z,true) 
				elseif facing == "SW" then d(Player:Teleport(CCT.pos.x+90, CCT.pos.y+90, CCT.pos.z)) 
				Player:SetFacingExact(CCT.pos.x,CCT.pos.y,CCT.pos.z,true) 
				end
	end
end

function Creep.UpdateWindow() -- show some stats on the target, define some variables, constantly updating with info
			local CCT = Player:GetTarget()
			if CCT ~= nil then	
		
			TName = tostring(CCT.name)
			CCTHP = tostring(CCT.health.current.." of "..CCT.health.max.." / "..CCT.health.percent.."%")
			TDist = tostring(math.floor(CCT.distance))
			------------------------------------------------
			TPos = math.floor(CCT.pos.x).." / "..math.floor(CCT.pos.y).." / "..math.floor(CCT.pos.z)
			THead = (math.floor(CCT.pos.hx * 10) / 10).." / "..(math.floor(CCT.pos.hy * 10) / 10).." / "..(math.floor(CCT.pos.hz * 10) / 10)
			------------------------------------------------
			radians = math.atan2(CCT.pos.hx,CCT.pos.hy)
			degrees = math.deg(radians)
			if degrees < 0 then	degrees = 360 + degrees	end				
			------------------------------------------------
			rradians = (math.floor(radians * 100 ) / 100 ) -- Rounded
			rdegrees = (math.floor(degrees * 100 ) / 100 ) -- Rounded
			------------------------------------------------
			Myself = math.floor(Player.pos.x).." / "..math.floor(Player.pos.y).." / "..math.floor(Player.pos.z)
			myradians = math.atan2(Player.pos.hx,Player.pos.hy)
			mydegrees = math.deg(myradians)
			if mydegrees < 0 then mydegrees = (360 + mydegrees)	end				
			------------------------------------------------
			myrradians = (math.floor(myradians * 100 ) / 100 ) -- Rounded
			myrdegrees = (math.floor(mydegrees * 100 ) / 100 ) -- Rounded
			myposition = math.floor(Player.pos.x).." / "..math.floor(Player.pos.y).." / "..math.floor(Player.pos.z)
			------------------------------------------------
			facing = Creep.facingdirection()
			myfacing = Creep.myfacingdirection()
	end
end

function Creep.facingdirection()
		if degrees >= -1 and degrees <= 22.5 then return ("N") end
		if degrees >= 337.5 and degrees <= 361 then return ("N") end
		if degrees >= 22.5 and degrees <= 67.5 then return ("NE") end
		if degrees >= 67.5 and degrees <= 112.5 then return ("E") end
		if degrees >= 112.5 and degrees <= 157.5 then return ("SE") end
		if degrees >= 157.5 and degrees <= 202.5 then return ("S") end
		if degrees >= 202.5 and degrees <= 247.5 then return ("SW") end
		if degrees >= 247.5 and degrees <= 292.5 then return ("W") end
		if degrees >= 292.5 and degrees <= 337.5 then return ("NW") end
end

function Creep.myfacingdirection()
		if mydegrees >= -1 and mydegrees <= 22.5 then return ("N") end
		if mydegrees >= 337.5 and mydegrees <= 361 then return ("N") end		
		if mydegrees >= 22.5 and mydegrees <= 67.5 then return ("NE") end
		if mydegrees >= 67.5 and mydegrees <= 112.5 then return ("E") end
		if mydegrees >= 112.5 and mydegrees <= 157.5 then return ("SE") end
		if mydegrees >= 157.5 and mydegrees <= 202.5 then return ("S") end
		if mydegrees >= 202.5 and mydegrees <= 247.5 then return ("SW") end
		if mydegrees >= 247.5 and mydegrees <= 292.5 then return ("W") end
		if mydegrees >= 292.5 and mydegrees <= 337.5 then return ("NW") end	
end

function Creep.OnUpdateHandler( Event, ticks ) 			
	Creep.UpdateWindow()
end

RegisterEventHandler("Module.Initalize",Creep.ModuleInit)
RegisterEventHandler("Gameloop.Update", Creep.OnUpdateHandler)
RegisterEventHandler("GUI.Update",Creep.GUIVarUpdate)