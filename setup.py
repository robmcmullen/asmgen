import sys

try:
    from setuptools import setup
except ImportError:
    from distutils.core import setup

with open("README.rst", "r") as fp:
    long_description = fp.read()

scripts = ["asmgen.py"]

setup(name="asmgen",
        version="2.1",
        author="Rob McMullen",
        author_email="feedback@playermissile.com",
        url="https://github.com/robmcmullen/asmgen",
        scripts=scripts,
        description="6502 code generator for Apple ][ and Atari 8-bit",
        long_description=long_description,
        license="GPL",
        classifiers=[
            "Programming Language :: Python :: 3.6",
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
