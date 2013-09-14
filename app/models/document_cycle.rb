class DocumentCycle
  attr_accessor :document

  def initialize(document)
    @document = document
  end


	def create
		if self.document.save
		  push_to_firebase
		  notify_users
		end
	end

	def update(params)
		if self.document.update(params)
		  push_to_firebase
		  notify_users
		end
	end

	private

	def push_to_firebase
	  previous_changes_count = Firebase.get("changes_count")
	  if previous_changes_count.success? 
	    push_response = Firebase.push("changes", { :name => @document.name, :updated_at => @document.updated_at, :changed_by => User.find(@document.changed_by).name })
	    set_response = Firebase.set("changes_count", previous_changes_count.raw_body.to_i + 1) if push_response.success?
	  end
	  true
	end

	def notify_users
	  @document.project.team.each do |user|
	    begin
	      NotificationMailer.changes_notification(@document, user).deliver
	    rescue Exception => ex
	      Rails.logger.error("Error when sending email to #{user.email} for document #{id}: #{ex}")
	    end
	  end

	  true
	end

end