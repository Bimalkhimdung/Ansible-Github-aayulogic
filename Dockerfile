FROM python:3.8

#seting env vatriable
ENV Remote_dir /home/devops/Test/

#installing packages

RUN apt update && apt install -y git  python3-venv

# Create a non-root user (optional but recommended for security)
RUN useradd -m devops
USER devops

RUN mkdir -p $Remote_dir
WORKDIR $Remote_dir
#cloning git repo
RUN git clone https://github.com/Bimalkhimdung/weather-app-backend-aayulogic.git .

#creating virtual env

Run python3 -m venv $Remote_dir/env

RUN . $Remote_dir/env/bin/activate && pip install -r requirements.txt

#making migration
RUN . $Remote_dir/env/bin/activate && python3 manage.py migrate

#feeding data to model

#RUN . $Remote_dir/env/bin/activate && python3 manage.py feed_data_to_model
#exposing gunicorn

EXPOSE 8000

#starting gunicorn
RUN . $Remote_dir/env/bin/activate \
    /home/devops/Test/env/bin/gunicorn weather_app.wsgi:application --reload --bind 192.168.102.238:8000

#CMD ["/home/devops/Test/env/bin/gunicorn","weather_app.wsgi:applicaton", "--bind", "192.168.102.238:8000"]
