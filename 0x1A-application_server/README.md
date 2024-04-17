# 0x1A. Application server



tmux new-session -d -s my_gunicorn_session 'HBNB_ENV=test \
HBNB_MYSQL_USER= \
HBNB_MYSQL_PWD= \
HBNB_MYSQL_HOST=localhost \
HBNB_MYSQL_DB= \
HBNB_TYPE_STORAGE=db \
gunicorn --bind 0.0.0.0:5002 api.v1.app:app'

