# wordpress

##### EFS volume #####
resource "aws_efs_file_system" "fs" {
    tags = {
    Name = "ECS-EFS-FS"
    }
}

##### task definition #####
# describes how a docker container should launch
data "template_file" "task_definition_json" {
    template = "${file("${path.module}/tasks/wp_task_definition.json")}"
}
/*
# It can be thought of as an “instance” of a Task Definition
resource "aws_ecs_task_definition" "wordpress-app" {
    family = "ecs-task-wp"
    
    container_definitions  = "${data.template_file.task_definition_json.rendered}"

    volume {
        name = "service-storage-wp"

        #efs_volume_configuration {
        #    file_system_id = "${aws_efs_file_system.fs.id}"
        #    root_directory = "/var/www/html"
        #    },
        host_path  = "/mnt/efs"

    }
    memory                   = "256"
    cpu                      = "128"
    requires_compatibilities = ["EC2"]  
    network_mode     = "awsvpc"
   
    execution_role_arn = "${aws_iam_role.ecs-ec2-role_.arn}"
}


##### ECS service #####

resource "aws_ecs_service" "wordpress-app" {
    name = "ecs-wp"
    cluster = "${aws_ecs_cluster.ecs-da-migration.id}"
    task_definition = "${aws_ecs_task_definition.wordpress-app.family}"
    #iam_role = "${aws_iam_role.ecs-service-role.name}"
    desired_count = 2
    launch_type   = "EC2"

    # attaching an ELB with an ECS service
    load_balancer {
        target_group_arn = "${aws_alb_target_group.target-group-alb.id}"
        container_name = "da-wp-task"
        container_port = 80
    }
    depends_on = ["aws_alb_listener.albListeners-wp"]

    # providing our containers with public IPs
    network_configuration {
    subnets          = ["${aws_subnet.public-wp-a.id}", "${aws_subnet.public-wp-b.id}"]
    assign_public_ip = true 
    }
}
*/