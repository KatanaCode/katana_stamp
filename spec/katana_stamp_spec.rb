require "spec_helper"
include ActiveSupport::Inflector

describe KatanaStamp do

  DEFAULT_STAMP = '# (c) Copyright 2012 Katana Code Ltd. All Rights Reserved'

  before(:each) do
    clear_files
  end

  let(:file_content) { File.read("app/models/test_model_one.rb")  }

  context "by default" do

    before do
      KatanaStamp.run!      
    end

    it 'adds the copyright notice to the bottom of the file if not present' do
      file_content.should include(DEFAULT_STAMP)
    end

    it "doesn't add the copyright notice again if it's already there" do
      KatanaStamp.run! # again
      file_content.scan(DEFAULT_STAMP).count.should eql(1)
    end

    it "doesn't modify non-ruby files" do
      File.read('app/models/README').should_not include("# (c) Copyright")
    end

  end

  context 'with owner option' do

    it 'uses the owner passed' do
      KatanaStamp.run!(owner: 'Bodacious')
      file_content.should include('Bodacious')
    end

  end

  context 'with year option' do

    it 'uses the year passed' do
      KatanaStamp.run!(year: '1999')
      file_content.should include('1999')
    end

  end  

  context 'with include-dirs option' do

    it "also stamps paths listed in include_paths" do
      path = 'spec/support/test_dummy_file.rb'
      KatanaStamp.run!(include_paths: [path])
      File.read(path).should include(DEFAULT_STAMP)
    end

  end

  context 'with exclude-dirs option' do

    let(:path) { 'app/models/test_model_two.rb' }

    before do
      KatanaStamp.run!(exclude_paths: [path])
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
      KatanaStamp.run!(message: message)
    end

    it "overwrites the entire message" do
      file_content.should include(message)
      file_content.should_not include(DEFAULT_STAMP)      
    end

  end

end