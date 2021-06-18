# Changes in original project

## Db changes

The original project use postgreSql

This db is changed that sqlite3 in development mode:

- Add in the Gemfile " gem 'sqlite3' "

```ruby
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
  gem 'sqlite3'
end
```

- And in the database.yml " adapter: sqlite3 "

```yml
default: &default
  adapter: sqlite3
  # adapter: postgresql
  encoding: unicode
  # For details on connection pooling, see Rails configuration guide
  # https://guides.rubyonrails.org/configuring.html#database-pooling
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
```

- Modify in migrate file " db/migrate/20201128141825_create_tags.rb " (if necessary) the extension " citext " because this is property from postgresql implementations

```ruby
class CreateTags < ActiveRecord::Migration[6.0]
  def change
    create_table :tags do |t|
      # This extension is for postgresql
      # enable_extension('citext')
      # t.citext :name
      t.string :name
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :tags, [:name, :user_id], unique: true
  end
end
```

- Run " rails db:migrate "

- Done!!!

## Display user email

Show the user's email on the page after logging in and while logged in

This is simple:

- in the application.html.erb file add a tag: <"p">User: <%= current_user.email %><"/p"> in the condition "<% if user_signed_in? %>"

```ruby
...
<div class="container">
      <% if user_signed_in? %>
        <p>User: <%= current_user.email %></p>
        <%= link_to 'Home', home_path %>
        <%= link_to 'Contents', contents_path %>
        <%= link_to 'Logout', destroy_user_session_path, method: :delete %>
      <% end %>

      <p class="notice"><%= notice %></p>
      <p class="alert"><%= alert %></p>

      <%= yield %>
    </div>
...
```

- Done!!!

## Layout changes

Some improvements in component presentation using Bootstrap 

- Element centering

- Background on body

- Content separation
