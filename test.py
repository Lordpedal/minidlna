import os
import pytest
import subprocess
import testinfra


@pytest.fixture(scope="session")
def host(request):
    subprocess.check_call(["docker", "build", "-t", "image-under-test", "."])
    docker_id = (
        subprocess.check_output(["docker", "run", "-d", "image-under-test"])
        .decode()
        .strip()
    )

    yield testinfra.get_host("docker://" + docker_id)

    subprocess.check_call(["docker", "rm", "-f", docker_id])


def test_system(host):
    assert host.system_info.distribution == "alpine"
    assert host.system_info.release.startswith("3.")


def test_process(host):
    process = host.process.get(comm="minidlnad")
    assert process.pid == 1
    assert process.user == "root"
    assert (
        "/usr/sbin/minidlnad -P /tmp/minidlna.pid -f /config/minidlna.conf -S"
        in process.args
    )


def test_ports(host):
    assert host.socket("tcp://0.0.0.0:8200").is_listening


@pytest.mark.parametrize(
    "package",
    [
        ("curl"),
        ("inotify-tools"),
        ("ffmpeg"),
        ("flac"),
        ("libvorbis"),
        ("libexif"),
        ("libjpeg"),
        ("libid3tag"),
        ("minidlna"),
        ("su-exec"),
    ],
)
def test_installed_dependencies(host, package):
    assert host.package(package).is_installed
