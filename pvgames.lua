-- Requires:
-- io
-- collection
-- spritesheet
-- image

local pvgames = {}

PortraitFile = "Portraits.png"
SpritesheetFile = "Spritesheet.png"

pvgames.portrait_spritesheet = spritesheet.sheet(16, 2000, 2000, 4)

---@param offset integer
---@param length integer
---@param multiline? boolean
---@return spritesheet_Spritesheet, spritesheet_Spritesheet
function pvgames.animation_spritesheet(offset, length, multiline)
	local per = length
	if multiline then
		per = length / 8
	end

	return spritesheet.sheet(length, 200, 200, 50, spritesheet.offset_index(offset)),
		spritesheet.sheet(length, 200, 200, per)
end

---@param dir string
---@param name string
---@return table<string, integer>
function pvgames.extract_portraits(dir, name)
	local portraitSheet = io.decode(io.path_join(dir, PortraitFile))
	local frames = spritesheet.to_frames(portraitSheet, name, pvgames.portrait_spritesheet, true)

	local portraits = {}
	for k, v in pairs(pvgames.portrait_index) do
		image.name(frames[v + 1], k)
		portraits[k] = frames[v + 1]
	end

	image.remove(portraitSheet)
	return portraits
end

---@param dir string
---@param portrait string
---@param name string
---@return integer
function pvgames.extract_portrait(dir, portrait, name)
	local portraitSheet = io.decode(io.path_join(dir, PortraitFile))
	local frame = spritesheet.to_frames(
		portraitSheet,
		name,
		spritesheet.sheet(1, 2000, 2000, 4, spritesheet.offset_index(pvgames.portrait_index[portrait])),
		true
	)

	image.remove(portraitSheet)
	return frame[1]
end

---@param dir string
---@param name string
---@return table<string, integer>
function pvgames.extract_animations(dir, name)
	local animSheet = io.decode(io.path_join(dir, SpritesheetFile))

	local animations = {}

	for k, v in pairs(pvgames.animation_data) do
		local sheet1, sheet2 = pvgames.animation_spritesheet(v.offset, v.length, true)
		local anim = spritesheet.extract(animSheet, name .. "_" .. k, sheet1, sheet2, true)

		animations[k] = anim
	end

	image.remove(animSheet)
	return animations
end

---@param dir string
---@param animation string
---@param name string
---@return integer
function pvgames.extract_animation(dir, animation, name)
	local animSheet = io.decode(io.path_join(dir, SpritesheetFile))

	local v = pvgames.animation_data[animation]

	local sheet1, sheet2 = pvgames.animation_spritesheet(v.offset, v.length, true)
	local anim = spritesheet.extract(animSheet, name, sheet1, sheet2, true)

	image.remove(animSheet)
	return anim
end

---@param dir string
---@param name string
---@return {portraits: table<string, integer>, animations: table<string, integer>}
function pvgames.extract(dir, name)
	local sprites = {
		portraits = pvgames.extract_portraits(dir, name),
		animations = pvgames.extract_animations(dir, name),
	}

	return sprites
end

pvgames.portrait_index = {
	neutral1 = 0,
	neutral2 = 1,
	happy1 = 2,
	happy2 = 3,
	sad1 = 4,
	sad2 = 5,
	angry1 = 6,
	angry2 = 7,
	nervous1 = 8,
	nervous2 = 9,
	scared = 10,
	injured = 11,
	thoughtful1 = 12,
	thoughtful2 = 13,
	annoyed1 = 14,
	annoyed2 = 15,
}

pvgames.portrait = {
	neutral1 = "neutral1",
	neutral2 = "neutral2",
	happy1 = "happy1",
	happy2 = "happy2",
	sad1 = "sad1",
	sad2 = "sad2",
	angry1 = "angry1",
	angry2 = "angry2",
	nervous1 = "nervous1",
	nervous2 = "nervous2",
	scared = "scared",
	injured = "injured",
	thoughtful1 = "thoughtful1",
	thoughtful2 = "thoughtful2",
	annoyed1 = "annoyed1",
	annoyed2 = "annoyed2",
}

---@class animation
---@field offset integer
---@field length integer

---@param offset integer
---@param length integer
---@return animation
local function create_animation(offset, length)
	return {
		offset = offset,
		length = length,
	}
end

pvgames.animation = {
	walk = "walk",
	run = "run",
	idle1 = "idle1",
	idle2 = "idle2",
	idle3 = "idle3",
	idle4 = "idle4",
	idle_fidget1 = "idle_fidget1",
	idle_fidget2 = "idle_fidget2",
	idle_fidget3 = "idle_fidget3",
	talking1 = "talking1",
	talking2 = "talking2",
	interact = "interact",
	use_item = "use_item",
	sitting = "sitting",
	climb = "climb",
	praying = "praying",
	jump = "jump",
	sneaking = "sneaking",
	crouch = "crouch",
	casting = "casting",
	die_forward = "die_forward",
	die_backward = "die_backward",
	dead1 = "dead1",
	dead2 = "dead2",
	dead3 = "dead3",
	dead4 = "dead4",
	evade_roll = "evade_roll",
	hit1 = "hit1",
	hit2 = "hit2",
	critical_idle1 = "critical_idle1",
	critical_idle2 = "critical_idle2",
	block = "block",
	drink = "drink",
	riding1 = "riding1",
	riding2 = "riding2",
	riding3 = "riding3",
	walk_1h = "walk_1h",
	idle_1h = "idle_1h",
	attack1_1h = "attack1_1h",
	attack2_1h = "attack2_1h",
	attack3_1h = "attack3_1h",
	fidget_1h = "fidget_1h",
	walk_2h = "walk_2h",
	idle_2h = "idle_2h",
	run_2h = "run_2h",
	attack1_2h = "attack1_2h",
	attack2_2h = "attack2_2h",
	dual_wield_walk = "dual_wield_walk",
	dual_wield_idle = "dual_wield_idle",
	dual_wield_attack1 = "dual_wield_attack1",
	dual_wield_attack2 = "dual_wield_attack2",
	dual_wield_fidget = "dual_wield_fidget",
	bow_walk = "bow_walk",
	bow_idle = "bow_idle",
	bow_attack1 = "bow_attack1",
	bow_fidget = "bow_fidget",
	unarmed_idle = "unarmed_idle",
	unarmed_attack1 = "unarmed_attack1",
	unarmed_attack2 = "unarmed_attack2",
	unarmed_fidget = "unarmed_fidget",
	polearm_walk = "polearm_walk",
	polearm_run = "polearm_run",
	polearm_idle = "polearm_idle",
	polearm_attack1 = "polearm_attack1",
	polearm_attack2 = "polearm_attack2",
	pistol_walk = "pistol_walk",
	pistol_idle = "pistol_idle",
	pistol_attack1 = "pistol_attack1",
	pistol_attack2 = "pistol_attack2",
	pistol_fidget = "pistol_fidget",
	rifle_walk = "rifle_walk",
	rifle_idle = "rifle_idle",
	rifle_attack1 = "rifle_attack1",
	rifle_fidget = "rifle_fidget",
}

pvgames.animation_data = {
	walk = create_animation(0, 64),
	run = create_animation(64, 64),
	idle1 = create_animation(128, 40),
	idle2 = create_animation(168, 40),
	idle3 = create_animation(208, 40),
	idle4 = create_animation(248, 40),
	idle_fidget1 = create_animation(288, 24),
	idle_fidget2 = create_animation(312, 24),
	idle_fidget3 = create_animation(336, 24),
	talking1 = create_animation(360, 40),
	talking2 = create_animation(400, 40),
	interact = create_animation(440, 40),
	use_item = create_animation(480, 24),
	sitting = create_animation(504, 24),
	climb = create_animation(528, 40),
	praying = create_animation(568, 24),
	jump = create_animation(592, 40),
	sneaking = create_animation(632, 64),
	crouch = create_animation(698, 24),
	casting = create_animation(720, 24),
	die_forward = create_animation(744, 40),
	die_backward = create_animation(784, 40),
	dead1 = create_animation(824, 8),
	dead2 = create_animation(832, 8),
	dead3 = create_animation(840, 8),
	dead4 = create_animation(848, 8),
	evade_roll = create_animation(856, 40),
	hit1 = create_animation(898, 24),
	hit2 = create_animation(920, 24),
	critical_idle1 = create_animation(944, 24),
	critical_idle2 = create_animation(968, 24),
	block = create_animation(892, 24),
	drink = create_animation(1016, 24),
	riding1 = create_animation(1040, 8),
	riding2 = create_animation(1048, 8),
	riding3 = create_animation(1056, 8),
	walk_1h = create_animation(1064, 64),
	idle_1h = create_animation(1128, 40),
	attack1_1h = create_animation(1168, 24),
	attack2_1h = create_animation(1192, 24),
	attack3_1h = create_animation(1216, 24),
	fidget_1h = create_animation(1240, 24),
	walk_2h = create_animation(1264, 64),
	idle_2h = create_animation(1328, 40),
	run_2h = create_animation(1368, 64),
	attack1_2h = create_animation(1432, 24),
	attack2_2h = create_animation(1458, 24),
	dual_wield_walk = create_animation(1480, 64),
	dual_wield_idle = create_animation(1544, 40),
	dual_wield_attack1 = create_animation(1584, 24),
	dual_wield_attack2 = create_animation(1608, 24),
	dual_wield_fidget = create_animation(1632, 24),
	bow_walk = create_animation(1658, 64),
	bow_idle = create_animation(1720, 40),
	bow_attack1 = create_animation(1760, 40),
	bow_fidget = create_animation(1800, 24),
	unarmed_idle = create_animation(1824, 40),
	unarmed_attack1 = create_animation(1864, 40),
	unarmed_attack2 = create_animation(1904, 24),
	unarmed_fidget = create_animation(1928, 24),
	polearm_walk = create_animation(1952, 64),
	polearm_run = create_animation(2016, 64),
	polearm_idle = create_animation(2080, 40),
	polearm_attack1 = create_animation(2120, 24),
	polearm_attack2 = create_animation(2144, 24),
	pistol_walk = create_animation(2168, 64),
	pistol_idle = create_animation(2232, 40),
	pistol_attack1 = create_animation(2272, 24),
	pistol_attack2 = create_animation(2296, 24),
	pistol_fidget = create_animation(2320, 24),
	rifle_walk = create_animation(2344, 64),
	rifle_idle = create_animation(2408, 40),
	rifle_attack1 = create_animation(2448, 24),
	rifle_fidget = create_animation(2472, 24),
}

return pvgames
