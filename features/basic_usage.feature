# This file is part of autocli
#
# Copyright (C) 2020 Rafael Guterres Jeffman
#
# f/π is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Foobar is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Foobar.  If not, see <https://www.gnu.org/licenses/>.

@stdout @stderr
Feature: Simple application with arguments.

Scenario: Application with one argument.
Given the CLI description
    """
    ---
    program: greeting
    description: A greeting application.
    version: 1.0
    handler: greeting.hello
    arguments:
      - name: someone
        description: Someone to greet.
        required: yes
    """
    And a function "greeting.hello" with an argument "someone" that prints "Hello, {someone}!"
When the application is executed with [World]
Then the output is
    """
    Hello, World!
    """
    And the exit code is 0

Scenario: Application with one argument, run without arguments.
Given the CLI description
    """
    ---
    program: greeting
    description: A greeting application.
    version: 1.0
    handler: greeting.hello
    arguments:
      - name: someone
        description: Someone to greet.
        required: yes
    """
When the application is executed without prameters
Then the error output is
    """
    usage: greeting [-h] [--version] someone
    greeting: error: the following arguments are required: someone
    """
    And the exit code is not zero

Scenario: Application version.
Given the CLI description
    """
    ---
    program: greeting
    description: A greeting application.
    version: 1.0
    """
When the application is executed with [--version]
Then the output is
    """
    greeting 1.0
    """

Scenario: Help for application with one argument.
Given the CLI description
    """
    ---
    program: greeting
    description: A greeting application.
    version: 1.0
    handler: greeting.hello
    arguments:
      - name: someone
        description: Someone to greet.
        required: yes
    """
When the application is executed with [--help]
Then the output is
    """
    usage: greeting [-h] [--version] someone

    A greeting application.

    positional arguments:
      someone     Someone to greet.

    optional arguments:
      -h, --help  show this help message and exit
      --version   display program version
    """
    And the exit code is 0