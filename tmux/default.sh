SESSION_NAME=default

tmux has-session -t $SESSION_NAME 2> /dev/null
if [ $? -eq 0 ]
then
  tmux attach -t $SESSION_NAME
  exit
fi

tmux new-session -s $SESSION_NAME -d

# window: airlab sync
tmux rename-window airlab-sync
tmux send-keys -t $SESSION_NAME 'cd ~/repos/airbnb && airlab sync' C-m

# window: monorail
tmux new-window -n monorail
tmux send-keys -t $SESSION_NAME 'cd ~/repos/airbnb' C-m

# window: treehouse
tmux new-window -n treehouse
tmux send-keys -t $SESSION_NAME 'cd ~/repos/treehouse' C-m

# window: rolodex
tmux new-window -n rolodex
tmux send-keys -t $SESSION_NAME 'cd ~/repos/treehouse/projects/rolodex' C-m

# window
tmux new-window
tmux send-keys -t $SESSION_NAME 'cd ~/repos/treehouse/projects/rolodex' C-m

### Select 1st window
tmux next-window -t $SESSION_NAME

tmux attach -t $SESSION_NAME
