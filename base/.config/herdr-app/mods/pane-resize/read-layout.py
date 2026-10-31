"""Read the core's shared layout; changes go through Herdr's layout.resize command."""

import json
import subprocess
import sys


def read_layout(machine=None):
    params = {"name": "herdr-app"}
    if machine:
        params["on"] = machine
    requests = [
        {"jsonrpc": "2.0", "id": 1, "method": "hello", "params": {}},
        {"jsonrpc": "2.0", "id": 2, "method": "doc.get", "params": params},
    ]
    result = subprocess.run(
        ["hc", "connect"],
        input="".join(json.dumps(request) + "\n" for request in requests),
        text=True, capture_output=True, timeout=10, check=True,
    )
    for line in result.stdout.splitlines():
        reply = json.loads(line)
        if "error" in reply:
            raise RuntimeError(reply["error"].get("message", "Cannot read layout"))
        if reply.get("id") == 2:
            return reply["result"]["value"]
    raise RuntimeError("The core returned no layout")


if __name__ == "__main__":
    try:
        print(json.dumps(read_layout(sys.argv[1] if len(sys.argv) > 1 else None)))
    except Exception as error:
        print(str(error), file=sys.stderr)
        sys.exit(1)
