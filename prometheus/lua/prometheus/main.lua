-- Start plugin for modern prometheus plugin structure
-- Core dependencies
module("prometheus.main",package.seeall)
require("prometheus.core.bootstrap")
require("prometheus.core.config")
require("prometheus.core.sound")
require("prometheus.core.plugin")

-- help
require("prometheus.help")
-- import macros
require("prometheus.macros.misc")
require("prometheus.macros.numpad")

-- sounds
require("prometheus.sounds")

-- Utils
require("prometheus.util")
