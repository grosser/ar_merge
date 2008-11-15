GOALS
=====
 - merge 2 AR Objects into one


INSTALL
=======

    script/plugin install git://github.com/grosser/ar_merge.git

USAGE
=====
 - `user.merge!(other,:attributes=>user.attributes.keys,:associations=>%w[movies friends])`


    User < ActiveRecord::Base
      def merge!(other)
        super(other,:attributes=>%w[email website])
      end
    end

AUTHOR
======
  Michael Grosser  
  grosser dot michael ät gmail dot com  
