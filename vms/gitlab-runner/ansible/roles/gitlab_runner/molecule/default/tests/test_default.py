def test_gitlab_runner_repo_key_exists(host):
    gpg_key = host.file("/usr/share/keyrings/runner_gitlab-runner-archive-keyring.gpg")
    assert gpg_key.exists

def test_gitlab_runner_repo_added(host):
    source_file = host.file("/etc/apt/sources.list.d/runner_gitlab-runner.list")
    assert source_file.exists

def test_gitlab_runner_installed(host):
    pkg = host.package("gitlab-runner")
    assert pkg.is_installed

def test_service_running(host):
    svc = host.service("gitlab-runner")
    assert svc.is_running
    assert svc.is_enabled

def test_config_file(host):
    config = host.file("/etc/gitlab-runner/config.toml")
    assert config.exists
