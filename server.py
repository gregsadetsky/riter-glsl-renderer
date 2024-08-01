import shutil
import subprocess
import tempfile
from datetime import datetime
from pathlib import Path

from flask import Flask, render_template, request, send_file

app = Flask(__name__)


@app.route("/", methods=["GET", "POST"])
def index():
    # if get method
    if request.method == "GET":
        # return template index.html
        return render_template("index.html")

    # assume this is post??
    # get 'shader' textarea form
    shader = request.form.get("shader")

    temporary_directory = tempfile.mkdtemp()
    shader_path = f"{temporary_directory}/shader.frag"

    with open(shader_path, "w") as f:
        f.write(shader)

    # glslViewer  /Users/g/Downloads/CellularNoise-1718514605632.frag    --headless -w 49 -h 19 -E sequence,0,10
    subprocess.run(
        [
            "glslViewer",
            shader_path,
            "--headless",
            "-w",
            "49",
            "-h",
            "19",
            "-E",
            "frames,0,1",
        ],
        cwd=temporary_directory,
    )

    # find the png in the directory
    all_pngs = list(Path(temporary_directory).glob("*.png"))
    assert len(all_pngs) == 1
    png_path = all_pngs[0]

    # RETURN THE PNG!!!
    return send_file(png_path, mimetype="image/png")


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080, debug=True)
