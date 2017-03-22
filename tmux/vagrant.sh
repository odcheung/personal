SESSION_NAME=vagrant

tmux has-session -t $SESSION_NAME 2> /dev/null
if [ $? -eq 0 ]
then
  tmux attach -t $SESSION_NAME
  exit
fi

tmux new-session -s $SESSION_NAME -d

### Monorail
# first pane
tmux rename-window monorail
tmux send-keys -t $SESSION_NAME 'cd ~/repos/airbnb && airlab ssh' C-m
tmux send-keys -t $SESSION_NAME 'cd repos/airbnb && bundle install && sudo service monorail restart && sudo service nginx restart || rm .zeus.sock && zeus start' C-m

# second pane
tmux split-window -h -t $SESSION_NAME
tmux send-keys -t $SESSION_NAME 'sleep $[ ( $RANDOM % 8 ) + 1 ]s; cd ~/repos/airbnb && airlab ssh' C-m
tmux send-keys -t $SESSION_NAME 'cd repos/airbnb' C-m

# third pane
tmux select-pane -L
tmux split-window -v -t $SESSION_NAME
tmux send-keys -t $SESSION_NAME 'sleep $[ ( $RANDOM % 8 ) + 1 ]s; cd ~/repos/airbnb && airlab ssh' C-m
tmux send-keys -t $SESSION_NAME 'cd repos/airbnb' C-m

### Open window
tmux new-window
tmux send-keys -t $SESSION_NAME 'sleep $[ ( $RANDOM % 8 ) + 1 ]s; cd ~/repos/airbnb && airlab ssh' C-m

### Select 1st window
tmux next-window -t $SESSION_NAME

tmux attach -t $SESSION_NAME
