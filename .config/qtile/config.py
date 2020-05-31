# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import logging
from collections import namedtuple
from typing import List  # noqa: F401

from Xlib import display as xdisplay

from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.lazy import lazy
from libqtile.log_utils import logger
from libqtile import layout, bar, widget

logger.setLevel(logging.INFO)
mod = "mod4"

ColorScheme = namedtuple('ColorScheme', [
    'common_accent',       
    'common_bg',           
    'common_fg',
    'common_ui',
    'warning',
    'error',
    'ui_line',
    'ui_panel_bg',
    'ui_panel_shadow',
    'ui_panel_border',
    'ui_selection_bg',
    'ui_selection_fg',
    'ui_selection_inactive',
    'ui_selection_active',
    'ui_selection_border',
])

color = ColorScheme(
    common_accent         = '#ffcc66',
    common_bg             = '#1f2430',
    common_fg             = '#cbccc6',
    common_ui             = '#707a8c',
    warning               = '#ffa759',
    error                 = '#ff3333',
    ui_line               = '#191e2a',
    ui_panel_bg           = '#232834',
    ui_panel_shadow       = '#141925',
    ui_panel_border       = '#101521',
    ui_selection_bg       = '#34455a', 
    ui_selection_fg       = '#edf0f5',
    ui_selection_inactive = '#2d3b4d',
    ui_selection_active   = '#73d0ff',
    ui_selection_border   = '#3c526a',
)

def get_next_screen(qtile):
    return (qtile.screens.index(qtile.current_screen) + 1) % len(qtile.screens)

def get_prev_screen(qtile):
    return (qtile.screens.index(qtile.current_screen) - 1) % len(qtile.screens)

def move_group_to_prev_screen():
    def func(qtile):
        qtile.current_group.cmd_toscreen(get_prev_screen(qtile))
        qtile.cmd_prev_screen()
    return func

def move_group_to_next_screen():
    def func(qtile):
        qtile.current_group.cmd_toscreen(get_next_screen(qtile))
        qtile.cmd_next_screen()
    return func

terminal        = "termite --title Termite"
browser         = "vivaldi-stable"
file_manager    = "pcmanfm"
package_manager = "pamac-manager"
audio_control   = "pavucontrol"
launcher        = "dmenu_recency -i -nb '{}' -nf '{}' -sb '{}' -sf '{}'".format(
        color.common_bg, color.common_fg, 
        color.ui_selection_bg , color.ui_selection_fg
)

keys = [
    # Switch between windows in current stack pane
    Key([mod], "j",    lazy.layout.up()),
    Key([mod], "Up",   lazy.layout.up()),
    Key([mod], "k",    lazy.layout.down()),
    Key([mod], "Down", lazy.layout.down()),
    
    # Move windows up or down in current stack
    Key([mod, "control"], "j",    lazy.layout.shuffle_up()),
    Key([mod, "control"], "Up",   lazy.layout.shuffle_up()),
    Key([mod, "control"], "k",    lazy.layout.shuffle_down()),
    Key([mod, "control"], "Down", lazy.layout.shuffle_down()),

    # Switch window focus to other pane(s) of stack
    Key([mod], "space", lazy.layout.next()),

    # Swap panes of split stack
    Key([mod, "shift"], "space", lazy.layout.rotate()),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return",   lazy.layout.toggle_split()),
    Key([mod], "Return",            lazy.spawn(terminal)),
    Key([mod], "F2",                lazy.spawn(browser)),
    Key([mod], "F3",                lazy.spawn(file_manager)),
    Key([mod], "F4",                lazy.spawn(package_manager)),
    Key([mod], "d",                 lazy.spawn(launcher)),
    Key([mod, "control"], "m",      lazy.spawn(audio_control)),

    Key([mod], "Tab",               lazy.next_layout()),
    Key([mod, "control"], "r",      lazy.restart()),
    Key([mod, "shift"], "e",        lazy.shutdown()),
    Key([mod], "r",                 lazy.spawncmd()),

    Key([mod], "q",                 lazy.window.kill()), 
    Key([mod], "f",                 lazy.window.toggle_fullscreen()),
    Key([mod, "shift"], "space",    lazy.window.toggle_floating()),

    # Rotate through groups on this screen
    Key([mod], "bracketleft",       lazy.screen.prev_group(skip_managed=True)),
    Key([mod], "bracketright",      lazy.screen.next_group(skip_managed=True)),
    
    # Move focus to prev/next screen
    Key([mod],            "comma",  lazy.function(lambda qtile: qtile.cmd_prev_screen() )),
    Key([mod],            "period", lazy.function(lambda qtile: qtile.cmd_next_screen() )),

    # Move group to prev/next screen
    Key([mod, "control"], "comma",  lazy.function(move_group_to_prev_screen())),
    Key([mod, "control"], "period", lazy.function(move_group_to_next_screen())),
]

groups = []
for group_name in "1234567890":
    if group_name == "8":
        group = Group(group_name)
        #group = Group(group_name, layout="layout.TreeTab")
    else:
        group = Group(group_name)

    groups.append(group)

for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group
        Key([mod], i.name, lazy.group[i.name].toscreen()),

        # mod1 + shift + letter of group = switch to & move focused window to group
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True)),
        # Or, use below if you prefer not to switch to that group.
        # # mod1 + shift + letter of group = move focused window to group
        Key([mod, "control"], i.name, lazy.window.togroup(i.name)),
    ])

layout_theme = {
        'border_focus':  color.common_accent,
        'border_normal': color.ui_panel_border,
        'border_width':  2,
        'margin':        14,
}

layouts = [
    layout.MonadTall(ratio=.5, **layout_theme),
    layout.Max(**layout_theme),
    layout.Stack(num_stacks=2, **layout_theme),
    # Try more layouts by unleashing below layouts.
    layout.Bsp(**layout_theme),
    # layout.Columns(),
    # layout.Matrix(),
    # layout.MonadWide(),
    layout.RatioTile(**layout_theme),
    # layout.Tile(),
    layout.TreeTab(**layout_theme),
    # layout.VerticalTile(),
    layout.Zoomy(**layout_theme),
]

floating_layout = layout.Floating()

def get_monitors():
    try:
        display = xdisplay.Display()
        screen = display.screen()
        resources = screen.root.xrandr_get_screen_resources()
        monitors = []

        for output in resources.outputs:
            monitor = display.xrandr_get_output_info(output, resources.config_timestamp)
            preferred = False
            if hasattr(monitor, "preferred"):
                preferred = monitor.preferred
            elif hasattr(monitor, "num_preferred"):
                preferred = monitor.num_preferred
            if preferred:
                monitors.append(monitor)
    except Exception as e:
        logger.warn("Exception in get_monitors(): \n%s", e)
        # always return at least one monitor
        return [1]

    return monitors

widget_defaults = dict(
    font='Mononoki Nerd Font',
    fontsize=18,
    padding=3,
)
extension_defaults = widget_defaults.copy()

spacer_length = 15
screens = []
logger.info("Hello Logging!")
for monitor in get_monitors():
    logger.info("monitor: %s", monitor)
    screens.append(
        Screen(
            bottom=bar.Bar(
                [
                    widget.Spacer(length=spacer_length),
                    
                    widget.GroupBox(
                        active=color.ui_selection_fg,
                        inactive=color.common_ui,
                        block_highlight_text_color=color.ui_selection_fg,
                        this_current_screen_border=color.ui_selection_bg,
                        this_screen_border=color.ui_selection_inactive,
                        other_current_screen_border=color.common_bg,
                        other_screen_border=color.common_bg,
                        highlight_method='block',
                        disable_drag=True,
                        rounded=False,
                    ),
                    widget.Spacer(length=spacer_length),

                    widget.CurrentLayout(),
                    widget.Spacer(length=spacer_length),
                    
                    widget.WindowName(),
                    widget.Spacer(length=spacer_length),
                    
                    widget.Prompt(),
                    widget.Spacer(length=spacer_length),
                    #widget.TextBox("default config", name="default"),
                    #widget.Clock(format='%Y-%m-%d %a %I:%M %p'),
                    
                    widget.Clock(format='%R  %A, %d %b %Y'),
                    widget.Spacer(length=spacer_length),
                    
                    widget.QuickExit(),
                    widget.Spacer(length=spacer_length),
                    
                    widget.Systray(padding=8),
                    widget.Spacer(length=spacer_length),

                    widget.Battery(
                        discharge_char='Batt:', 
                        charge_char='Acc:', 
                        low_foreground=color.error,
                    ),
                    widget.Spacer(length=spacer_length),                   
                ],
                36,
                background=color.common_bg,
            ),
        ),
    )

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = True
cursor_warp = True
floating_layout = layout.Floating(float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        {'wmclass': 'confirm'},
        {'wmclass': 'dialog'},
        {'wmclass': 'download'},
        {'wmclass': 'error'},
        {'wmclass': 'file_progress'},
        {'wmclass': 'notification'},
        {'wmclass': 'splash'},
        {'wmclass': 'toolbar'},
        {'wmclass': 'confirmreset'},  # gitk
        {'wmclass': 'makebranch'},  # gitk
        {'wmclass': 'maketag'},  # gitk
        {'wmclass': 'ssh-askpass'},  # ssh-askpass
        {'wname': 'branchdialog'},  # gitk
        {'wname': 'pinentry'},  # GPG key password entry
    ],
    **layout_theme
)
auto_fullscreen = True
focus_on_window_activation = "smart"

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"

