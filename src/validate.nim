## Validation lib, validates ip address and password
##
## Usage:
##   Import:
##      from validate import nil
##   Use:
##     let valid_ip_address = validate.ip_address(input_ip_address)
##     let valid_password   = validate.password(input_password, total_char = 4)
##
import std/[strutils, sequtils]
import net

# Ip adress validation
proc ip_address*(ip: string) : bool =
    let valid_ip = isIpAddress(ip)
    if valid_ip == false:
        # invalid ip adress
        return false
    else:
        return true


# Password validation
proc password*(password: string, total_char: int) : bool =
    # total_char (from config) and only numbers
    if password.len != total_char or password.allIt(it.isDigit()) == false:
        # invalid password
        return false
    else:
        return true
