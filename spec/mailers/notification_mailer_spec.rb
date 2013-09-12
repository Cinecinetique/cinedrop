require "spec_helper"

describe NotificationMailer, "When a document has changed and email notification is called" do
	before(:each) do
		user = User.new
	  	@document = Document.new
	  	@document.id = 68
  	  	@document.name = "The continuity log"
  	  	@document.updated_at = Time.now
	  	user.should_receive(:email).and_return("a@b.com")
  	  	@creator = User.new
	  	@creator.name = "The creator"
	  	@document.should_receive(:changed_by).twice.and_return(234) # twice, because there are two views (html and text)
	  	User.should_receive(:find).with(234).twice.and_return(@creator)
		@mail  = NotificationMailer.changes_notification(@document, user)
	end

  it "should build an email with correct headers" do
  	@mail.to.should == ["a@b.com"]
  	@mail.from.should == ["do-not-reply@cinecinetique.com"]
  	@mail.subject.should == "A document has changed"
  end

  it "should have document name" do
  	@mail.body.encoded.should match(@document.name)
  end

  it "should have creator name" do
  	@mail.body.encoded.should match(@creator.name)
  end

  it "should have changed date" do
	@mail.body.encoded.should match(@document.updated_at.to_s)
  end

  it "should have a link to the document" do
  		@mail.body.encoded.should match("#{default_url_options[:host]}/#{@document.id}")
  end
end
