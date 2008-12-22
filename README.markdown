PROBLEM
=======
 - Merging 2 records is often needed
 - Merging has many hidden & problematic aspects


SOLUTION
==========
ActiveRecord extension that introduces a simple merging API.

 - Specify associations/attributes you want to merge
 - Protects from self-merges
 - Keeps counters valid
 - Removes merged record


INSTALL
=======

Rails plugin

    script/plugin install git://github.com/grosser/ar_merge.git

OR Gem

    sudo gem install grosser-ar_merge
    #require ar_merge after activerecord


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

Merge duplicates

    #merge all new users, that have the same email
    User.merge_duplicates!(User.find_all_by_status('new')) , :compare=>:email)

AUTHOR
======
  Michael Grosser  
  grosser dot michael ät gmail dot com  
