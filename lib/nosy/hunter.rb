require 'fileutils'

module Nosy

	class Hunter

		def hunt
			if RUBY_PLATFORM =~ /darwin/
				FileUtils.cp "#{Dir.home}/Library/Application Support/MobileSync/Backup/55e67384ae82dd8a317f29585e1d7b5884e43107/3d0d7e5fb2ce288813306e4d4636395e047a3d28", "#{FileUtils.pwd}/texts.sqlite"
				"#{FileUtils.pwd}/texts.sqlite"
			end
		end
	
	end

end