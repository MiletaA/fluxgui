#!/usr/bin/env python3

import os
import subprocess
from sys import maxsize

def download_xflux():
    # Determine appropriate executable based on system architecture
    if maxsize == 2**31 - 1:
        print("Downloading 32-bit xflux ...")
        urls = ["https://justgetflux.com/linux/xflux-pre.tgz"]
    elif maxsize == 2**63 - 1:
        print("Downloading 64-bit xflux ...")
        urls = [
            "https://justgetflux.com/linux/xflux64.tgz",
            "https://justgetflux.com/linux/xflux11.tgz",
            "https://justgetflux.com/linux/xflux12.tgz"
        ]
    else:
        raise Exception(f"Unexpected maxsize = {maxsize}!")

    tarchive = "./xflux.tgz"
    for url in urls:
        try:
            print(f"Attempting to download from {url}...")
            # Download the file
            result = subprocess.run(['wget', url, '-O', tarchive], check=True)
            if result.returncode == 0 and os.path.exists(tarchive):
                # Extract the archive if the download succeeded
                print(f"Extracting {tarchive}...")
                subprocess.run(['tar', '-xvf', tarchive, '-C', '/usr/local/bin'], check=True)
                print("Download and extraction completed.")
                break
        except subprocess.CalledProcessError:
            print(f"Failed to download from {url}. Trying next URL if available.")
        except Exception as e:
            print(f"An error occurred: {e}")

    else:
        print("All download attempts failed.")

if __name__ == '__main__':
    download_xflux()
