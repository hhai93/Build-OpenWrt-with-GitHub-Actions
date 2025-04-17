# 🚀 Build OpenWrt With GitHub Actions

![GitHub](https://img.shields.io/badge/license-MIT-blue.svg) ![GitHub last commit](https://img.shields.io/github/last-commit/hhai93/Build-OpenWrt-with-GitHub-Actions)

This repository provides a template to build custom OpenWrt firmware using GitHub Actions. With this setup, you can automate the build process, upload firmware to GitHub Releases, generate changelogs, send Telegram notifications, schedule builds, and clean up old artifacts—all within the limits of a free GitHub account. Let's get started! 🌟

## 📋 Features

- **Automated Builds**: Build OpenWrt firmware with GitHub Actions. 🛠️
- **Upload to Releases**: Automatically upload `.bin` files to GitHub Releases. 📦
- **Changelog Generation**: Create changelogs from commit messages. 📝
- **Telegram Notifications**: Get notified via Telegram when a new release is available. 📲
- **Scheduled Builds**: Run builds weekly or on a custom schedule. ⏰
- **Clean Old Artifacts/Releases**: Automatically delete old artifacts and releases to save space. 🗑️
- **Free Tier Compliance**: Works within GitHub Free limits (2,000 minutes/month, 500MB storage). ✅

## 🛠️ Prerequisites

To use this template, you need:

- A **GitHub account** (Free tier is sufficient).
- A **Telegram bot** and chat ID for notifications (optional but recommended).
- Basic knowledge of OpenWrt and GitHub Actions. 🧠
- A `.config` file for your OpenWrt build (you can generate one using `make menuconfig`).

## 🚀 Getting Started

### 1. Create Your Repository

- Click the **Use this template** button on this repository to create your own. 🖱️
- Name your repository (e.g., `My-OpenWrt-Build`) and make it **public** (required for free GitHub Actions).

### 2. Add Your `.config` File

- Generate an OpenWrt `.config` file using OpenWrt source or your preferred source. 📄
  - Run `make menuconfig` locally or use SSH in Actions (see Advanced Usage).
- Push the `.config` file to your repository's root directory.
- Optionally, customize the build by editing environment variables in `.github/workflows/build-openwrt.yml`.

### 3. Configure GitHub Secrets

Some features require secrets to be set in your repository:

1. Go to **Settings &gt; Secrets and variables &gt; Actions &gt; Secrets**.
2. Add the following secrets:
   - `RELEASES_TOKEN`: Your GitHub Personal Access Token (PAT) with `public_repo` scope.
     - Create one at **Settings &gt; Developer settings &gt; Personal access tokens**.
   - `TELEGRAM_TOKEN`: Your Telegram bot token (get one from @BotFather).
   - `TELEGRAM_TO`: Your Telegram chat ID (use @GetIDBot to find it).

### 4. Customize the Workflow

Open `.github/workflows/build-openwrt.yml` to configure your build:

- **Source Repository**: Change `REPO_URL` and `REPO_BRANCH` to your preferred OpenWrt source.
- **Upload Options**:
  - Set `UPLOAD_RELEASE` to `true` to upload `.bin` files to GitHub Releases.
- **Scheduled Builds**:
  - Uncomment the `schedule` section to enable schedule builds (e.g., every Friday at 4 PM UTC+8).
  - Example:

    ```yaml
    schedule:
      - cron: '0 8 * * 5' # Friday 16:00 UTC+8
    ```
- **Changelog**: The workflow uses commit messages to generate a changelog.
- **Clean Old Releases**: The workflow deletes releases older than 5 builds to stay within storage limits.

### 5. Run the Build

- Go to the **Actions** tab in your repository.
- Select **Build OpenWrt** and click **Run workflow**. 🏃‍♂️
- The build may take 1–2 hours depending on your configuration. ☕
- When complete, download the firmware from:
  - **Artifacts**: Click the **Artifacts** button in the Actions tab.
  - **Releases**: Check the **Releases** tab for uploaded `.bin` files.

## 📡 Advanced Usage

### SSH Access for Customization

- Enable SSH by setting `SSH_CONNECTION` to `true` in the workflow file.
- Use tmate to connect to the Actions environment and run `make menuconfig` interactively.

### Custom DIY Scripts

- Add custom scripts (e.g., `diy.sh`) to modify the build process.
- Update `DIY_SH` in the workflow file to point to your script.

### Multiple Architectures

- Create multiple workflow files (e.g., `k2p.yml`, `x64.yml`) for different devices.
- Update `CONFIG_FILE` and `DIY_SH` in each file to use different `.config` files.

### Telegram Notifications

- The workflow sends a message to your Telegram chat when a release is created.
- Customize the message in the workflow file under the `telegram-notify` step.

### Clean Old Artifacts

- The workflow uses actions/delete-workflow-runs to delete old runs.
- Configure retention days in the workflow file (default: 7 days).

## ⚠️ GitHub Free Limits

- **Compute**: 2,000 minutes/month (enough for \~10–15 builds).
- **Storage**: 500MB for artifacts/releases. The cleanup feature ensures compliance.
- **Concurrency**: Free accounts support 20 concurrent jobs, ideal for multi-architecture builds.

## 🗑️ Troubleshooting

- **Build Fails**: Check the Actions logs for errors. Common issues include invalid `.config` or missing dependencies.
- **No Artifacts**: Ensure `UPLOAD_FIRMWARE` is `true` in the workflow.
- **Telegram Not Working**: Verify `TELEGRAM_TOKEN` and `TELEGRAM_TO` secrets.
- **Storage Full**: Increase cleanup frequency in the workflow.

## 🙌 Credits

- Inspired by P3TERX/Actions-OpenWrt

## 📜 License

This project is licensed under the MIT License. See LICENSE for details.

---

⭐ **Star this repo** to support the project and trigger a build (if enabled)! Let's build awesome OpenWrt firmware together! 🎉
