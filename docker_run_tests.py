from pathlib import Path
import subprocess

subprocess.run('docker build -t run_robot ./', shell=True, capture_output=True)

local_path = Path().absolute()

subprocess.run(f'docker run --rm --name executa_robot -v {local_path}/tests:/opt/robotframework/tests'
               f' -v {local_path}/results:/opt/robotframework/results'
               f' -v {local_path}/resources:/opt/robotframework/resources run_robot:latest robot -d'
               f' /opt/robot/framework/results /opt/robotframework/tests',
               shell=True, capture_output=False)
