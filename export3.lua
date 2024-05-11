function Export3()
  local ase = app.activeSprite
  if not ase then
    return app.alert("There is no active sprite")
  end

  local palette_folder
  local copy = Sprite(ase) -- Create sprite copy

  local dlg = Dialog("  Select palette in folder  ")
  dlg:file{
    id="myfile",
    title="File",
    open=true,
    save=false,
    filetypes={"ase", "aseprite", "png", "act", "gpl", "hex", "pal"},
    onchange=function()
        local file = dlg.data.myfile
        if file ~= nil then
          app.command.OpenInFolder{filename=file}
          local dataPath = file
          palette_folder = dataPath:match("(.*[/\\])") -- Set Palette directory
        end
    end
  }
  dlg:button{ id="ok", text="OK" }
  dlg:show{wait=true}

  local files = app.fs.listFiles(palette_folder)

  for i, filepath in ipairs(files) do
    local ext = string.lower(app.fs.fileExtension(filepath))
    if ext == "ase" or ext == "aseprite" or ext == "png" or ext == "act" or ext == "gpl" or ext == "hex" or ext == "pal" then
      local palette_path = palette_folder .. app.fs.fileName(filepath)
      local palette = Palette{ fromFile=palette_path }
      
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

return Export3
