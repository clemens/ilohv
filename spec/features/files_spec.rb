require 'spec_helper'

feature "Files" do
  # TODO Add functionality to add files to root
  # scenario "Uploading a file" do
  #   visit Ilohv::Engine.config.url_root

  #   click_on 'new-file-button'

  #   fill_in 'file_name', with: 'A File'
  #   attach_file 'file_file', attributes_for(:file)[:file].path
  #   click_on 'save-button'

  #   expect(page).to have_content 'A File'
  # end

  scenario "Uploading a file to a directory" do
    directory = create(:directory, name: 'A Directory')

    visit "#{Ilohv::Engine.config.url_root}/#{directory.full_path}"

    click_on 'new-file-button'

    fill_in 'file_name', with: 'A File'
    attach_file 'file_file', attributes_for(:file)[:file].path
    click_on 'save-button'

    expect(page).to have_content 'A File'
    expect(directory.files.pluck(:name)).to eq ['A File']
  end

  scenario "Renaming a file in a directory" do
    directory = create(:directory, name: 'A Directory')
    file = create(:file, parent: directory, name: 'A File')

    visit "#{Ilohv::Engine.config.url_root}/#{directory.full_path}"

    click_on "edit-file-#{file.id}"

    fill_in 'file_name', with: 'A Renamed File'
    click_on 'save-button'

    expect(page).to have_content 'A Renamed File'
    expect(page).to_not have_content 'A File'
  end

  scenario "Deleting a file from a directory" do
    directory = create(:directory, name: 'A Directory')
    file = create(:file, parent: directory, name: 'A File')

    visit "#{Ilohv::Engine.config.url_root}/#{directory.full_path}"

    click_on "delete-file-#{file.id}"

    expect(page).to_not have_content 'A File'

    expect(Ilohv::File.count).to eq 0
  end
end
