function weather --wraps=curl\ wttr.in/Köln\\\?0\\\?Q --wraps=curl\ wttr.in/50935\\\?0\\\?Q --description alias\ weather\ curl\ wttr.in/50935\\\?0\\\?Q
  curl wttr.in/50935\?0\?Q $argv
        
end
