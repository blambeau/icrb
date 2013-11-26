task :examples do
  require 'path'
  Path.backfind("examples").glob('*') do |f|
    next if f.file?
    chdir(f) do
      system("rake")
    end
  end
end
task :test => :examples
task :spec => :examples
