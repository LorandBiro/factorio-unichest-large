-- unichest-large: enlarge the Unichest entity to a 6x6 memory-unit silo.
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

-- Building art: the "memory-unit" entity from the Deep Storage Unit
-- ("Memory Storage") mod (MIT, code by notnotmelon, graphics by kaueNP -- see
-- CREDITS and graphics/LICENSE-DeepStorageUnit.txt). We reuse the art AND the
-- entity configuration exactly as the original mod defines it: a 6x6 building
-- (collision_box +/-2.7, selection_box +/-3) with a 512x512 sprite at
-- scale 0.5 and shift {0.59375, 0}.
entity.collision_box = { { -2.7, -2.7 }, { 2.7, 2.7 } }
entity.selection_box = { { -3, -3 }, { 3, 3 } }
-- No drawing_box: the original mod sets none, and EntityPrototype::drawing_box
-- no longer exists in Factorio 2.0 (replaced by
-- drawing_box_vertical_extension).

entity.picture = {
  filename = "__unichest-large__/graphics/memory-unit.png",
  priority = "high",
  size = { 512, 512 },
  scale = 0.45,
  shift = { 0.534375, 0 },
}

-- Icons: the original memory-unit item icon (64px + 3 mipmap levels in a
-- 120x64 strip) on the item and the entity. Unichest reuses the vanilla
-- linked-chest icon otherwise.
local icon = "__unichest-large__/graphics/icons/memory-unit.png"
item.icon = icon
item.icon_size = 64
item.icon_mipmaps = 4
entity.icon = icon
entity.icon_size = 64
entity.icon_mipmaps = 4

-- Research icon: the original memory-unit technology icon (128x128).
technology.icon = "__unichest-large__/graphics/research/memory-unit.png"
technology.icon_size = 128
technology.icon_mipmaps = nil

-- Everything else (inventory settings, recipe, technology unlocks, gui_mode, ...)
-- is intentionally left untouched.
