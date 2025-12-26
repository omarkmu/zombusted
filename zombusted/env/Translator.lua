---Partial implementation of the Translator class.

local Translator = {}
Translator.__index = Translator
require 'zombusted.env.install' ('Translator', Translator)

local state = require 'zombusted.zomboid.state'

Translator.debug = false

function Translator.getDefaultLanguage()
    return state.DEFAULT_LANGUAGE
end

function Translator.getLanguage()
    return state.LANGUAGE
end

function Translator.new()
    return {}
end
