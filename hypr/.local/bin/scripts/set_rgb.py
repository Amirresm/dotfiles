import os
import json
import time
import random

from typing import Dict
from openrgb import OpenRGBClient
from openrgb.utils import DeviceType, RGBColor


RAM_COLOR = "color1"
MB_COLOR1 = "color6" # CPU Cooler
MB_COLOR2 = "color4"
GPU_COLOR = "color4"

PYWAL_CACHE_DIR = os.path.expanduser("~/.cache/wal")

def get_random_delay(min=0.1, max=0.3):
    return random.uniform(min, max)

def read_pywal_colors():
    with open(os.path.join(PYWAL_CACHE_DIR, "colors.json"), "r") as f:
        colors = json.load(f)
    return colors.get("colors", [])

def set_colors(client: OpenRGBClient, colors: Dict[str, str]):
    # client.clear()
    motherboard = client.get_devices_by_type(DeviceType.MOTHERBOARD)
    ram = client.get_devices_by_type(DeviceType.DRAM)
    gpu = client.get_devices_by_type(DeviceType.GPU)

    if len(motherboard) == 1:
        mb_zones = motherboard[0].zones
        for zone in mb_zones:
            color = colors[MB_COLOR1] if zone.id % 2 == 0 else colors[MB_COLOR2]
            print(f"Setting zone {zone.id} to color {color}")
            zone.set_color(RGBColor.fromHEX(color))
            time.sleep(get_random_delay())
        # mode = motherboard[0].modes[2]
        # mode.speed = 0
        # motherboard[0].set_mode(mode)

    if len(ram) > 0:
        for r in ram:
            print(f"Setting RAM to color {colors[RAM_COLOR]}")
            r.set_color(RGBColor.fromHEX(colors[RAM_COLOR]))
            time.sleep(get_random_delay())

    if len(gpu) == 1:
        print(f"Setting GPU to color {colors[GPU_COLOR]}")
        gpu[0].set_color(RGBColor.fromHEX(colors[GPU_COLOR]))
        gpu[0].set_mode("off")
        time.sleep(get_random_delay())
    # motherboard.set_mode("static")
    client.save_profile("from_pywal")

def main():
    try:
        client = OpenRGBClient()
    except Exception as e:
        print(f"Failed to connect to OpenRGB: {e}")
        return
    colors = read_pywal_colors()
    set_colors(client, colors)

if __name__ == "__main__":
    main()

