module Paperclip
	class AudioProcessor < Processor
		attr_accessor  :whiny

		    def initialize(file, options = {}, attachment = nil)
		      super
	          @file  = file
	          @current_format = File.extname(@file.path)
	          @format = options[:format]
	          @basename = File.basename(@file.path, @current_format)
		      @whiny = options[:whiny].nil? ? true : options[:whiny]
		      @format_options = {}
		      @format_options[:ogg] = "-vn -acodec vorbis -strict -2"
		    end

		    def make
		      src = @file
		      dst = Tempfile.new([@basename, @format ? ".#{@format}" : ''])
		      dst.binmode

		     
		      begin
		      	parameters = []
		        parameters << "-i :source"
		        parameters << @format_options[@format.to_sym]
		        parameters << "-y :dest"
		        parameters = parameters.flatten.compact.join(" ").strip.squeeze(" ")
		        Paperclip.log("**** #{parameters}")

		        success = Paperclip.run('ffmpeg', parameters, :source => src.path, :dest => dst.path)
		      rescue Cocaine::ExitStatusError => e
		        raise Paperclip::Error, "There was an error processing audio for #{@basename}" if whiny
		      end
		      dst
		    end
	end
end