-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")

local hotkeys_popup = require("awful.hotkeys_popup")
--require("awful.hotkeys_popup.keys")

-- Load Debian menu entries
require("debian.menu")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- These are defaults for notify
naughty.config.defaults.timeout          = 5
naughty.config.defaults.screen           = 1
naughty.config.defaults.position         = "top_right"
naughty.config.defaults.margin           = 10
naughty.config.defaults.gap              = 1
naughty.config.defaults.ontop            = true
naughty.config.defaults.icon_size        = 32
naughty.config.defaults.fg               = beautiful.fg_focus
naughty.config.defaults.bg               = beautiful.bg_normal
naughty.config.presets.normal.border_color     = beautiful.fg_focus
naughty.config.defaults.border_width     = 2
naughty.config.defaults.hover_timeout    = nil

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init("/home/gbell2/.config/awesome/themes/default/theme.lua")
--beautiful.init("/usr/share/awesome/themes/zenburn/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "/home/gbell2/bin/random_term"
editor = os.getenv("EDITOR") or "editor"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
    awful.layout.suit.tile,
    awful.layout.suit.max,
    awful.layout.suit.floating,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier
}
-- }}}

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
tags[1] = awful.tag({ "➊", "➋", "❸-uf", "❹-λ"}, 1, layouts[1])
tags[2] = awful.tag({ "comms", 1 }, 2, layouts[1])
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mainmenu = {}

local deskopen = "/home/gbell2/bin/deskopen "

table.insert(mainmenu, {"See",
{
    {"Chromium", "chromium-browser", "/usr/share/icons/hicolor/128x128/apps/chromium-browser.png"},
    {"Firefox", "firefox -P default --new-instance", "/usr/share/pixmaps/firefox.png"},
    {"Photos", "/home/gbell2/bin/gq_go_camera", "/usr/share/pixmaps/geeqie.png"},
    {"Shotwell", "shotwell", "/usr/share/icons/hicolor/24x24/apps/shotwell.svg"},
    {"GoogleEarth", "google-earth", "/opt/google/earth/free/product_logo_48.png"},
    {"Stellarium", "stellarium", "/usr/share/icons/hicolor/32x32/apps/stellarium.png"},
    {"Kaffeine", "kaffeine", "/usr/share/icons/hicolor/32x32/apps/kaffeine.png"},
    {"Calibre e-books", "calibre", "/usr/share/icons/hicolor/32x32/apps/calibre-gui.png"},
}})

table.insert(mainmenu, {"Hear",
{
    {"Radio", "vlc --playlist-tree /mp3/00_lists/internode.m3u", "/usr/share/icons/default.kde4/32x32/mimetypes/audio-x-wav.png"},
    {"My Music", "audacious", "/usr/share/pixmaps/audacious-32.xpm"},
    {"Rhythmbox", "rhythmbox", "/usr/share/icons/hicolor/32x32/apps/rhythmbox.png"},
    {"PA Mixer", "pavucontrol", "/opt/share/icons/sound.png"},
}})

table.insert(mainmenu, {"Speak",
{
    {"Thunderbird", "thunderbird", "/usr/lib/thunderbird/chrome/icons/default/default256.png" },
    {"Skype", "/home/gbell2/bin/skypeb.fluxbox", "/opt/share/icons/SkypeBlue_48x48.png" },
    {"Pidgin", "pidgin", "/usr/share/icons/hicolor/32x32/apps/pidgin.png" },
}})

table.insert(mainmenu, {"Create",
{
    {"Gvim", "gvim -c :start \"+:set guioptions+=m\"", "/usr/share/pixmaps/vim-32.xpm"},
    {"Writer", "lowriter", "/opt/share/icons/openofficeorg-writer.png"},
    {"Gimp", "gimp", "/usr/share/icons/hicolor/32x32/apps/gimp.png"},
    {"Audacity", "audacity", "/usr/share/pixmaps/audacity32.xpm"},
    {"Inkscape", "inkscape", "/usr/share/icons/oxygen/32x32/apps/inkscape.png"},
    {"Foxit PDF", "/usr/share/playonlinux/playonlinux --run 'FoxitReader'", "/opt/share/icons/foxit.png"},
    {"Avidemux", "avidemux", "/usr/share/pixmaps/avidemux2.6-qt.xpm"},
    {"OB Studio", "obs", "/usr/share/icons/hicolor/256x256/apps/obs.png"},
    {"Office",
        {
            {"Impress", "loimpress"},
            {"Math", "lomath"},
            {"Base", "lobase"},
            {"Draw", "lodraw"},
        }
    },
    {"Screencast", "vokoscreen", "/usr/share/pixmaps/vokoscreen.png"},
}})

table.insert(mainmenu, {"Calculate",
{
    {"Calc", "localc", "/opt/share/icons/openofficeorg-calc.png"},
    {"Geogebra", "/home/gbell2/bin/geogebra.awesome", "/usr/share/icons/hicolor/32x32/apps/geogebra.png"},
}})

table.insert(mainmenu, {"Compute",
{
    {"VirtualBox Windows 10", deskopen .. "windows", "/opt/share/icons/win10.png"},
    {"VirtualBox", "VirtualBox", "/usr/share/icons/hicolor/64x64/apps/virtualbox.png"},
    {"awesome", myawesomemenu, beautiful.awesome_icon },
    {"Reboot into Windows", "/home/gbell2/bin/bootwin", "/usr/share/icons/hicolor/32x32/actions/system-restart.png"},
    {"Reboot", "sudo reboot", "/usr/share/icons/hicolor/32x32/actions/system-restart.png"},
    {"Poweroff", "sudo /sbin/poweroff", "/usr/share/icons/Humanity/actions/48/application-exit.svg"},
    {"Utils",
    {
        {"top", "gnome-terminal -e top"},
        {"iotop", "gnome-terminal -e 'sudo iotop'"},
        {"iftop", "gnome-terminal -e \"sudo iftop -c /root/.iftoprc -b -i enp3s0\""},
        {"Xkill", "xkill"},
        {"baobab", "baobab", "/usr/share/icons/hicolor/24x24/apps/baobab.png"},
        {"GSmartControl", "sudo /usr/bin/gsmartcontrol", "/usr/share/icons/hicolor/48x48/apps/gsmartcontrol.png"},
    }},
    {"X-utils",
    {
        {"xfontsel", "xfontsel" },
        {"xload", "xload" },
        {"xbiff", "xbiff" },
        {"editres", "editres" },
        {"viewres", "viewres" },
        {"xmag", "xmag" },
        {"Reload .Xdefaults", "xrdb -load $HOME/.Xdefaults" },
    }},
    { "All Apps", debian.menu.Debian_menu.Debian },
}})

table.insert(mainmenu, {"Develop",
{
    {"PHPStorm", deskopen .. "jetbrains-phpstorm", "/opt/share/icons/phpstorm.png"},
    {"mysql-workbench", "mysql-workbench", "/usr/share/pixmaps/mysql-workbench.xpm"},
    {"generate passwords", "xterm +sb -e 'generate_pws ; read x'", "/usr/share/icons/hicolor/32x32/status/bluetooth-paired.png"},
    {"KRuler", "kruler", "/usr/share/icons/hicolor/64x64/apps/kruler.png"},
    {"UMLet", "/opt/bin/umlet", "/opt/share/icons/umlet_logo.png"},
    {"Pigendo", "/opt/bin/pingendo", "/opt/share/icons/pigendo.png"},
    {"Firefox Dev", "firefox -P WebDev --new-instance", "/usr/share/icons/hicolor/64x64/apps/firefox.png"},
    {"FileZilla", "filezilla", "/usr/share/filezilla/resources/48x48/filezilla.png"},
    {"Apache Directory Studio", "ApacheDirectoryStudio", "/opt/ApacheDirectoryStudio-2.0.0/icon.xpm"},
    {"Zeal", "zeal", "/usr/share/icons/hicolor/64x64/apps/zeal.png"},
}})

table.insert(mainmenu, {"Manage",
{
    {"GnuCash", "gnucash", "/usr/share/icons/hicolor/48x48/apps/gnucash-icon.png"},
    {"gb_access", "xterm +sb -e /home/gbell2/bin/gb_access","/usr/share/icons/hicolor/32x32/status/bluetooth-paired.png"},
    {"ToDo", deskopen .. "todo"},
    {"Invest", deskopen .. "invest"},
    {"Outline", "gvim /info/outline.txt"},
    {"Id3 tag editor", "easytag", "/usr/share/icons/hicolor/48x48/apps/easytag.png"},
}})

table.insert(mainmenu, {"Get data in, Put data out",
{
    {"Handbrake", "handbrake", "/usr/share/icons/hicolor/scalable/apps/hb-icon.svg"},
    {"Slurp camera", "xterm +sb -e $HOME/bin/slurp_camera", "/usr/share/icons/gnome/32x32/devices/camera_unmount.png"},
    {"Burn CD/DVD", "brasero", "/usr/share/icons/hicolor/24x24/apps/brasero.png"},
    {"Rip CD/DVDX", "ripperX",  "/usr/share/pixmaps/ripperx.xpm"},
    {"FileZilla", "filezilla",  "/usr/share/pixmaps/filezilla.png"},
    {"Torrent", "transmission-gtk", "/usr/share/pixmaps/transmission.xpm"},
}})


mymainmenu = awful.menu({ items = mainmenu })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock( " %a %d %b, %I:%M%p ", 1 )

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({
                                                      theme = { width = 250 }
                                                  })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mylauncher)
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    right_layout:add(mytextclock)
    right_layout:add(mylayoutbox[s])

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
function minimised_list()
    if cl_menu then
        cl_menu:hide()
        cl_menu=nil
    else
        client_list={}
        local tag = awful.tag.selected()
        for i=1, #tag:clients() do
            cl=tag:clients()[i]
            if tag:clients()[i].minimized then
                if not awful.rules.match(cl, {class= "Conky"}) then
                    client_list[i]=
                    {cl.name, function()
                       tag:clients()[i].minimized=not tag:clients()[i].minimized
                    end,
                    cl.icon
                    }
                end
            end
        end
        cl_menu=awful.menu({items = client_list, theme = {width=300}})
        cl_menu:show()
    end
end

globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),

    -- Window lists
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end),
    awful.key({ modkey,           }, "s", minimised_list),
    awful.key({ modkey            }, "t", function() instance = awful.menu.clients({theme = { width = 250 }}) end),

    -- Help
    awful.key({ "Mod1" }, "l", hotkeys_popup.widget.show_help, {description = "show help", group="awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( 1) end,
        {description = "swap with previous client", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  -1) end,
        {description = "swap with next client", group = "awesome"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative( 1) end,
        {description = "focus previous screen", group = "awesome"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative(-1) end,
        {description = "focus next screen", group = "awesome"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05) end,
        {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05) end,
        {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1) end,
        {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1) end,
        {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1) end,
        {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1) end,
        {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Prompt
    awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end),

    -- Greg's keyboard's function keys
    awful.key({                   }, "#173",   function () awful.util.spawn("/opt/bin/player-control vlc prev") end),
    awful.key({                   }, "#171",   function () awful.util.spawn("/opt/bin/player-control vlc next") end),
    awful.key({                   }, "#172",   function () awful.util.spawn("/opt/bin/player-control vlc toggle") end),
    awful.key({                   }, "#148",   function () awful.util.spawn("gnome-calculator") end),

    -- Greg's other keys
    awful.key({                   }, "#107",   function () awful.util.spawn("shutter -s") end),
    awful.key({                   }, "#78",    function () awful.util.spawn("gvim -c :start") end),
    awful.key({                   }, "#127",   function () toggle_conky() end),
    awful.key({ modkey,           }, "#78",    function () awful.util.spawn("gvim -c ':put +'") end),
    awful.key({                   }, "#135",   function () awful.util.spawn(terminal) end),
    awful.key({ modkey,           }, "#135",   function () awful.util.spawn("/home/gbell2/bin/term same") end),
    awful.key({ modkey, "Control" }, "#135",   function () awful.util.spawn("gnome-calculator") end),
    awful.key({ modkey,           }, "Return", function () awful.util.spawn("firefox -P default") end),
    awful.key({ modkey, "Shift"   }, "Return", function () awful.util.spawn("firefox -P default") end),
    awful.key({ modkey, "Control" }, "Return", function () awful.util.spawn("thunderbird -compose") end),
    awful.key({ modkey, "Mod1"    }, "Return", function () awful.util.spawn("thunar") end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Control" }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.movetotag(tag)
                          end
                     end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.toggletag(tag)
                          end
                      end
                  end))
end

-- Set keys
root.keys(globalkeys)
-- }}}
--

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
--
clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

    awful.rules.rules = {
        -- All clients will match this rule.
        { rule = { },
            properties = {
                border_width = beautiful.border_width,
                border_color = beautiful.border_normal,
                screen = awful.screen.preferred,
                focus = awful.client.focus.filter,
                raise = true,
                keys = clientkeys,
                buttons = clientbuttons,
                size_hints_honor = false
            }
        },

        { rule = { class = "vlc" },
            properties = {
                floating = true,
                x = 0,
                y = 20,
                width = 600,
                height = 750
            }
        },

        -- Floating clients
        { rule_any = {
            class = {
                "kruler",
                "gimp",
                "VirtualBox",
                "calculator",
                "ssh-askpass"},
            },
            name = {
                "Calculator"
            },
            properties = {
                floating = true
            }
        },
        { rule = { class = "Shutter" },
            properties = {
                floating = true,
                name = "Shutter",
                x = 240,
                y = 19,
                width = 760,
                height = 850
            }
        },
        { rule = { class = "Skype" },
            properties = {
                floating = true,
                name = "Skype",
                x = 0,
                y = 19,
                width = 240,
                height = 850
            }
        },
        { rule = { class = "Conky" },
            properties = {
                sticky = true,
            }
        },
    }
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        --awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- buttons for the titlebar
        local buttons = awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                )

        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))
        left_layout:buttons(buttons)

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local middle_layout = wibox.layout.flex.horizontal()
        local title = awful.titlebar.widget.titlewidget(c)
        title:set_align("center")
        middle_layout:add(title)
        middle_layout:buttons(buttons)

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(middle_layout)

        awful.titlebar(c):set_widget(layout)
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c)
    c.border_color = beautiful.border_normal
    if c.maximized then
--        c.minimized = true
    end
end)

function get_conky()
    local clients = client.get()
    local conky = nil
    local i = 1
    while clients[i]
    do
        if clients[i].class == "Conky"
        then
            conky = clients[i]
        end
        i = i + 1
    end
    return conky
end

function toggle_conky()
    local conky = get_conky()
    if conky
    then
        -- Just set this because placement is buggy
        conky.y = 40
        conky.border_width = 0
        if conky.ontop
        then
            conky.ontop = false
            --conky.hidden = true
            conky.x = 4000
        else
            conky.ontop = true
            --conky.hidden = false
            conky.x = 3159
        end
    end
end

function minimize(class)
    local clients = client.get()
    local i = 1
    while clients[i]
    do
        if clients[i].class == class
        then
            clients[i].minimized = true
        end
        i = i + 1
    end
end

function run_once(prg, testexec)
    if testexec == '' or testexec == nil
    then
        iter = prg:gmatch("%S+")
        testexec = iter()
    end
    awful.util.spawn_with_shell("/home/gbell2/bin/run_once " .. testexec .. " " .. prg)
end

-- Processes to start (first, not when Awesome is restarted)
run_once("workrave")
run_once("conky")
--run_once("pulseaudio")
--run_once("zeal")
run_once("thunderbird")
run_once("chromium-browser")
run_once("gvim ~/what_you_are_doing.md")
run_once("localc /home/gbell2/todo.ods")

-- Commands to run (every time)
awful.util.spawn_with_shell("xrdb", "/home/gbell2/.myconfigs/Xresources.colors")
awful.util.spawn_with_shell("xrdb", "-merge /home/gbell2/.Xresources")
awful.util.spawn_with_shell(". /home/gbell2/.myconfigs/trackman.bash")
awful.util.spawn_with_shell(". /home/gbell2/.myconfigs/genius.bash")
awful.util.spawn_with_shell("xmodmap", "/home/gbell2/.myconfigs/.Xmodmap")
awful.util.spawn_with_shell("xset dpms 7200 7200 7200")
awful.util.spawn_with_shell("xset s 7200 7200")
--awful.util.spawn_with_shell("display -backdrop -window root /pics/misc/backgrounds/merged_background_two_big_monitors2.jpg")
--awful.util.spawn_with_shell("display -backdrop -window root /home/gbell2/linen_twin.jpg")
awful.util.spawn_with_shell("xsetroot -solid steelblue")

-- }}}
