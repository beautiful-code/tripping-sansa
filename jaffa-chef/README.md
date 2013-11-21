##Getting started with vagrant-aws :

###Step 1 : Create a Vagrantfile and bring the instance up

	$ vi Vagrantfile

The contents of the 'Vagrantfile' :

	Vagrant.configure("2") do |config|
	 
	  config.vm.box = "vagrant_aws"
	  config.vm.box_url = "https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box"

	  config.vm.provider :aws do |aws, override|  
	    aws.security_groups = [ 'vagrant-singapore' ]    
	    aws.access_key_id = "XXXXXXXXXXXXXXXXXXXXXXX"
	    aws.secret_access_key = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
	    aws.keypair_name = "<key_singapore>"
	    aws.region = 'ap-southeast-1' #Default is N.Virginia
	    #aws.ami = "ami-0145d268" #AMI for us-east-1
	    aws.ami = "ami-02612a50" #AMI for ap-southeast-1
	    aws.instance_type = "t1.micro" #Default is small
	    override.ssh.username = "ubuntu"
	    override.ssh.private_key_path = "/home/ubuntu/.ssh/key_singapore.pem" 
	  end
	  
	  config.vm.define :xyz_node do 
	  end
	end

Now we have to bring the instance up by using the --provider argument for the vagrant. 
	
	$ vagrant up --provider=aws

You should see something similar to this.
	
	[vagrant_node] Warning! The AWS provider doesn't support any of the Vagrant
	high-level network configurations (`config.vm.network`). They
	will be silently ignored.
	[vagrant_node] Launching an instance with the following settings...
	[vagrant_node]  -- Type: t1.micro
	[vagrant_node]  -- AMI: ami-02612a50
	[vagrant_node]  -- Region: ap-southeast-1
	[vagrant_node]  -- Keypair: key_singapore
	[vagrant_node]  -- Security Groups: ["vagrant-singapore"]
	[vagrant_node]  -- Block Device Mapping: []
	[vagrant_node]  -- Terminate On Shutdown: false
	[vagrant_node] Waiting for instance to become "ready"...
	[vagrant_node] Waiting for SSH to become available...
	[vagrant_node] Machine is booted and ready for use!
	[vagrant_node] Rsyncing folder: /home/itsprdp/git/jaffa/vagrant-aws/ => /vagrant

###Step 2: Initialise the directory for using cookbooks
	
	$ knife solo init . 

	Creating kitchen...
	Creating knife.rb in kitchen...
	Creating cupboards...
	Setting up Berkshelf...

Basically this creates knife.rb which is a knife configuration file and few directories for 
creating cookbooks, roles and nodes.

###Step 3 : Install the required cookbooks via Berkshelf

	$ vi Berksfile

The contents of the file:

	site :opscode

	cookbook 'apt'
	cookbook 'git'
	cookbook 'nginx'
	cookbook 'mongodb'


###Step 4 : SSH Keys

Generate the private key and copy the public key to the instance. 

	$ ssh-keygen -t rsa -C "<abc@xyz.com>"

This generates the files in the default directory `~/.ssh/`. `id_rsa` is a private key and 
`id_rsa.pub` is a public key. Now we should copy the contents of the `id_rsa.pub` file and add it to 
the authorised_keys file in the ec2 instance.

	$ xclip -sel clip < ~/.ssh/id_rsa.pub  \#You should install xclip with apt-get to use it

Now the public key is copied to the clipboard. We should login to the ec2 instance shell.
	
	$ vagrant ssh

We are inside the ec2 ubuntu instance. Now we shall paste the copied key.

	$ vi ~/.ssh/authorized_keys

###Step 5 : Prepare the ec2 instance by knife solo prepare

Now we need to prepare the box to run our chef recipes.

	$ knife solo prepare ubuntu@xxx.xxx.xxx.xxx

	Bootstrapping Chef...
	  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
	                                 Dload  Upload   Total   Spent    Left  Speed
	100  6790  100  6790    0     0   5333      0  0:00:01  0:00:01 --:--:--  5359
	Downloading Chef 11.4.4 for ubuntu...
	Installing Chef 11.4.4
	Selecting previously unselected package chef.
	(Reading database ... 52228 files and directories currently installed.)
	Unpacking chef (from .../chef_11.4.4_amd64.deb) ...
	Setting up chef (11.4.4-2.ubuntu.11.04) ...
	Thank you for installing Chef!
	Generating node config 'nodes/XXX.XXX.XXX.XXX.json'...

The knife prepare command installs the chef on the node and configure the instance to cook our recipes.
It automatically creates a file named with the IP address under the `nodes/` directory with an empty runlist.
In this file we need to add our recipes to the runlist.

Note: The IP address of the ec2 instance should be noted from the aws web console.
If you are not using the Elastic IP address then this IP address may vary every time you restart the
instance.

step 6 : Add recipes to the run list of the node

	$ vi nodes/XXX.XXX.XXX.XXX.json

	{
		"run_list":[
			"recipe[apt]"
		]
	}

After adding the recipes to the runlist of the node's json file we shall cook using the `knife solo cook`.

Step 7 : Cook the node with the recipes


	$ knife  solo cook ubuntu@xxx.xxx.xxx.xxx


	Running Chef on 54.254.137.190...
	Checking Chef version...
	Installing Berkshelf cookbooks to 'cookbooks'...
	Using apt (2.3.0)
	Using yum (2.4.2)
	Using windows (1.11.0)
	Using chef_handler (1.1.4)
	Using runit (1.4.0)
	Using bluepill (2.3.0)
	Using rsyslog (1.9.0)
	Using ohai (1.1.12)
	Using python (1.4.4)
	Using aws (1.0.0)
	Uploading the kitchen...
	Generating solo config...
	Running Chef...
	Starting Chef Client, version 11.4.4
	Compiling Cookbooks............
	...............................
