function Export1()
  local ase = app.activeSprite
  if not ase then
    return app.alert("There is no active sprite")
  end

  -- Create sprite copy
  local copy = Sprite(ase)

  -- Get Index Color value of activeSprite
  local color_count = #ase.palettes[1] - 1

  -- Folder select
  local palette_folder = app.fs.userConfigPath .. app.fs.joinPath("palettes", "color_diff") .. app.fs.pathSeparator .. tostring(color_count) .. app.fs.pathSeparator 

  -- Select a folder from the number of activeSprite colors
  local files = app.fs.listFiles(palette_folder)

  for i, filepath in ipairs(files) do
    local ext = string.lower(app.fs.fileExtension(filepath))
    if ext == "ase" or ext == "aseprite" or ext == "png" or ext == "act" or ext == "gpl" or ext == "hex" or ext == "pal" then
      palepath = palette_folder .. app.fs.fileName(filepath)
      local palette = Palette{ fromFile=palepath }
      
      copy:setPalette(palette)

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

return Export1