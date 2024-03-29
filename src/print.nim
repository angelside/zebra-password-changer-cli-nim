from config import conf
import std/[strformat, terminal]


# Print the app title
proc app_title*() =
    styledEcho styleBright, fgMagenta, conf.app_title, "\n", resetStyle


# Prints version and exit
proc version*() =
    #[
        VERSION
            zebra-password-changer v0.1.0 | linux-amd64 nim-v1.6.6
    ]#
    styledEcho styleBright, fgBlue, "VERSION", resetStyle
    styledEcho fgDefault, "    ", conf.app_file_name, " v", conf.app_version, " | ", hostOS, "-", hostCPU ," nim-v", NimVersion, resetStyle

    quit()


# Print cli help and exit
proc help*() =
    #[
        USAGE
            zebra-password-changer <IP_ADDRESS> <PASSWORD>
            zebra-password-changer  [command]

        COMMANDS
            help     show CLI help
            version  show CLI version

        DESCRIPTION
            CLI tool that allows changing Zebra printer's password
    ]#
    styledEcho styleBright, fgCyan, "USAGE", resetStyle
    styledEcho fgDefault, fmt"    {conf.app_file_name} <IP_ADDRESS> <PASSWORD>", resetStyle
    styledEcho fgDefault, fmt"    {conf.app_file_name}  [command]", resetStyle
    echo ""

    styledEcho styleBright, fgCyan, "COMMANDS", resetStyle
    styledEcho fgDefault, "    help", resetStyle, fgWhite, "     show CLI help", resetStyle
    styledEcho fgDefault, "    version", resetStyle, fgWhite, "  show CLI version", resetStyle
    echo ""

    styledEcho styleBright, fgCyan, "DESCRIPTION", resetStyle
    styledEcho fgDefault, "    ", conf.app_description, resetStyle

    quit()

# Usege help message
proc help_short*() =
    #[
        [ERROR] Wrong command or argument!

        use 'zebra-password-changer help' for help
    ]#
    let help_text = fmt"use '{conf.app_file_name} help' for help"
    styledEcho "\n",fgWhite, help_text, resetStyle
