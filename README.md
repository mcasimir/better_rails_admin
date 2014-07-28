# Better Rails Admin

## Bug fixes, better Dsl and new features for Rails Admin.

``` rb
gem 'better_rails_admin', :git => "https://github.com/mcasimir/better_rails_admin"
```

## Features

- Autoreload on changes across requests
- Define rails admin models outside initializers and actual models through RailsAdmin#model
- All model that are not defined through RailsAdmin#model are excluded by default
- :admin_label is now the default label method/field for models (takes precedence over any other)
- Enabling/disabling actions for models is possible within model declaration with dedicated methods. 
- Works as expected without CanCan
- Sort ui for nested models having position
- Getting rid of ugly default dashboard
- Ability to define object_label passing a block, for dynamic labels based on instances
- 100% compatible with default RailsAdmin dsl

---

This project is released under the terms of MIT-LICENSE.