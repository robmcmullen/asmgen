import sys

try:
    from setuptools import setup
except ImportError:
    from distutils.core import setup

with open("README.rst", "r") as fp:
    long_description = fp.read()

scripts = ["quicksprite.py"]

setup(name="quicksprite",
        version="1.0",
        author="Rob McMullen",
        author_email="feedback@playermissile.com",
        url="https://github.com/robmcmullen/quicksprite",
        scripts=scripts,
        description="Sprite compiler for Apple ][ and Atari 8-bit",
        long_description=long_description,
        license="GPL",
        classifiers=[
            "Programming Language :: Python :: 2.7",
            "Intended Audience :: Developers",
            "License :: OSI Approved :: GNU General Public License (GPL)",
            "Topic :: Software Development :: Libraries",
            "Topic :: Utilities",
        ],
        install_requires = [
            "pypng",
            "numpy",
        ],
    )
