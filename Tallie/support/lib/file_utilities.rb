#TODO-T1: Review

module FileUtilities
  def self.require_files_in_dir(files)
    Dir[files].each do |file|
      file = file.gsub('.rb', '')
      require file
      puts "Require file: #{file}"
    end
  end

  def self.require_page_class(test_dir = nil)
    require_files_in_dir("#{pages_directory_path(test_dir)}/*.rb")
  end

  def self.test_working_dir(test_dir = nil)
      working_dir = Dir.pwd
      if test_dir.nil?
        return working_dir
      else
        working_dir.gsub!(File.basename(working_dir), '')
        return File.join(working_dir, test_dir)
      end
  end

  def self.pages_directory_path(test_dir = nil)
      File.join(test_working_dir(test_dir), 'pages')
  end

  def self.page_helpers_directory_path(test_working_dir = nil)
    File.join(pages_directory_path(test_working_dir), 'page_helpers')
  end

  def self.step_definitions_directory_path(test_dir = nil)
    File.join(test_working_dir(test_dir), 'features/step_definitions')
  end

end