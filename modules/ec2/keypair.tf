resource "aws_key_pair" "keypair" {
  key_name   = "${var.environment}-key"
  //TODO move to env variables
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDixvfrp4Qf5aA1/G2o0U+aTkc5lqWiP/DSpr7mu6F97IJpQyqWbYLoydYd4I5kpKgowrhnY55raWK/3Y3fv4juyRzaH1uIAriulqPdWfqnI2rNaV0tyTyqd188CfRvLNFcXu40KFH6rR7cL/LnnlXkQF7/AvHrWSXn+XfPR4OdBaro0rnKMcKpn5e1NuhvLf5NhjyyXfHx/z9+Q+Gun+fBZRjhW+w1QxzvuEp4g0eNKsdK8Qycu9pUcz0SBGWH6kfl5nSnicNEg0X7e4rnHDcqVAJCkg2Iv+vfi0L0Ex8RJfoIGAxj7gLjFn5cJY4b7WnBB3d8SQOUg5A/WF2HvM97 fetilla@Rafa-PC"
}