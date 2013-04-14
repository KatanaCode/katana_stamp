# Katana Code's Copyright Stamper

This gem is used internally by Katana Code. Feel free to fork it and modify for your 
own organisation.

Read [the documentation](http://rubydoc.info/gems/katana_stamp) for more information on what's going on under the hood.

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
    
Will stamp:

    `# (c) Copyright 1999 Katana Code Ltd. All Rights Reserved.  
 
### --owner (-o)

Change the owner of the Copyright
e.g.

    $ katana_stamp -o "Ace Rimmer!"

Will stamp:

    `# (c) Copyright 2012 Ace Rimmer. All Rights Reserved.`
 
### --message (-m)

Overwrite the entire message for the stamp.
e.g.
    
    $ katana_stamp -m "2011 - All rights reserved"

Will stamp:

    `# (c) 2011 - All rights reserved`

### --comment-delimiter (-c)
    
Change the comment delimiter used (for different file types)
e.g.

    $ katana_stamp -c "//"

Will stamp:

    `// (c) Copyright 2012 Katana Code Ltd. All Rights Reserved.`
    
## Known Issues

At the moment there's no way to reverse this... make sure you commit any changes before you
run this!

## About Katana Code

Katana Code are [iPhone app and Ruby on Rails Developers in Edinburgh, Scotland](http://katanacode.com/ "Katana Code").
