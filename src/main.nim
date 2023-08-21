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
from print import nil
from config import conf


# Error message
proc error_msg(msg: string, exit = false) =
    # [ERROR] Failed to connect: No route to host
    styledEcho fgRed, "[ERROR]", resetStyle, " ", msg
    if exit:
        quit()


proc check_arguments() =
    # No any argument ->  Show help
    if paramCount() == 0:
        #error_msg("No operation specified!")
        print.help()

    # Only 1 argument, check if it's "help" or "version"
    if paramCount() == 1:
        # Argument is "help" -> show help & exit
        if paramStr(1) == "help":
            print.help()

        # Argument is "version" -> show version & exit
        if paramStr(1) == "version":
            print.version()

    # Not have 2 argument -> error & exit
    if paramCount() != 2:
        error_msg("Wrong command or argument!")
        print.help_short()
        quit()


proc check_ip_and_password(input_ip_address: string, input_password: string) =
    let valid_ip_address = validate.ip_address(input_ip_address)
    let valid_password   = validate.password(input_password, conf.password_total_char)

    let invalid_ip_msg       = "IP address is invalid!"
    let invalid_password_msg = fmt"Password is invalid! Please enter a {conf.password_total_char} digit number."

    if not valid_ip_address and not valid_password:
        error_msg(invalid_ip_msg)
        error_msg(invalid_password_msg)
        print.help_short()
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
        port       = conf.printer_port,
        timeout    = conf.socket_timeout,
        zpl_code   = fmt_zpl_code
    )


when isMainModule:
    # Print the app title
    print.app_title()

    main()
