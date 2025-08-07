module "frontend" {
    source      = "./service1-frontend"
    bucket_name = "dreamsquad-frontend-site"
}
module "backend" {
    source      = "./service2-backend"
    app_name    = "dreamsqua-backend-api"
}
module "job" {
    source      = "./service3-job"
    bucket_name = "dreamsquad-job-output"
}
