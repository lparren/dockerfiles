# importing the required packages
import psutil

# This code will print the number of CPU cores present
print("[+] Number of Physical cores :", psutil.cpu_count(logical=False))
print("[+] Number of Total cores :", psutil.cpu_count(logical=True))
print("\n")
# This will print the maximum, minimum and current CPU frequency
cpu_frequency = psutil.cpu_freq()
print(f"[+] Max Frequency : {cpu_frequency.max:.2f}Mhz")
print(f"[+] Min Frequency : {cpu_frequency.min:.2f}Mhz")
print(f"[+] Current Frequency : {cpu_frequency.current:.2f}Mhz")
print("\n")
# This will print the usage of CPU per core
for i, percentage in enumerate(psutil.cpu_percent(percpu=True, interval=1)):
    print(f"[+] CPU Usage of Core {i} : {percentage}%")
print(f"[+] Total CPU Usage : {psutil.cpu_percent()}%")