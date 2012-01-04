module Nosy

  class Hunter

    def hunt
      if RUBY_PLATFORM =~ /darwin/
        Dir[File.join("#{Dir.home}/Library/Application Support/MobileSync/Backup", "*")].select{|file| File.ftype(file) == "directory"}.each do |folder|
          if Nosy.can_parse?(folder+"/3d0d7e5fb2ce288813306e4d4636395e047a3d28")
            return "#{folder}/3d0d7e5fb2ce288813306e4d4636395e047a3d28"
          end
        end
      end
  
    end
  end
end