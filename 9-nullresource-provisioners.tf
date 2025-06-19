# Create a Null Resource and Provisioners

resource "null_resource" "null" {
  depends_on = [ module.ec2-public-instance]  
  # Connection Block for Provisioners to connect to EC2 Instance (when = create)
  connection {
    type     = "ssh"
    host     = aws_eip.bastion_eip.public_ip
    user     = "ec2-user"
    password = ""
    private_key = file("private/aws-devops-key.pem")    
  }

# File Provisioner: Copies the aws-devops-key.pem file to /tmp/aws-devops-key.pem (when = create)
 provisioner "file" {
    source      = "private/aws-devops-key.pem"
    destination = "/tmp/aws-devops-key.pem"
  }

# Remote Exec Provisioner: Using remote-exec provisioner fix the private key permissions (when = create)
provisioner "remote-exec" {
    inline = [
      "sudo chmod 400 /tmp/aws-devops-key.pem",
    ]
  }

# Local Exec Provisioner: Local-exec provisioner (Creation-Time Provisioner - Triggered Duration) (when = create)
provisioner "local-exec" {
    command = "echo VPC created on `date` and VPC ID : ${module.vpc.vpc_id} >> vpc-creation-date-n-id.txt"
    working_dir = "local-exec-output-files/"
    on_failure = continue
  }

# All the above were Creation Time Provisioners and it is the default behaviour
# If you need to specify a Destroy Time Provisioner then we need to specify;  when = destroy
/*provisioner "local-exec" {
    command = "echo The Destroy date is `date` >> vpc-destroy-date.txt"
    working_dir = "local-exec-output-files/"
    when = destroy
    #on_failure = continue
  } 
*/
}