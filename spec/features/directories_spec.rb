require 'spec_helper'

feature "Directories" do
  scenario "Viewing the root directory" do
    create(:directory, name: 'A Directory 2')
    create(:directory, name: 'A Directory 1')

    visit Ilohv::Engine.config.url_root

    expect(page).to have_content 'A Directory 1'
    expect(page).to have_content 'A Directory 2'
    expect(page.body.index('A Directory 1') < page.body.index('A Directory 2')).to eq true # directories sorted
  end

  scenario "Viewing a subdirectory" do
    directory = create(:directory, name: 'A Directory')
    create(:directory, parent: directory, name: 'A Subdirectory 2')
    create(:directory, parent: directory, name: 'A Subdirectory 1')
    create(:file, parent: directory, name: 'A File 2')
    create(:file, parent: directory, name: 'A File 1')

    visit "#{Ilohv::Engine.config.url_root}/#{directory.full_path}"

    expect(page).to have_content 'A Subdirectory 1'
    expect(page).to have_content 'A Subdirectory 2'
    expect(page.body.index('A Subdirectory 1') < page.body.index('A Subdirectory 2')).to eq true # directories sorted

    expect(page).to have_content 'A File 1'
    expect(page).to have_content 'A File 2'
    expect(page.body.index('A File 1') < page.body.index('A File 2')).to eq true # files sorted

    expect(page.body.index('A Subdirectory 2') < page.body.index('A File 1')).to eq true # files after directories
  end

  scenario "Creating a directory" do
    visit Ilohv::Engine.config.url_root

    click_on 'new-directory-button'

    fill_in 'directory_name', with: 'A Directory'
    click_on 'save-button'

    expect(page).to have_content 'A Directory'
  end

  scenario "Creating a subdirectory" do
    directory = create(:directory, name: 'A Directory')

    visit "#{Ilohv::Engine.config.url_root}/#{directory.full_path}"

    click_on 'new-directory-button'

    fill_in 'directory_name', with: 'A Subdirectory'
    click_on 'save-button'

    expect(page).to have_content 'A Subdirectory'
    expect(directory.directories.pluck(:name)).to eq ['A Subdirectory']
  end

  scenario "Renaming a directory" do
    directory = create(:directory, name: 'A Directory')

    visit Ilohv::Engine.config.url_root

    click_on "edit-directory-#{directory.id}"

    fill_in 'directory_name', with: 'A Renamed Directory'
    click_on 'save-button'

    expect(page).to have_content 'A Renamed Directory'
    expect(page).to_not have_content 'A Directory'
  end

  scenario "Deleting a directory" do
    directory = create(:directory, name: 'A Directory')
    subdirectory = create(:directory, parent: directory, name: 'A Subdirectory')
    create(:file, parent: directory, name: 'A File')
    create(:file, parent: subdirectory, name: 'A File in a Subdirectory')

    visit Ilohv::Engine.config.url_root

    click_on "delete-directory-#{directory.id}"

    expect(page).to_not have_content 'A Directory'
    expect(page).to_not have_content 'A Subdirectory'
    expect(page).to_not have_content 'A File'

    expect(Ilohv::Directory.count).to eq 0
    expect(Ilohv::File.count).to eq 0
  end
end
