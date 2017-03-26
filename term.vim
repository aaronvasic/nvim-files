" Terminal Settings
if ! has("gui_running")
        "Unpatched ST Compatibility
        "if $TERM == "st-256color" || $TERM == "st"
        "        " backspace with 
        "        set t_kb=
        "        " delete with 
        "        set t_kD=
        "endif
        " clear termcap mode
        set t_ti= t_te=

"        if $TERM == "nebuchadnezzar"
"                set t_kD=
"        end
endif
