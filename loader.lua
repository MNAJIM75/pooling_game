loader = {}

loader.load_texture = rl.LoadTexture
loader.load_sound = rl.LoadSound
loader.unload_texture = rl.UnloadTexture
loader.unload_sound = rl.UnloadSound

sprites = {}
sfx = {}

function loader.init()
  log.trace("[Loader] initialized.")
end

function loader.load_game_textures()
  local path = "./res"  -- folder path
  local p = io.popen('dir "'..path..'" /b /a-d')  -- use "dir" on Windows
  for file in p:lines() do
    local s = loader.load_texture("./res/"..file)
    if s.width > 0 then
      table.insert(sprites, s)
      log.info("[Loader] " .. file .. " loaded.")
    else
      log.error("[Loader] "..file.." failed to load.")
      assert(false, "Failed to load data -> " .. file)
    end
  end
  p:close()
end

function loader.close()
  for i,v in pairs(sprites) do
    if v.width > 0 then
      loader.unload_texture(v)
      log.info("[Loader] ".. tostring(i) .. ' sprite unloaded.')
    else log.error("[Loader] cannot unload empty sprite.")
    end
  end
  log.trace("[Loader] closed.")
end
