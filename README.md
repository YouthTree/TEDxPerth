# TEDxPerth #

This is a host application for the soon-to-be http://tedxperth.org/

## About this Application ##

The core aims for this web app is to facilitate:

* Planning events
* Managing registrations
* Posting news
* General discussions
* Providing history etc

## Getting Started ##

The following steps will help you get started. Please ensure you are using rvm
as it makes the whole process of getting setup a lot simpler.

1. Clone git://github.com/YouthTree/TEDxPerth.git
2. `cd TEDxPerth` - RVM should pickup the gemset / ruby, install the ruby and bundler as needed.
3. `./script/configure` - this will perform first time setup etc.
4. `./script/rails server` - this will start the app so you can browse it.

By default, this uses `rake db:setup` to load the schema.rb file and to run `db/seeds.rb`.

Out of the box, you will have a admin user with the password 'tedxperth'.

## Contributing ##

We encourage all community contributions. Keeping this in mind, please follow these general guidelines when contributing:

* Fork the project
* Create a topic branch for what you’re working on (git checkout -b awesome_feature)
* Commit away, push that up (git push your\_remote awesome\_feature)
* Create a new GitHub Issue with the commit, asking for review. Alternatively, send a pull request with details of what you added.
* Once it’s accepted, if you want access to the core repository feel free to ask! Otherwise, you can continue to hack away in your own fork.

Other than that, our guidelines very closely match the GemCutter guidelines [here](http://wiki.github.com/qrush/gemcutter/contribution-guidelines).

(Thanks to [GemCutter](http://wiki.github.com/qrush/gemcutter/) for the contribution guide)

## License ##

All code is licensed under the New BSD License and is copyright YouthTree. Please keep this
in mind when contributing.