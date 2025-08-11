module "frontend" {
    source      = "./service1-frontend"
}
module "backend" {
    source      = "./service2-backend"
}
module "job" {
    source      = "./service3-job"
}
