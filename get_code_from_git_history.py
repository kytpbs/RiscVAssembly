import os
import shutil
import subprocess
import re
from typing import Literal

leading_4_spaces = re.compile("^    ")


def get_commits():
    lines = (
        subprocess.check_output(["git", "log"], stderr=subprocess.STDOUT)
        .decode("utf-8")
        .split("\n")
    )
    commits = []
    current_commit = {}

    def save_current_commit():
        title = current_commit["message"][0]
        message = current_commit["message"][1:]
        if message and message[0] == "":
            del message[0]
        current_commit["title"] = title
        current_commit["message"] = "\n".join(message)
        commits.append(current_commit)

    for line in lines:
        if not line.startswith(" "):
            if line.startswith("commit "):
                if current_commit:
                    save_current_commit()
                    current_commit = {}
                current_commit["hash"] = line.split("commit ")[1]
            else:
                try:
                    key, value = line.split(":", 1)
                    current_commit[key.lower()] = value.strip()
                except ValueError:
                    pass
        else:
            current_commit.setdefault("message", []).append(
                leading_4_spaces.sub("", line)
            )
    if current_commit:
        save_current_commit()
    return commits


def is_a_program_commit(commit_message):
    return "[" in commit_message


def go_trough_commits(
    commits: list[dict[Literal["author", "date", "hash", "message", "title"], str]],
):
    program_commits = filter(
        lambda commit: is_a_program_commit(commit["title"]), commits
    )
    for program_commit in program_commits:
        os.system(f"git checkout {program_commit['hash']}")
        to_write_location = "Problems-temp/" + program_commit["title"] + ".s"
        os.makedirs("Problems-temp/", exist_ok=True)
        print(to_write_location)
        with (
            open("app.s", "r", encoding="utf-8") as program_code,
            open(to_write_location, "w", encoding="utf-8") as save_location,
        ):
            save_location.write(program_code.read())


if __name__ == "__main__":
    go_trough_commits(get_commits())
    os.system("git switch main")
    shutil.copytree('Problems-temp', 'Problems', dirs_exist_ok=True)
    shutil.rmtree('Problems-temp')
