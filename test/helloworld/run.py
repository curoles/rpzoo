import subprocess
import time

CPP_DIR = "@CMAKE_CURRENT_BINARY_DIR@/cpp"
CPP_CLIENT = CPP_DIR+"/greeter_client"
CPP_SERVER = CPP_DIR+"/greeter_server"

PY_DIR = "@CMAKE_CURRENT_SOURCE_DIR@/python"
PY_CLIENT = PY_DIR+"/greeter_client.py"
PY_SERVER = PY_DIR+"/greeter_server.py"

#####################################

py_server = subprocess.Popen(["python3", PY_SERVER])
print("Start Python server", py_server)

time.sleep(0.1)

print("Run python client")
subprocess.run(["python3", PY_CLIENT], check=False)

print("Run C++ client")
subprocess.run([CPP_CLIENT], check=False)

time.sleep(0.1)

py_server.terminate()

###########################################

cpp_server = subprocess.Popen([CPP_SERVER])
print("Start C++ server", cpp_server)

time.sleep(0.1)

print("Run python client")
subprocess.run(["python3", PY_CLIENT], check=False)

print("Run C++ client")
subprocess.run([CPP_CLIENT], check=False)

time.sleep(0.1)

cpp_server.terminate()