-- unichest-large: enlarge the Unichest entity to a 7x7 logistics dock.
-- This is a "modification mod": it mutates Unichest's prototype in place
-- instead of redefining it, so it must load after Unichest.

-- Unichest registers its item, entity, recipe, and technology under the same
-- name. The recipe picks up its icon from the item automatically.
local name = "zy-unichest"
local item = data.raw["item"][name]
local entity = data.raw["linked-container"][name]
local technology = data.raw["technology"][name]

assert(
  entity and item and technology,
  "unichest-large could not find the 'zy-unichest' prototypes. " ..
  "The Unichest mod must be installed and enabled (it is a required dependency). " ..
  "If Unichest is installed, its internal prototype names may have changed in a newer version."
)

-- 7x7 footprint (with a little extra collision margin, like vanilla large buildings)
entity.collision_box = { { -3.4, -3.4 }, { 3.4, 3.4 } }
entity.selection_box = { { -3.5, -3.5 }, { 3.5, 3.5 } }
entity.drawing_box = { { -3.5, -3.5 }, { 3.5, 3.5 } }

-- Replace the 1x1 linked-chest picture with a single warehouse sprite.
-- The Warehousing mod draws this same 520x480 sprite at scale 0.5 for its 6x6
-- warehouse; 0.5 * 7/6 ~= 0.58 keeps the same overhang over our 7x7 footprint,
-- the way vanilla building sprites overhang their collision box.
-- NOTE: shift/scale may need a small in-game visual tweak.
entity.picture = {
  filename = "__unichest-large__/graphics/warehouse-linked.png",
  width = 520,
  height = 480,
  scale = 0.58,
  shift = { 0, 0 },
}

-- Icons: Unichest reuses the vanilla linked-chest icon for the item, entity,
-- and technology. Point them at the warehouse art instead. Both icon files are
-- 4-mipmap strips (icon_size + half + quarter + eighth laid out horizontally).
local icon = "__unichest-large__/graphics/icons/warehouse-linked.png"
item.icon = icon
item.icon_size = 64
item.icon_mipmaps = 4
entity.icon = icon
entity.icon_size = 64
entity.icon_mipmaps = 4

-- TODO: draw a dedicated research image for the enlarged dock; the Warehousing
-- warehouse research image will do for now.
technology.icon = "__unichest-large__/graphics/research/warehouse-research.png"
technology.icon_size = 256
technology.icon_mipmaps = 4

-- Everything else (inventory settings, recipe, technology unlocks, gui_mode, ...)
-- is intentionally left untouched.
