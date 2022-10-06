team = Team.create(name: 'Test Team')
user = User.create(first_name: 'John', last_name: 'Smith', email: 'a@b.com', password: 'password', team: team)
user = User.create(first_name: 'Admin', last_name: 'Smith', email: 'admin@b.com', password: 'password', team: team, super_user: true)

project = Project.create(public_key: '12312cacadsasadas11', title: 'SomeProject', team: team)
category = Category.create!(title: 'SomeCat', project: project)
Release.create!(user: user, title: 'Shortcut release to the ACT department', project: project, status: :published, category: category)
Release.create!(user: user, title: 'Version 2 release to the act department', project: project, status: :published, category: category)
Release.create!(user: user, title: 'Bug fix for guest users', project: project, status: :published)
Release.create!(user: user, title: 'Fixed bug for ACT department', project: project, status: :published)
