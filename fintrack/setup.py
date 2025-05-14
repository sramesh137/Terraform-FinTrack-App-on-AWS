from setuptools import setup, find_packages

setup(
    name="fintrack",
    version="0.1",
    packages=find_packages(),
    install_requires=[
        "flask",
        "flask-sqlalchemy",
        "psutil",
        "python-dotenv",
    ],
) 