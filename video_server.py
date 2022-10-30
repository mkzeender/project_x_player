
import json
from flask import Flask
import flask
import threading


app = Flask(__name__)

activated = False

@app.route('/video')
def video():
    return flask.render_template('player.html')

@app.route('/notify')
def notify():
    return flask.render_template('notify.html')

@app.route('/')
def home():
    return flask.render_template('home_new.html')

@app.route('/activated')
def is_activated():
    print(f'Sent Notification?: {activated}')
    return json.dumps({'activated': activated})

@app.route('/admin', methods=['GET'])
def admin():
    return flask.render_template('admin.html')

@app.route('/admin/<var>')
def change(var):
    change_activation(bool(int(var)))
    return flask.redirect('/admin')

def change_activation(new_activation):
    global activated
    activated = new_activation
    print('activated' if activated else 'deactivated')

def control_loop():
    global activated
    print('Enter to activate notification, or enter "reset" to reset the notification')
    try:
        while True:
            if (c := input().lower().strip()) in ('reset', 'deactivate'):
                activated = False
                print('deactivated')
            elif c in ('', 'activate'):
                activated = True
                print('activated')
            else:
                print('Unknown command. Press ctrl+c to exit.')
    except EOFError:
        return



def main():
    threading.Thread(daemon=True, name='Controller', target=control_loop).start()

    app.run(debug=True, use_reloader=False)

if __name__ == '__main__':
    main()