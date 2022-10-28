# project_x_player

## Instructions:

Install python.
Install the required dependencies in the terminal:

`
pip install flask
`

Run the server:

`python video_server.py`

The server is accessible at http://localhost:5000/

Press enter in the terminal, or go to http://localhost:5000/admin to activate the notification.

## Remotely accessing the server
To use this as a remote control, you will need to do some networking. Ngrok is a great tool, just make an account and follow the instructions on the webpage. The final command should be 
`ngrok http 5000`
this will give you a public url that can be accessed anywhere in the world. Again, put /admin at the end of the link to control the notification

## Customization

The message can be found and changed in the file /static/styles/homenew.css

The video and the background image are also in /static

