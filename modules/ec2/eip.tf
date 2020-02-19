resource "aws_eip" "cluster-eip" {
  instance = "${aws_instance.web.id}"
}