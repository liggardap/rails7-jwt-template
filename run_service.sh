echo "------------------Migrate DB------------------"
RAILS_ENV=$RAILS_ENV bundle exec rails db:migrate:with_data

echo "\n------------------Server Start------------------"
bundle exec foreman start -p 3000