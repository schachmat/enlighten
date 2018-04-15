enlighten
=========

Synopsis
--------

**enlighten** [ help | list | [+-]<#>[%] ]

Description
-----------

:program:`enlighten` is a command-line tool to manage sysfs-exposed backlights

Options
-------

<no argument>
    Display current brightness information (formatted: ``cur / max (perc)``)

help
    Print help summary and exit.

list
    Print a list of known backlight device names.

``[+-]<#>[%]``
    Adjust the current brightness to ``#``.
    If a sign (``+`` or ``-``) is specified, adjust relative to the current brightness.
    If ``%`` is specifiec, treat ``#`` as a percent of the maximum.

Environment Variables
---------------------

:program:`enlighten` recognizes three environment variables for runtime configuration:

BACKLIGHT_DEVICE
    Holds the name of the device to query/adjust.

BACKLIGHT_THRESHOLD_MIN
    Holds a value of the form ``<#>[%]`` that represents a saturating minimum brightness.
    If the user-specified value would change the backlight's brightness to be less than this minimum, the brightness will be set to this minimum instead.
    If not specified, defaults to ``0``.

BACKLIGHT_THRESHOLD_MAX
    Holds a value of the form ``<#>[%]`` that represents a saturating maximum brightness.
    If the user-specified value would change the backlight's brightness to be greater than this maximum, the brightness will be set to this maximum instead.
    If not specified, defaults to "100%".

Examples
--------

enlighten h
    print the help summary.

enlighten l
    print a list of known backlight device names.

enlighten
    print the current brightness information.

enlighten +25%
    increase the brightness by 25 percent of the maximum.

enlighten 75%
    set the brightness to 75 percent of the maximum.

Bugs
----

Report bugs for enlighten to https://github.com/HalosGhost/enlighten/issues