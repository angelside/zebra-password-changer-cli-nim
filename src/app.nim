## zebra-password-changer-cli-nim
## CLI tool that allows changing Zebra printers password.
##
## Usage: binary_file_name <IP_ADDRESS> <PASSWORD>
##                                      (4 digit, only numbers)
##
## :Author: angelside
## :Copyright: 2022
##
import std/[strformat, terminal]
import net
import os

from validate import nil


let config = (
    app_title     : "== Zebra password changer ==",
    app_version   : "0.1.0",
    app_file_name : getAppFilename().extractFilename(), # Directly accessing the app name
    app_description: "CLI tool that allows changing Zebra printers password"
    printer_port  : 9100,
    socket_timeout: 3000,
    password_total_char: 4
)


# Prints version and exit
proc print_version() =
    #[
        VERSION
            zebra-password-changer v0.1.0 | linux-amd64 nim-v1.6.6
    ]#
    styledEcho styleBright, fgBlue, "VERSION", resetStyle
    styledEcho fgDefault, "    ", config.app_file_name, " v", config.app_version, " | ", hostOS, "-", hostCPU ," nim-v", NimVersion, resetStyle

    quit()


# Print cli help and exit
proc print_help() =
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
    styledEcho fgDefault, fmt"    {config.app_file_name} <IP_ADDRESS> <PASSWORD>", resetStyle
    styledEcho fgDefault, fmt"    {config.app_file_name}  [command]", resetStyle
    echo ""

    styledEcho styleBright, fgCyan, "COMMANDS", resetStyle
    styledEcho fgDefault, "    help", resetStyle, fgWhite, "     show CLI help", resetStyle
    styledEcho fgDefault, "    version", resetStyle, fgWhite, "  show CLI version", resetStyle
    echo ""

    styledEcho styleBright, fgCyan, "DESCRIPTION", resetStyle
    styledEcho fgDefault, "", resetStyle

    quit()


# Error message
proc error_msg(msg: string, exit = false) =
    # [ERROR] Failed to connect: No route to host
    styledEcho fgRed, "[ERROR]", resetStyle, " ", msg
    if exit:
        quit()


# Usege help message
proc usage_help_msg() =
    #[
        [ERROR] Wrong command or argument!

        use 'zebra-password-changer help' for help
    ]#
    let help_text = fmt"use '{config.app_file_name} help' for help"
    styledEcho "\n",fgWhite, help_text, resetStyle


proc check_arguments() =
    # No any argument ->  Show help
    if paramCount() == 0:
        #error_msg("No operation specified!")
        print_help()

    # Get all the arguments by index
    for paramIndex in 1 .. paramCount():
        # Argument is "help" -> show help & exit
        if paramStr(1) == "help":
            print_help()

        # Argument is "version" -> show version & exit
        if paramStr(1) == "version":
            print_version()

        # Not have 2 argument -> error & exit
        if paramCount() != 2:
            error_msg("Wrong command or argument!")
            usage_help_msg()
            quit()


proc check_ip_and_password(input_ip_address: string, input_password: string) =
    let valid_ip_address = validate.ip_address(input_ip_address)
    let valid_password   = validate.password(input_password, config.password_total_char)

    let invalid_ip_msg       = "IP adress is invalid!"
    let invalid_password_msg = fmt"Password is invalid! Please enter a {config.password_total_char} digit number."

    if not valid_ip_address and not valid_password:
        error_msg(invalid_ip_msg)
        error_msg(invalid_password_msg)
        usage_help_msg()
        quit()
    elif not valid_ip_address:
        error_msg(invalid_ip_msg)
        quit()
    elif not valid_password:
        error_msg(invalid_password_msg)
        quit()


proc socket_request(ip_address: string, port: int, timeout: int, zpl_code: string) =
    var socket = newSocket(AF_INET, SOCK_STREAM, IPPROTO_TCP)

    # Attempt to connect
    try:
        socket.connect(ip_address, Port(port), timeout = timeout)
        socket.send(zpl_code)
        styledEcho fgGreen, "[OK] ", fgBlue, ip_address, resetStyle," : password has been changed."
        defer: socket.close()
    except OSError as e:
        error_msg(fmt"Failed to connect: {e.msg}")
    finally:
        socket.close()


proc main() =
    # Check arguments
    check_arguments()

    ## Continue only if argument check is passed

    # Ip address & password validation
    let input_ip_address = paramStr(1)
    let input_password   = paramStr(2)
    check_ip_and_password(input_ip_address, input_password)

    ## Continue only if ip address and password both are valid

    # Prepare the password change zpl code from input_password
    var fmt_zpl_code = fmt"^XA^KP{input_password}^JUS^XZ"

    # Send the password change request
    socket_request(
        ip_address = input_ip_address,
        port       = config.printer_port,
        timeout    = config.socket_timeout,
        zpl_code   = fmt_zpl_code
    )

# Print the app title
    proc print_app_title() = 
    styledEcho styleBright, fgMagenta, config.app_title, "\n", resetStyle

when isMainModule:
    
    main()
    print_app_title()

