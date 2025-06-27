# 🛠️ sh-peercode-iac

> Infrastructure as Code (IaC) for the PeerCode platform — automate your cloud-native, self-hosted development environment with K3s, Terraform, and GitHub Actions.

---

## 📦 Overview

This repository manages the infrastructure setup for the **PeerCode** project using a combination of:

- 🧱 **Terraform** – declarative infrastructure provisioning
- 🐳 **K3s** – lightweight Kubernetes for edge/development clusters
- ☁️ **Cloudflare Tunnel** – secure public ingress to private services
- 🤖 **GitHub Self-Hosted Runners** – CI/CD execution on private VM
- 📦 **Docker Image Management** – build, export, and import to remote VMs

---

## 🚀 Features

- 📦 Deploy Kubernetes workloads with `Deployment`, `Service`, and `Ingress`
- 🔐 Expose internal services via Cloudflare Tunnel
- ⚙️ Use GitHub Actions with self-hosted runners for fast CI/CD
- 🔁 Automate Docker build, save as `.tar`, and import to remote containerd
- 🧩 Modular Terraform for flexible provisioning
- 🧪 Dev namespace isolation for safe testing

---

## 🧰 Stack

| Tool                | Purpose                          |
|---------------------|----------------------------------|
| Terraform           | Infrastructure provisioning      |
| K3s                 | Lightweight Kubernetes cluster   |
| Docker              | Build and export app containers  |
| containerd          | Runtime on target VMs            |
| Cloudflare Tunnel   | Secure public access             |
| GitHub Actions      | CI/CD pipelines                  |

---
