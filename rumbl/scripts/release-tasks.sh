#!/bin/sh

POOL_SIZE=2 mix run priv/repo/seeds.exs
POOL_SIZE=2 mix ecto.migrate
