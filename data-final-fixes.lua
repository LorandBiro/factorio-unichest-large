-- unichest-large: enlarge the Unichest entity to a 7x7 logistics dock.
-- This is a "modification mod": it mutates Unichest's prototype in place
-- instead of redefining it, so it must load after Unichest.

local entity = data.raw["linked-container"]["zy-unichest"]

assert(
  entity,
  "unichest-large could not find the 'zy-unichest' prototype. " ..
  "The Unichest mod must be installed and enabled (it is a required dependency). " ..
  "If Unichest is installed, its internal entity name may have changed in a newer version."
)

-- 7x7 footprint (with a little extra collision margin, like vanilla large buildings)
entity.collision_box = { { -3.4, -3.4 }, { 3.4, 3.4 } }
entity.selection_box = { { -3.5, -3.5 }, { 3.5, 3.5 } }
entity.drawing_box = { { -3.5, -3.5 }, { 3.5, 3.5 } }

-- Replace the 1x1 linked-chest picture with a single warehouse sprite.
-- scale 0.58 is chosen so the 520x480 2x-art renders slightly over the 7x7
-- footprint, the way vanilla building sprites overhang their collision box.
-- NOTE: shift/scale may need a small in-game visual tweak.
entity.picture = {
  filename = "__unichest-large__/graphics/warehouse-linked.png",
  width = 520,
  height = 480,
  scale = 0.58,
  shift = { 0, 0 },
}

-- Everything else (inventory settings, recipe, technology, gui_mode, ...) is
-- intentionally left untouched.
