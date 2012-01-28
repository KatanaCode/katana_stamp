# Katana Code's Copyright Stamper

## Usage: 

    $ katana_stamp

adds **(c) Copyright 2012 Katana Code Ltd. All Rights Reserved.** to the end of every Ruby file under app/ and lib/.

See options below for configuration

## Options

###  --include-dirs (-i)

Include these dir patterns in stamp list
e.g.    
     $ katana_stamp -i vendor/**/*.rb # will also stamp files matching vendor/**/*.rb
     
### --exclude-dirs (-x)

Don't include these dir patterns in stamp list
e.g.
   
   $ katana_stamp -x app/controllers/application_controller.rb # will not stamp files matching app/controllers/application_controller.rb

### --year (-y)

Change the year of the Copyright
e.g.

    $ katana_stamp -y 1999

 
### --owner (-o)

Change the owner of the Copyright
e.g.

    $ katana_stamp -o "Ace Rimmer!"

 
### --message (-m)

Overwrite the entire message for the stamp.
e.g.
    
    $ katana_stamp -m "Released under the MIT license"
    
## Known Issues

At the moment there's no way to reverse this... make sure you commit any changes before you
run this!