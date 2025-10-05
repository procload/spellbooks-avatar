Perfect—that makes it even easier. From inside your empty spellbooks-avatar/ folder, do this:

## 1) Create the Rails 8 app in-place with SQLite

```bash
cd spellbooks-avatar

# If the folder is truly empty:
rails new . --database=sqlite3

# If Rails complains the directory isn't empty (e.g., a stray .git/README):
rails new . --database=sqlite3 --force

bundle install
```

**macOS:** SQLite is usually present. If not: `brew install sqlite`.  
If you already ran `git init`, use `--skip-git` on `rails new`.

## 2) Generate controller & routes

```bash
bin/rails g controller Avatars new create
```

Edit `config/routes.rb`:

```ruby
Rails.application.routes.draw do
	root "avatars#new"
	resources :avatars, only: [:new, :create]
end
```

## 3) Add a placeholder image

Drop an image at: `app/assets/images/avatar-placeholder.png`.

## 4) Controller (minimal, keeps options in constants)

`app/controllers/avatars_controller.rb`

```ruby
class AvatarsController < ApplicationController
	CLASSES = ["Wizard", "Knight", "Ranger", "Scholar"].freeze
	TRAITS  = ["Brave", "Clever", "Kind", "Sneaky", "Curious"].freeze
	GENDERS = ["male", "female", "non-binary"].freeze

	def new
		@classes = CLASSES
		@traits  = TRAITS
		@genders = GENDERS
	end

	def create
		@classes = CLASSES
		@traits  = TRAITS
		@genders = GENDERS

		@input = params.require(:avatar).permit(:name, :gender, :klass, traits: [])
		render :new
	end
end
```

## 5) View with the simple form

`app/views/avatars/new.html.erb`

```erb
<h1>Spellbooks Avatar Generator</h1>

<p><%= image_tag "avatar-placeholder.png", alt: "Avatar preview", width: 256, height: 256 %></p>

<%= form_with url: avatars_path, scope: :avatar, method: :post do |f| %>
	<div>
		<%= f.label :name, "Name" %><br>
		<%= f.text_field :name, required: true %>
	</div>

	<div style="margin-top: .5rem;">
		<span>Gender</span><br>
		<% (@genders || []).each do |g| %>
			<label style="margin-right: 1rem;">
				<%= f.radio_button :gender, g %> <%= g.humanize %>
			</label>
		<% end %>
	</div>

	<div style="margin-top: .5rem;">
		<%= f.label :klass, "Class" %><br>
		<%= f.select :klass, options_for_select(@classes), {}, { required: true } %>
	</div>

	<div style="margin-top: .5rem;">
		<%= f.label :traits, "Fun traits" %><br>
		<%= f.select :traits, options_for_select(@traits), {}, multiple: true, size: 5 %>
	</div>

	<div style="margin-top: .75rem;">
		<%= f.submit "Generate", data: { turbo: false } %>
	</div>
<% end %>

<% if defined?(@input) && @input.present? %>
	<hr>
	<h2>Submitted</h2>
	<ul>
		<li><strong>Name:</strong> <%= @input[:name] %></li>
		<li><strong>Gender:</strong> <%= @input[:gender] %></li>
		<li><strong>Class:</strong> <%= @input[:klass] %></li>
		<li><strong>Traits:</strong> <%= Array(@input[:traits]).join(", ") %></li>
	</ul>
<% end %>
```

**Tip (mobile):** ensure `app/views/layouts/application.html.erb` has  
`<meta name="viewport" content="width=device-width, initial-scale=1">` (Rails usually adds this by default).

## 6) Run it locally

```bash
bin/rails db:prepare
bin/rails s
# Visit http://localhost:3000
```

---

## 7) Initialize Git & push to GitHub

```bash
git init
git add .
git commit -m "Iter 1: minimal avatar form"

# Create a repo (adjust org/name as you like)
gh repo create spellbooks-avatar --public --source=. --push
# or create on GitHub UI, then:
# git remote add origin git@github.com:<you>/spellbooks-avatar.git
# git push -u origin main
```

## 8) CI with SQLite on GitHub Actions

`.github/workflows/ci.yml`

```yaml
name: Ruby CI
on:
	push: { branches: [ main ] }
	pull_request: { branches: [ main ] }

jobs:
	build:
		runs-on: ubuntu-latest
		steps:
			- uses: actions/checkout@v4

			- name: Install SQLite system libs
				run: sudo apt-get update && sudo apt-get install -y sqlite3 libsqlite3-dev

			- uses: ruby/setup-ruby@v1
				with:
					bundler-cache: true

			- run: bin/rails db:prepare
			- run: bundle exec rails about
			- run: bundle exec rails assets:precompile
```

## 9) Optional: AI PR reviews (pick one—or both later)

- **OpenAI-based action:** add `.github/workflows/ai-review-openai.yml` and set repo secrets `OPENAI_API_KEY` and (if needed) `OCTOKIT_TOKEN`.
- **Claude-based action:** add `.github/workflows/ai-review-claude.yml` and set `ANTHROPIC_API_KEY`.

---

That's Iteration 1 fully wired from your empty directory. Want me to add the image-generation endpoint next (Gemini/OpenAI) and swap the placeholder preview to the returned image?
