require File.expand_path("spec_helper", File.dirname(__FILE__))

describe "AR_Merge" do
  before do
    @user = User.create!(:name=>'x')
    @u2 = User.create!(:name=>'y')
  end

  describe :removal do
    it "removes the merged user" do
      @user.merge!(@u2)
      lambda{@u2.reload}.should raise_error(ActiveRecord::RecordNotFound)
    end

    it "saves the merging user" do
      @user.expects(:save!)
      @user.merge!(@u2)
    end
  end

  describe :attributes do
    it "merges and overtakes attributes" do
      @user.name = ''
      @user.merge!(@u2,:attributes=>['name'])
      @user.name.should == 'y'
    end

    it "does not overtake attributes when current is not blank" do
      @user.merge!(@u2,:attributes=>['name'])
      @user.name.should == 'x'
    end
  end

  describe :associations do
    before do
      Movie.delete_all
      @user.movies << Movie.new
      @user.save!
      @user.movies.size.should == Movie.count
    end

    it "overtakes asociated objects" do
      @u2.merge!(@user,:associations=>[:movies])
      @u2.reload.should have(Movie.count).movies
    end

    it "does not create new objects" do
      lambda{@u2.merge!(@user,:associations=>['movies'])}.should_not change(Movie,:count)
    end
  end

  it "does no merge with new" do
    lambda{@user.merge!(User.new)}.should raise_error
  end

  it "does no merge with self" do
    lambda{@user.merge!(User.find(@user.id))}.should raise_error
  end
end