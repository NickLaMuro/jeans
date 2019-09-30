JEANS_GEMSPEC = eval File.read("jeans.gemspec")

def sh_opts
  [
    { [:out, :err] => File::NULL, },
    { :verbose     => false }
  ]
end

def run cmd, *args
  sh cmd, *args, *sh_opts
end
