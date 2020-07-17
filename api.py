#!/usr/bin/env python
# -*- coding: utf-8 -*-

from flask import Flask, request
import subprocess

app = Flask(__name__)


@app.route("/", methods=["GET", "POST"])
def say():
    if request.method == "POST":
        text = request.json.get("text")
        gttscli = subprocess.Popen(
            f'gtts-cli -l de "{text}"', stdout=subprocess.PIPE, shell=True
        )
        mpg123 = subprocess.Popen(
            "mpg123 -", stdin=gttscli.stdout, stdout=subprocess.PIPE, shell=True
        )
        stdout, stderr = mpg123.communicate()
        return {"success": not bool(stderr)}
    else:
        return "Post your sentence to the API as parameter text!"
