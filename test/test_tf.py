# testinfra https://testinfra.readthedocs.io/en/latest/modules.html#testinfra.modules.docker.Docker

def test_run_terraform_version(host):
    assert host.run_expect([0], "terraform --version")

def test_run_awscli_version(host):
    assert host.run_expect([0], "aws --version")