import os

let conf* = (
    app_title       : "== Zebra password changer ==",
    app_description : "CLI tool that allows changing Zebra printers password",
    app_version     : "0.1.0",
    app_file_name   : getAppFilename().extractFilename(), # Directly accessing the app name
    printer_port    : 9100,
    socket_timeout  : 3000,
    password_total_char: 4
)
