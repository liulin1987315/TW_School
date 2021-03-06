#encoding=UTF-8
require_relative '../spec_helper'
require 'digest/sha1'

feature 'Pos Login Page' do

    background :each do
        Administrator.create(name: 'admin', password: Digest::SHA1.hexdigest('admin'))
    end

    scenario 'should see admin login page when an unauthorized visitor click admin link in navigator' do
        visit '/'
        click_on '登录'
        expect(page).to have_content('请登入...')
    end

    scenario 'should go to admin page as authorized administrator when an unauthorized visitor submit correct login request (admin/admin)', :js => true do
        visit '/login'
        fill_in 'user', :with => 'admin'
        fill_in 'pwd', :with => 'admin'
        click_on '提交'
        expect(current_url).to end_with('/admin/product_management')
    end

    scenario 'stay in login page with alert info when an unauthorized visitor submit incorrect login request', :js => true do
        visit '/login'
        fill_in 'user', :with => 'admin'
        fill_in 'pwd', :with => 'wrongpassword'
        click_on '提交'
        expect(page).to have_content('用户名或密码错误')
    end

    scenario 'go to admin page if authorized when an authorized visitor click admin link in homepage' do
        admin = Administrator.where("name = ?", "admin").first #rescue nil
        page.set_rack_session admin_id: admin.id
        visit '/'
        click_on '商品管理'
        expect(current_url).to end_with('/admin/product_management')
    end
end
