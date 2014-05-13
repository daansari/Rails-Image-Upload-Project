class Project < ActiveRecord::Base

	validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false

  has_attached_file :attachment, 
                    :styles => { :medium => "300x300>"},
                    path: "#{Rails.env}/my_model/:id/my_file.:extension"


# ,
                    # te:url => "/system/projects/:id/:style/:basename.:extension",
                    # :path => ":rails_root/public/system/projects/:id/:style/:basename.:extension"
  
  # validates_attachment_presence :attachment
  # Validate attachment size
  # validates_attachment_size :attachment, :less_than => 5.megabytes
  # Validate content type
  # validates_attachment_content_type :attachment, :content_type => [/\Aimage/, /\Amovie/]

  do_not_validate_attachment_file_type :attachment

  	attr_accessor :remove_attachment
  	attr_accessor :image_data
    attr_accessor :timestamp_str

  	before_save :perform_attachment_removal
  	before_save :decode_image_data
    before_save :format_and_save_timestamp

  	def perform_attachment_removal
  		if remove_attachment == '1' && !attachment.dirty?
  			self.attachment = nil
  		end
  	end

  	def decode_image_data
  		# If image_data is present, it means that we were sent an image over
  		# JSON and it needs to be decoded.  After decoding, the image is processed
  		# normally via Paperclip.
      # logger.debug "ENTERED LOGGER"
  		if self.image_data.present?
        last_obj = Project.last
        new_id = 0
        if last_obj
          new_id = last_obj.id
        end
        # logger.debug "ENTERED IMAGE DATA LOGGER"
        # logger.debug self.image_data
  			data = StringIO.new(Base64.decode64(self.image_data))
  			data.class.class_eval {attr_accessor :original_filename, :content_type}
  			data.original_filename = "#{new_id}_#{self.name}" + ".png"
  			data.content_type = "image/png"
  		  self.attachment = data
  	  end
    end

    def format_and_save_timestamp
      # logger.debug "ENTERED LOGGER"
      if self.timestamp_str.present?
        # logger.debug self.timestamp_str
        self.p_timestamp = Time.zone.parse(self.timestamp_str)
      end
    end

    def attachment_medium_url
        attachment.url(:medium)
    end


    def created_time
        # Time.zone.parse(created_at.strftime("%Y-%m-%d %H:%M:%S"))
        created_at.strftime("%Y-%m-%d %H:%M:%S")
    end

    def updated_time
        # Time.zone.parse(created_at.strftime("%Y-%m-%d %H:%M:%S"))
        updated_at.strftime("%Y-%m-%d %H:%M:%S")
    end

    def p_formatted_timestamp
        if p_timestamp
          p_timestamp.strftime("%Y-%m-%d %H:%M:%S")
        end
    end
end
