require "spec_helper"
include ActiveSupport::Inflector

describe KatanaStamp do

  DEFAULT_STAMP = '# (c) Copyright 2012 Katana Code Ltd. All Rights Reserved'

  before(:each) do
    copy_template_files
  end
  
  after(:all) do
    copy_template_files
  end

  let(:file_content) { File.read("app/models/test_model_one.rb")  }
  
  context "printing to console" do
    
    it "explains file has been stamped if not already" do
      @orig_stdout = $stdout
      $stdout = StringIO.new
      run_with_options
      $stdout.rewind
      $stdout.string.chomp.should include("app/models/test_model_one.rb stamped!")
      $stdout = @orig_stdout    
    end
    
    it "explains file has already been if stamped with the same name" do
      @orig_stdout = $stdout
      $stdout = StringIO.new
      run_with_options
      run_with_options      
      $stdout.rewind
      $stdout.string.chomp.should include("app/models/test_model_one.rb already stamped!")
      $stdout = @orig_stdout    
    end
    
    it "warns file has already been if stamped with another name" do
      @orig_stderr = $stderr
      $stderr = StringIO.new
      run_with_options
      run_with_options(owner: "gavin")      
      $stderr.rewind
      $stderr.string.chomp.should include("app/models/test_model_one.rb stamped by another owner!")
      $stderr = @orig_stderr    
    end
    
  end
  
  

  context "by default" do

    before do
      run_with_options
    end

    it 'adds the copyright notice to the bottom of the file if not present' do
      file_content.should include(DEFAULT_STAMP)
    end

    it "doesn't add the copyright notice again if it's already there" do
      run_with_options # again
      file_content.scan(DEFAULT_STAMP).count.should eql(1)
    end

    it "doesn't modify non-ruby files" do
      File.read('app/models/README').should_not include("# (c) Copyright")
    end

  end

  context 'with owner option' do

    it 'uses the owner passed' do
      run_with_options(owner: 'Bodacious')
      file_content.should include('Bodacious')
    end

  end

  context 'with year option' do

    it 'uses the year passed' do
      run_with_options(year: '1999')
      file_content.should include('1999')
    end

  end  

  context 'with include-dirs option' do

    let(:path) { 'spec/support/test_dummy_file.rb' }
    
    before do
      run_with_options(include_paths: [path])
    end
    
    it "also stamps paths listed in include_paths" do  
      File.read(path).should include(DEFAULT_STAMP)
    end

  end

  context 'with exclude-dirs option' do

    let(:path) { 'app/models/test_model_two.rb' }

    before do
      run_with_options(exclude_paths: [path])
    end

    it "doesn't stamp paths listed in exclude_paths" do
      File.read(path).should_not include(DEFAULT_STAMP)
    end

    it "it still stamps files that don't match the pattern" do
      file_content.should include(DEFAULT_STAMP)
    end

  end

  context 'with message option' do
    
    let(:message) { "Released under the Bodacious license" }
    
    before do
      run_with_options(message: message)
    end

    it "overwrites the entire message" do
      file_content.should include(message)
      file_content.should_not include(DEFAULT_STAMP)      
    end

  end

end