data "aws_route53_zone" "ec2_record" {
    name = "tom-briggs.com."
    private_zone = false
}

resource "aws_route53_record" "dblog" {
    zone_id = data.aws_route53_zone.ec2_record.zone_id
    name = "dev"
    type = "A"
    ttl = 300
    records = [aws_instance.dblog.public_ip]  
}