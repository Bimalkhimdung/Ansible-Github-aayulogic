FROM python:3.8

#seting env vatriable
ENV Remote_dir /home/devops/Test

#installing packages

RUN apt update && apt install -y git && apt install python3-venv

#cloning git repo
RUN git clone https://github.com/Bimalkhimdung/weather-app-backend-aayulogic.git $Remote_dir

#creating virtual env

Run python3 -m venv $Remote_dir/env

WORKDIR $Remote_dir
RUN . $Remote_dir/env/bin/activate && pip install -r requiremnets.txt

#making migration
RUN . $Remote_dir/env/bin/activate && python3 manage.py migrate
#exposing gunicorn

EXPOSE 8000

#starting gunicorn
RUN . $Remote_dir/env/bin/activate \
    /home/devops/Test/env/bin/gunicorn weather_app.wsgi:application --reload --bind 192.168.102.238:8000

#CMD ["/home/devops/Test/env/bin/gunicorn","weather_app.wsgi:applicaton", "--bind", "192.168.102.238:8000"]
