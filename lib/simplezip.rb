# frozen_string_literal: true

require 'simplezip/version'
require 'tmpdir'

module Simplezip
  class Error < StandardError; end

  # Class for ZIP! files
  class Zip
    def call(files, name: nil)
      filename = "#{name}.zip" || 'archive.zip'
      tmp_dir = Dir.mktmpdir
      tmp_zip_path = File.join(tmp_dir, filename)

      copy_files_to_tmp_directory(files, tmp_dir)

      `cd #{tmp_dir} && zip #{tmp_zip_path} ./*`

      File.open(tmp_zip_path)
    end

    protected

    def copy_files_to_tmp_directory(files, tmp_dir)
      FileUtils.cp [files], tmp_dir
    end
  end
end
