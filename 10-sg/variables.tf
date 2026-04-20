variable "project" {
    type = string
    default = "roboshop"
}
variable "environment" {
    type = string
    default = "dev"
}
variable "sg_names" {
    type = list
    default = [
        
        #Frontend-ALD
        "frontend_alb",
        #Bastion
        "bastion",
        #open vpn
        "openvpn",
        "eks_control_plane" ,
        "eks_node"
    ]
}