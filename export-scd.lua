Export1 = dofile("./export1.lua")
Export2 = dofile("./export2.lua")
Export3 = dofile("./export3.lua")

function init(plugin)
  plugin:newMenuGroup{
    id="exportscd_folder",
    title="Export Sprite Color Difference",
    group="file_export_2"
  }
  plugin:newCommand{
    id="export1",
    title="Auto Index Size",
    group="exportscd_folder",
    onenabled = function() return app.activeSprite ~= nil end,
    onclick = function()
      Export1()
    end
  }
  plugin:newCommand{
    id="export2",
    title="Auto Gradation",
    group="exportscd_folder",
    onenabled = function() return app.activeSprite ~= nil end,
    onclick = function()
      Export2()
    end
  }
  plugin:newCommand{
    id="export3",
    title="Select Folder",
    group="exportscd_folder",
    onenabled = function() return app.activeSprite ~= nil end,
    onclick = function()
      Export3()
    end
  }
end

function exit(plugin) end