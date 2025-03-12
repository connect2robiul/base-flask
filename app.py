


from flask import Flask, render_template, redirect, url_for ,request
from gevent.pywsgi import WSGIServer 
import os

app = Flask(__name__) 
#app.debug = os.getenv("FLASK_DEBUG", "False").lower() == "true"

@app.route('/')
def hello():
    return "Hello World!"

@app.route('/working')
def JavaScript():
    return render_template('base.html')


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=1212,threaded=True, debug=True)
  #  http_server = WSGIServer(('0.0.0.0', 1212), app)
  #  http_server.serve_forever()
   
