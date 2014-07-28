# Better Rails Admin

## Autoreload, Bug fixes, better Dsl and new features for Rails Admin.

Place the following in your Gemfile after `gem 'rails_admin'` and issue `bundle install`

``` rb
gem 'better_rails_admin', :git => "https://github.com/mcasimir/better_rails_admin"
```

### Features

#### Dedicated Dsl to define Models

Define rails admin models outside initializers and actual models through RailsAdmin#model

``` rb
# admin/content_admin.rb

RailsAdmin.model "Content" do
  # ...
end
```

#### Autoreload

Autoreload on each request in development (no action required)

#### Prepend `admin_label` to `RailsAdmin.config.label_methods`

Uses `admin_label` as primary label method/field for models

#### Inline enable/disable actions in models with `:only` and `:except` methods

``` rb
RailsAdmin.model "Settings" do
  only :index, :edit
end
```

#### Works as expected without CanCan

Fixes https://github.com/sferik/rails_admin/issues/2023

#### Sort ui for nested models having position

Enables drag and drop sorting tabs for nested models exposing a `position` field

You have to add the following in `app/assets/javascripts/rails_admin/custom/ui.js` to enable this feature:

``` js
//= require rails_admin/custom/sort_nested
```

#### Blank default dashboard

Better have none than a confusing one

#### Closure for `object_label`

Gives you the ability to define `object_label` passing a block to setup dynamic labels based on instances:

``` rb
RailsAdmin.model "Administrator" do

  object_label do |record|
    record.email
  end

end
```

#### 100% backward compatibility with default RailsAdmin dsl

---

This project is released under the terms of MIT-LICENSE.