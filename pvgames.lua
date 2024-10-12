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
---@return any, any
function pvgames.animation_spritesheet(offset, length, multiline)
	local per = length
	if multiline then
		per = length / 8
	end

	return spritesheet.sheet(length, 200, 200, 50, spritesheet.offset_index(offset)),
		spritesheet.sheet(length, 200, 200, per)
end

---@param dir string
---@return table<string, integer>
function pvgames.extract_portraits(dir)
	local portraitSheet = io.decode(io.path_join(dir, PortraitFile))
	local frames = spritesheet.to_frames(portraitSheet, "portrait_", pvgames.portrait_spritesheet, true)

	local portraits = {}
	for k, v in pairs(pvgames.portraits) do
		image.name(frames[v + 1], k)
		portraits[k] = frames[v + 1]
	end

	collection.collect(collection.IMAGE, portraitSheet)
	return portraits
end

---@param dir string
---@param portrait string
---@return integer
function pvgames.extract_portrait(dir, portrait)
	local portraitSheet = io.decode(io.path_join(dir, PortraitFile))
	local frame = spritesheet.to_frames(
		portraitSheet,
		portrait,
		spritesheet.sheet(1, 2000, 2000, 4, spritesheet.offset_index(pvgames.portraits[portrait])),
		true
	)[1]

	collection.collect(collection.IMAGE, portraitSheet)
	return frame
end

---@param dir string
---@return table<string, integer>
function pvgames.extract_animations(dir)
	local animSheet = io.decode(io.path_join(dir, SpritesheetFile))

	local animations = {}

	for k, v in pairs(pvgames.animations) do
		local sheet1, sheet2 = pvgames.animation_spritesheet(v.offset, v.length, true)
		local anim = spritesheet.extract(animSheet, k, sheet1, sheet2, true)

		animations[k] = anim
	end

	collection.collect(collection.IMAGE, animSheet)
	return animations
end

---@param dir string
---@param animation string
---@return integer
function pvgames.extract_animation(dir, animation)
	local animSheet = io.decode(io.path_join(dir, SpritesheetFile))

	local v = pvgames.animations[animation]

	local sheet1, sheet2 = pvgames.animation_spritesheet(v.offset, v.length, true)
	local anim = spritesheet.extract(animSheet, animation, sheet1, sheet2, true)

	collection.collect(collection.IMAGE, animSheet)
	return anim
end

---@param dir string
---@return {portraits: table<string, integer>, animations: table<string, integer>}
function pvgames.extract(dir)
	local sprites = {
		portraits = pvgames.extract_portraits(dir),
		animations = pvgames.extract_animations(dir),
	}

	return sprites
end

pvgames.portraits = {
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

---@class animation
---@field offset integer
---@field length integer

---@param offset integer
---@param length integer
---@return animation
function create_animation(offset, length)
	return {
		offset = offset,
		length = length,
	}
end

pvgames.animations = {
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

