#encoding=UTF-8
require_relative '../spec_helper'
require 'digest/sha1'

describe 'Pos Login Page', :type => :feature do

    before :each do
        User.create(username: 'admin', password: Digest::SHA1.hexdigest('admin'), is_admin: true)
    end

    it 'should see admin login page when an unauthorized visitor click admin link in navigator' do
        visit '/'
        click_on '管理'
        expect(page).to have_content('请登入...')
    end

    it 'should go to admin page as authorized user when an unauthorized visitor submit correct login request (admin/admin)', :js => true do
        visit '/login'
        fill_in 'username', :with => 'admin'
        fill_in 'form_pass', :with => 'admin'
        click_on '登入'
        expect(current_url).to end_with('/admin')
    end

    it 'stay in login page with alert info when an unauthorized visitor submit incorrect login request' do
        visit '/login'
        fill_in 'username', :with => 'admin'
        fill_in 'form_pass', :with => 'wrongpassword'
        click_on '登入'
        expect(page).to have_content('用户名或密码错误')
    end

    it 'go to admin page if authorized when an authorized visitor click admin link in homepage' do
        page.set_rack_session username: 'admin'
        page.set_rack_session password: Digest::SHA1.hexdigest('admin')
        visit '/'
        click_on '管理'
        expect(current_url).to end_with('/admin')
    end
end