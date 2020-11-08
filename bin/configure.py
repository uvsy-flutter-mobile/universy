import boto3
import click
import json
import os
import shutil

CONFIG_FOLDER = "config"


def write(config):
    with open("config/config.json", "w+") as outfile:
        json.dump(config, outfile, indent=4, sort_keys=True)


def fetch_ssm(name):
    session = boto3.Session(profile_name="uvsy-dev", region_name="sa-east-1")
    client = session.client("ssm")
    response = client.get_parameter(
        Name=name,
    )
    return response["Parameter"]["Value"]


def delete_dir(name):
    if os.path.isdir(name):
        shutil.rmtree(name)


def create_dir(name):
    os.mkdir(name)


def prepare():
    delete_dir(CONFIG_FOLDER)
    create_dir(CONFIG_FOLDER)


def fetch_config(stage):
    pool_id = fetch_ssm(f"/{stage}/cognito/students/poolId")
    client_id = fetch_ssm(f"/{stage}/cognito/students/clientId")
    db_path = f"{stage}_universy"
    return dict(
        stage=stage,
        userPoolId=pool_id,
        clientId=client_id,
        dbPath=db_path,
    )


@click.command()
@click.option("--stage", help="Stage to configure", default="dev", type=str)
def configure(stage):
    try:
        click.secho(f"Configuring to {stage}...", fg="green")
        prepare()
        config = fetch_config(stage)
        write(config)
        click.secho("Done!", fg="green")
    except Exception as err:
        click.secho(str(err), fg='red')


if __name__ == "__main__":
    configure()
