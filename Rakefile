task :default => :server

desc "run the chat server"
task :server do
  sh "rackup"
end

desc "make a non Ajax request via curl"
task :noajax do
  sh "curl -v http://localhost:4567/update"
end

desc "make an Ajax request via curl"
task :ajax do
  sh %q{curl -v -H "X-Requested-With: XMLHttpRequest" localhost:4567/update}
end

desc "Visit the GitHub repo page"
task :open do
  sh "open https://github.com/semrh/chatSyTW"
end

desc "Run tests (default)"
task :tests => :spec do
   sh "ruby test/test.rb"
end
