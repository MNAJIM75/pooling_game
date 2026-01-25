loader = {}

local load_texture = rl.LoadTexture
local load_sound = rl.LoadSound
local unload_texture = rl.UnloadTexture
local unload_sound = rl.UnloadSound

sprites = {}
sfx = {}

function loader.init()
  log.trace("[Loader] initialized.")
  local path = "./res"  -- folder path
  local p = io.popen('dir "'..path..'" /b /a-d')  -- use "dir" on Windows
  for file in p:lines() do
    local s = load_texture("./re/"..file)
    print(s)
    if s then
      table.insert(sprites, s)
      log.info("[Loader] " .. file .. " loaded.")
    else
      log.error("[Loader] "..file.." failed to load.")
    end
  end
  p:close()
end

function loader.close()
  log.trace("[Loader] closed.")
  for i,v in pairs(sprites) do
    unload_texture(v)
    log.info("[Loader] ".. tostring(i) .. ' sprite unloaded.')
  end
end
