#!/bin/bash

brew upgrade
sheldon lock --update
gcloud components update --quiet
nvim --headless "+Lazy! sync" +qa
