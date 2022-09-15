from config import conf
import std/[strformat, terminal]

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
            CLI tool that allows changing Zebra printers password
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
    styledEcho fgDefault, "    CLI tool that allows changing Zebra printers password", resetStyle

    quit()
