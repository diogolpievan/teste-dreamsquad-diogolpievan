output frontend_url {
    description = "URL for Service 1 - Frontend"
    value       = "Service 1 - Frontend: ${module.frontend.website_url}" 
}
output backend_url {
    description = "URL for Service 2 - Backend"
    value       = "Service 2 - Backend: ${module.backend.backend_url}"
}
output job_bucket_name {
    description = "Bucket name used by Service 3 - Job"
    value       = "Service 3 - Job: ${module.job.bucket_name}"
}
