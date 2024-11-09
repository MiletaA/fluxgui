# setup.py

from setuptools import setup, find_packages
from setuptools.command.install import install
import os
import subprocess

class CustomInstall(install):
    def run(self):
        super().run()
        if os.environ.get('DISABLE_GSCHEMAS_COMPILED') is None:
            print("Compiling GSettings schemas")
            gschema_dir = os.path.join(self.install_lib, 'share/glib-2.0/schemas')
            subprocess.call(["glib-compile-schemas", gschema_dir])

setup(
    name="fluxgui",
    version="2.0.1",
    description="f.lux indicator applet - better lighting for your computer",
    author="Kilian Valkhof, Michael and Lorna Herf, Josh Winters",
    author_email="kilian@kilianvalkhof.com",
    url="https://github.com/xflux-gui/fluxgui",
    license="MIT",
    packages=find_packages(where="src"),
    package_dir={'': 'src'},
    include_package_data=True,

    data_files=[
        ('share/icons/hicolor/16x16/apps', ['icons/hicolor/16x16/apps/fluxgui.svg']),
        ('share/icons/hicolor/22x22/apps', ['icons/hicolor/22x22/apps/fluxgui.svg']),
        ('share/icons/hicolor/24x24/apps', ['icons/hicolor/24x24/apps/fluxgui.svg']),
        ('share/icons/hicolor/32x32/apps', ['icons/hicolor/32x32/apps/fluxgui.svg']),
        ('share/icons/hicolor/48x48/apps', ['icons/hicolor/48x48/apps/fluxgui.svg']),
        ('share/icons/hicolor/64x64/apps', ['icons/hicolor/64x64/apps/fluxgui.svg']),
        ('share/icons/hicolor/96x96/apps', ['icons/hicolor/96x96/apps/fluxgui.svg']),
        ('share/icons/ubuntu-mono-dark/status/16', ['icons/ubuntu-mono-dark/status/16/fluxgui-panel.svg']),
        ('share/icons/ubuntu-mono-dark/status/22', ['icons/ubuntu-mono-dark/status/22/fluxgui-panel.svg']),
        ('share/icons/ubuntu-mono-dark/status/24', ['icons/ubuntu-mono-dark/status/24/fluxgui-panel.svg']),
        ('share/icons/ubuntu-mono-light/status/16', ['icons/ubuntu-mono-light/status/16/fluxgui-panel.svg']),
        ('share/icons/ubuntu-mono-light/status/22', ['icons/ubuntu-mono-light/status/22/fluxgui-panel.svg']),
        ('share/icons/ubuntu-mono-light/status/24', ['icons/ubuntu-mono-light/status/24/fluxgui-panel.svg']),
        ('share/icons/Adwaita/16x16/status', ['icons/Adwaita/16x16/status/fluxgui-panel.svg']),
        ('share/icons/breeze/status/22', ['icons/breeze/status/22/fluxgui-panel.svg']),
        ('share/icons/breeze-dark/status/22', ['icons/breeze-dark/status/22/fluxgui-panel.svg']),
        ('share/icons/elementary/status/24', ['icons/elementary/status/24/fluxgui-panel.svg']),
        ('share/icons/elementary-xfce/panel/22', ['icons/elementary-xfce/panel/22/fluxgui-panel.svg']),
        ('share/icons/elementary-xfce-dark/panel/22', ['icons/elementary-xfce-dark/panel/22/fluxgui-panel.svg']),
        ('share/applications', ['desktop/fluxgui.desktop']),
        ('share/glib-2.0/schemas', ['apps.fluxgui.gschema.xml'])
    ],
    install_requires=[
        "requests>=2.0",
        "pygobject>=3.0",
    ],
    entry_points={
        'console_scripts': [
            'fluxgui = fluxgui.main:main',  # Entry point to main function in fluxgui.main module
        ],
    },
    cmdclass={'install': CustomInstall},
    python_requires=">=3.10",
)
