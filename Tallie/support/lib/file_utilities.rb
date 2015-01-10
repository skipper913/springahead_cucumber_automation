#TODO-T1: Review

module FileUtilities
  def self.require_files_in_dir(dir)
    Dir["#{dir}/*.rb"].each do |file|
      file = file.gsub('.rb', '')
      require File.expand_path(file)
      puts "** file: #{file}"
    end
  end

  def self.pages_dir_absolute_path(page)
    File.join(features_dir_absolute_path(page), '/pages')
  end

  def self.step_definitions_dir_absolute_path(page)
    File.join(features_dir_absolute_path(page), '/step_definitions')
  end

  def self.features_dir_absolute_path(page)
    File.join(File.absolute_path("../#{page}"), 'features')
  end

  def self.page_helpers_dir_absolute_path(page)
    File.join(File.absolute_path("../#{page}"), 'page_helpers')
  end

end