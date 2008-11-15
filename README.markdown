GOALS
=====
 - merge 2 AR Objects into one
 - add associations
 - overtake attributes if they are blank on the merging-record


INSTALL
=======

    script/plugin install git://github.com/grosser/ar_merge.git

USAGE
=====
Merge from outside the model:

    user.merge!(other,:attributes=>user.attributes.keys,:associations=>%w[movies friends])`

Merge from inside the model

    User < ActiveRecord::Base
      def merge!(other)
        super(other,:attributes=>%w[email website])
      end
    end

AUTHOR
======
  Michael Grosser  
  grosser dot michael ät gmail dot com  
