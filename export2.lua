function Export2()
  local ase = app.activeSprite
  if not ase then
    return app.alert("There is no active sprite")
  end

  -- Get Index Color value of activeSprite
  local base_palette = ase.palettes[1]
  local color_count = #ase.palettes[1] - 2
  local palette_folder
  local copy = Sprite(ase) -- Create sprite copy

  local palette_folder = app.fs.userConfigPath .. app.fs.joinPath("palettes", "color_diff", "2") .. app.fs.pathSeparator
  local files = app.fs.listFiles(palette_folder)

  for i, filepath in ipairs(files) do
    local ext = string.lower(app.fs.fileExtension(filepath))
    if ext == "ase" or ext == "aseprite" or ext == "png" or ext == "act" or ext == "gpl" or ext == "hex" or ext == "pal" then
      local palette_path = palette_folder .. app.fs.fileName(filepath)
      local palette_file = Palette{ fromFile=palette_path }

      local start_color = palette_file:getColor(1)
      local end_color = palette_file:getColor(2)

      -- Create new palette
      local new_palette = Palette(color_count+2)
      new_palette:setColor(0, base_palette:getColor(0))

      -- Gradation calc
      for i = 0 , color_count do
          local ratio = i / color_count
          local r = start_color.red * (1.0 - ratio) + end_color.red * ratio
          local g = start_color.green * (1.0 - ratio) + end_color.green * ratio
          local b = start_color.blue * (1.0 - ratio) + end_color.blue * ratio
          new_palette:setColor(i+1, Color{ r=r, g=g, b=b })
      end

      copy:setPalette(new_palette)

      -- Filename generate
      local outname = app.fs.fileTitle(ase.filename) .. "_" .. app.fs.fileTitle(filepath) .. ".png"
      
      local outfilepath = app.fs.filePath(ase.filename) .. app.fs.pathSeparator .. outname

      -- Export PNG
      copy:saveCopyAs(outfilepath)
    end
  end

  -- close sprite copy
  copy:close()
end

return Export2
