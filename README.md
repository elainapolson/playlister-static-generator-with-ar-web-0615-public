---
tags: activerecord associations, ERB
languages: ruby
resources: 3
level: advanced
---

# Static Playlister on ActiveRecord

## Welcome to the Web!
In this lab, you're going to make some sweet static websites.  Static means no server is needed, so you're not using Rails or Sinatra.  You're going to use ActiveRecord and [ERB](http://ruby-doc.org/stdlib-2.1.2/libdoc/erb/rdoc/ERB.html) to generate regular html web pages.

Using ActiveRecord and ERB you'll create [ERB template](http://www.stuartellis.eu/articles/erb/) files that end in `.html.erb` where you can call your ActiveRecord models - `Artist`, `Genre`, and `Song` - to access all the information stored in your database.


## ActiveRecord Associations

In this lab, you'll be recreating the basic functionality of Playlister using [ActiveRecord associations](http://guides.rubyonrails.org/association_basics.html). The point of your association is to let your program know that an artist has many songs and therefore those songs belong to that artist. An artist will also have many genres, which it will know of through songs, so `Artist.genres`

You'll have three models: `Artist`, `Song`, and `Genre`. The `Artist` and `Genre` model will each know about it's associated songs and eachother.  To create these [associations](http://guides.rubyonrails.org/association_basics.html#the-has-many-through-association) you will need write proper migrations and ActiveRecord macros, special methods created by ActiveRecord's DSL.

The model tests will be calling methods that your models will, by default, have if your associations are correctly defined. You do not need to write those methods. Once your associations are defined you you can run `rake db:seed` to seed your database with sample data.

#### Creating Your Associations
- Create your models in `app/models`
- Your models will need an instance method called `to_slug` for making urls
  - ex. `an_artist.to_slug #=> kanye-west`
- Write migrations for your models and associations in `db/migrations`


## ERB and Static HTML Sites

Embedded Ruby(ERB) is a way of running Ruby in non `.rb` files. You'll be making your own generator that will read an HTML.ERB file to generate many static pages.

### Folder structure
Your template files will be in the following structure:

```
app/views
├── artists
│   ├── index.html.erb
│   └── show.html.erb
├── genres
│   ├── index.html.erb
│   └── show.html.erb
├── index.html.erb
└── songs
    ├── index.html.erb
    └── show.html.erb
```

You processed files will be in the following structure:

```
_site
├── artists
│   └── index.html
├── genres
│   └── index.html
├── index.html
└── songs
    └── index.html
```

#### Index Pages
Each model will generally have an index page.  Often they list all instances of model
- You will need to generate an index page for the top level of `app/views/`
  - The index should have a link to each model and a count of total instances
    - ex. `Artists -  42`
- Your index pages should be called `index.html.erb`
- Each model will have an index page in their appropriate folder in `app/views` directory
  - This index lists every instance and links to that instances show page


#### Show Pages
An instance of a model will often have `show.html.erb` that is rendered as a regular HTML file with information specific to that instance.
- Each model will have show pages in `app/views/<model>/`
- `Artist` show pages will have the instnce's name and a list of and link to its genres and songs.
- `Genre` show pages will have have the instnce's name and a list of and link to its artists and songs.
- `Song` show pages will state the instance's name and names of and links to its artist and genre.

####Site Generator
You will need a class whose sole purpose is generating the static pages.
- It should accept a path upon initialize to where it will save the files it generates
- It should use the ERB files from `app/views/` to generate all static pages
- It will live in `lib/support`

##Helpful Rake Tasks
This lab provides you with a number of Rake tasks to help you along the way.
- `rake db:migrate` will automatically create database and run your migrations all you need to do is write the migrations
- `rake db:seed` will automatically parse the songs and seed your database, no work required beyond migrations
- `rake console` will load a pry session with all of your environment loaded to play with the database
- `rake generate` will run your site generator once it is made assuming it has generate method
