#!/usr/bin/python3

import os
import json


def print_headers():
    print(f"Content-Type: application/json")
    print("Access-Control-Allow-Origin: *")
    print("Access-Control-Allow-Methods: GET, POST")
    print("Access-Control-Allow-Headers: Content-Type")
    print()


def count_likes(likeFile):
    if os.path.exists(likeFile):
        with open(likeFile, "r") as f:
            return len(f.read().splitlines())
    return 0


def main():
    likes = 0
    request_method = os.getenv("REQUEST_METHOD", "GET")
    home = os.getenv("HOME", "/home/badrick")
    ip = os.getenv("HTTP_X_FORWARDED_FOR", "").split(",")[0].strip()
    if not ip:
        ip = os.getenv("REMOTE_ADDR", "127.0.0.1")
    likeFile = os.path.join(home, "web/badricks-world.at/.likes")
    likes = count_likes(likeFile)

    # Handle GET request to return current like count
    if request_method == "GET":
        print_headers()
        print(json.dumps({"likes": likes}))
        return

    # Handle POST request to add a like
    if os.path.exists(likeFile):
        with open(likeFile, "r") as f:
            if ip in f.read().splitlines():
                print_headers()
                print(
                    json.dumps(
                        {
                            "message": "Thanks for liking the page - AGAIN!",
                            "likes": likes,
                        }
                    )
                )
                return

    try:
        open(likeFile, "a").write(ip + "\n")
        likes += 1
        print_headers()
        print(json.dumps({"message": "Thanks for liking the page! 🖤", "likes": likes}))
    except Exception as e:
        print_headers()
        print(json.dumps({"error": str(e)}))
        return


if __name__ == "__main__":
    main()
