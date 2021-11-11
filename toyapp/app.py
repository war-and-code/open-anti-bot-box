from flask import Flask
from flask import Response

app = Flask(__name__)

@app.route("/status/<status>")
def reflect_status(status):
    try:
        status_string = str(status)
        status_int = int(status)
        return status_string, status_int
    except:
        return "ERROR!", 400

if __name__ == "__main__":
    app.run(host='0.0.0.0')
