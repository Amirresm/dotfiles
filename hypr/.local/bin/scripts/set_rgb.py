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

DELAY_BETWEEN = 0.1

PYWAL_CACHE_DIR = os.path.expanduser("~/.cache/wal")

def get_random_delay(min=0.01, max=0.2):
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
    mouse = client.get_devices_by_type(DeviceType.MOUSE)

    if len(motherboard) == 1:
        mode = [m for m in motherboard[0].modes if m.name in ["Breathing", "MeteorX"]][0]
        mode.speed = 0 
        mode.brightness = 1
        motherboard[0].set_mode("static")
        # print("modes:", modes)
        mb_zones = motherboard[0].zones

        off_zones = mb_zones[:2]
        on_zones = mb_zones[:0]
        for zone in off_zones:
            zone.set_color(RGBColor.fromHEX("#000000"))
            time.sleep(get_random_delay())
            print(f"Setting zone {zone.id} to color #000000")

        for zone in on_zones:
            color = colors[MB_COLOR1] if zone.id % 2 == 0 else colors[MB_COLOR2]
            zone.set_color(RGBColor.fromHEX("#000000"))
            time.sleep(get_random_delay())
            print(f"Setting zone {zone.id} to color {color}")
            zone.set_color(RGBColor.fromHEX(color))
            time.sleep(get_random_delay() + DELAY_BETWEEN)
        # mode = motherboard[0].modes[2]
        # mode.speed = 0
        # motherboard[0].set_mode(mode)

    if len(ram) > 0:
        for r in ram:
            print(f"Setting RAM to color {colors[RAM_COLOR]}")
            r.set_mode("off")
            time.sleep(get_random_delay())
            r.set_mode("direct")
            # r.set_color(RGBColor.fromHEX(colors[RAM_COLOR]))
            r.set_color(RGBColor.fromHEX("#FFFFFF"))
            time.sleep(get_random_delay() + DELAY_BETWEEN)

    if len(gpu) == 1:
        print(f"Setting GPU to color {colors[GPU_COLOR]}")
        gpu[0].set_color(RGBColor.fromHEX(colors[GPU_COLOR]))
        gpu[0].set_mode("off")
        time.sleep(get_random_delay())

    if len(mouse) > 0:
        for m in mouse:
            m.set_mode("off")
            time.sleep(get_random_delay())
            m.set_mode("breathing")
            m.set_color(RGBColor.fromHEX(colors[MB_COLOR2]))
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
