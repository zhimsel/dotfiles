fpath=("${ZSH_CONFIG_DIR}/functions" $fpath)

for function in ${ZSH_CONFIG_DIR}/functions/*; do
  autoload $function
done
