rockspec_format = "3.0"
package = "zombusted"
version = "scm-0"

dependencies = {
    "lua >= 5.1",
    "busted >= 2.2.0",
    "luassert >= 1.9.0",
    "say >= 1.4-1",
}

source = {
    url = "git://github.com/omarkmu/pz-utils.git"
}

build = {
    type = "builtin",
    modules = {
        zombusted = "zombusted/init.lua",

        ["zombusted.assertions"] = "zombusted/assertions.lua",
        ["zombusted.helpers"] = "zombusted/helpers.lua",

        ["zombusted.internal.state"] = "zombusted/internal/state.lua",

        ["zombusted.env.install"] = "zombusted/env/install.lua",
        ["zombusted.env.ui"] = "zombusted/env/ui/init.lua",
        ["zombusted.env.ui.ISUIElement"] = "zombusted/env/ui/ISUIElement.lua",
        ["zombusted.env.ui.UIElement"] = "zombusted/env/ui/UIElement.lua",
        ["zombusted.env.ui.UIManager"] = "zombusted/env/ui/UIManager.lua",
        ["zombusted.env.Globals"] = "zombusted/env/Globals.lua",
        ["zombusted.env.BufferedReader"] = "zombusted/env/BufferedReader.lua",
        ["zombusted.env.Event"] = "zombusted/env/Event.lua",
        ["zombusted.env.EventList"] = "zombusted/env/EventList.lua",
        ["zombusted.env.ISBaseObject"] = "zombusted/env/ISBaseObject.lua",
        ["zombusted.env.Kahlua"] = "zombusted/env/Kahlua.lua",
        ["zombusted.env.LuaEventManager"] = "zombusted/env/LuaEventManager.lua",
        ["zombusted.env.LuaFileWriter"] = "zombusted/env/LuaFileWriter.lua",
        ["zombusted.env.ModData"] = "zombusted/env/ModData.lua",
        ["zombusted.env.Translator"] = "zombusted/env/Translator.lua",

        ["zombusted.zomboid"] = "zombusted/zomboid/init.lua",
        ["zombusted.zomboid.Color"] = "zombusted/zomboid/Color.lua",
        ["zombusted.zomboid.state"] = "zombusted/zomboid/state.lua",
        ["zombusted.zomboid.IsoPlayer"] = "zombusted/zomboid/IsoPlayer.lua",
        ["zombusted.zomboid.Language"] = "zombusted/zomboid/Language.lua",
        ["zombusted.zomboid.SurvivorDesc"] = "zombusted/zomboid/SurvivorDesc.lua",

        ["zombusted.languages.en"] = "zombusted/languages/en.lua",
    }
}
