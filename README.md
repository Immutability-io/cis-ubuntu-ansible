# CIS for Ubuntu 14.04

This project was forked from https://github.com/awailly/cis-ubuntu-ansible.

## Prerequisites

The role is focused on hardening an Ubuntu 14.04 system. [Vagrant](https://www.vagrantup.com/downloads.html) and [VirtualBox](https://www.virtualbox.org/wiki/Downloads) are required on your local system. All local dependencies will resolved during Vagrant provisioning.

## Usage

The first step is to bring up your Vagrant box: `vagrant up`. This will install Ansible, Packer, and a host of other dependencies.

Once the Vagrant box is up, the next step is to `vagrant ssh`. This will connect you to the Vagrant box. Your local directory is mounted as `/vagrant`, so, make that your current directory: `cd /vagrant`.

Now you are ready to build a hardened Ubuntu 14.04 AMI. You will need your AWS keys to do this, so set these values in your environment:

```
export AWS_ACCESS_KEY_ID="REPLACE"
export AWS_SECRET_ACCESS_KEY="REPLACE"

# the following settings are for the CIAM-Non-Prod account
export DEFAULT_REGION_NAME="us-east-1"
export DEFAULT_VPC_ID="vpc-48da562f"
export DEFAULT_AMI_ID="ami-fce3c696"
export DEFAULT_SUBNET_ID="subnet-693c201f"
export DEFAULT_INSTANCE_TYPE="t2.micro"
```

There is a script `env.sh` that you can use to set these environment variables.

*NOTE: Your AMI must be based on Ubuntu 14.04.*

Now you can run the Packer build. This will use the local version of Ansible that you just installed (via `vagrant up`) to run the playbook.

```
$ sh scripts/build.sh
```

### Tuning the environment

You have to tune the environment to match your security requirements. The default is very restrictive and will perform strong modifications on the system. All requirements are enabled and may not work. For example the rsyslog server address have to be defined to respect the CIS rule.

*Read `default/main.yml` file*

For the CI tests we only create specific files for the environment (see `tests/travis_defaults.yml`) in the `vars/` directory.

### Development

I used Vagrant to test the Ansible playbook. If you wish to tune the defaults or change the tasks, you will probably want to do the same. In this case, there are a few options:

#### Run the playbook during Vagrant provisioning.

This will simulate the Packer build the best. In this case, you will want to uncomment the following stanza in the Vagrantfile:

```
#  config.vm.provision "ansible_local" do |ansible|
#    ansible.playbook = "provisioning/playbook.yml"
#    ansible.sudo = true
#  end

```

#### Run the playbook manually.

In this case, you will `vagrant ssh`, change to the `/vagrant/provisioning` directory and run the following command:

```
$ ansible-playbook -b -u $USER --connection=local -i "127.0.0.1," playbook.yml --become
```

NOTE: The `-C` option will run the playbook *without* modifying the system. This is useful to see what exactly would change - it audits the OS without hardening. If you want to harden, then add the `-C`:

```
$ ansible-playbook -b -C -u $USER --connection=local -i "127.0.0.1," playbook.yml --become
```

## Documentation

The details of each tasks operated on the target system is available in the [online documentation](http://cis-ubuntu-ansible.readthedocs.org/en/latest/). It is build on every commit based on the `docs/` repository content.
