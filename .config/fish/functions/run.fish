function run
 gcc $argv -o run_tmp && ./run_tmp; set ret_code $status || echo && rm run_tmp && echo "exit code: "$ret_code
end
