# Plugin for Foswiki - The Free and Open Source Wiki, http://foswiki.org/
#
# Copyright (C) 2007 - 2011 Andrew Jones, http://andrew-jones.com
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details, published at
# http://www.gnu.org/copyleft/gpl.html

package Foswiki::Plugins::HostnamePlugin;

use strict;
use warnings;

our $VERSION           = '$Rev$';
our $RELEASE           = '1.1';
our $SHORTDESCRIPTION  = 'Displays the hostname of the server serving Foswiki.';
our $NO_PREFS_IN_TOPIC = 1;
our $pluginName        = 'HostnamePlugin';

sub initPlugin {
    Foswiki::Func::registerTagHandler( 'HOSTNAME', \&_handleTag );

    # Plugin correctly initialized
    return 1;
}

sub _handleTag {

    #my($session, $params, $theTopic, $theWeb) = @_;

    eval 'use Sys::Hostname';
    if ( !$@ ) {
        return hostname();
    }
    else {
        Foswiki::Func::writeWarning($@);
        return
"<span class='foswikiAlert'>$pluginName error: Sys::Hostname not found in \@INC. Please contact %WIKIWEBMASTER%.</span>";
    }
}

1;
