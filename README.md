# Build OpenWrt With GitHub Actions

![GitHub](https://img.shields.io/badge/license-MIT-blue.svg) ![GitHub last commit](https://img.shields.io/github/last-commit/hhai93/Build-OpenWrt-with-GitHub-Actions)

This repository provides a fully automated workflow to build custom OpenWrt firmware using GitHub Actions. It supports scheduled builds, automatic firmware uploads to GitHub Releases, Telegram notifications, and cleanup of old artifacts to comply with GitHub's free tier policies. The setup is inspired by P3TERX/Actions-OpenWrt and is designed to be user-friendly and highly customizable.

## 📋 Features

- 🕒 **Automated Builds**: Build OpenWrt firmware automatically on a schedule or manually.
- 📦 **Firmware Upload**: Uploads `.bin` files to GitHub Releases for easy access.
- 📢 **Notifications**: Sends Telegram notifications when new releases are available.
- 🗑️ **Storage Management**: Deletes old workflow runs and releases to stay within GitHub's free tier limits.
- 🛠️ **Customizable**: Easily modify source repositories, branches, configurations, and scripts.
- 🌏 **Timezone Support**: Asia/Ho_Chi_Minh by default

## 🛠️ Prerequisites

📋 Before setting up the repository, ensure you have:

- 🖥️ A GitHub account with a repository (fork this repo or create a new one).
- 🤖 A Telegram bot token and chat ID for notifications (optional, but recommended).
- 🔑 A GitHub Personal Access Token with `public_repo` scope for releasing artifacts.
- ⚙️ A basic `.config` file for your OpenWrt build (generated via `make menuconfig` or copied from another source).

## 🚀 Getting Started

📋 Before setting up the repository, ensure you have:

- 🖥️ A GitHub account with a repository (fork this repo or create a new one).
- 🤖 A Telegram bot token and chat ID for notifications (optional, but recommended).
- 🔑 A GitHub Personal Access Token with `public_repo` scope for releasing artifacts.
- ⚙️ A basic `.config` file for your OpenWrt build (generated via `make menuconfig` or copied from another source).

## 🛠️ Setup Instructions

📝 Follow these steps to get started:

1. **📂 Fork or Clone the Repository**:

   - 🍴 Fork this repository or create a new one and copy the files from this repo.
   - 📄 Ensure the following files are present:
     - `.github/workflows/build-openwrt.yml`: The main GitHub Actions workflow.
     - `diy-part1.sh`: Custom script for pre-feed updates.
     - `diy-part2.sh`: Custom script for post-feed updates.
     - `.config`: Your OpenWrt configuration file.

2. **🔒 Configure GitHub Secrets**:

   - 🛡️ Navigate to your repository's **Settings &gt; Secrets and variables &gt; Actions &gt; Secrets**.
   - ➕ Add the following secrets:
     - `RELEASES_TOKEN`: A GitHub Personal Access Token with `public_repo` scope. Learn how to create one.
     - `TELEGRAM_TOKEN`: Your Telegram bot token (create via BotFather).
     - `TELEGRAM_TO`: Your Telegram chat ID for notifications (use @userinfobot to find your ID).

3. **🎨 Customize the Workflow**:

   - ✏️ Edit `.github/workflows/build-openwrt.yml` to adjust:
     - `REPO_URL`: The OpenWrt source repository (default: `https://github.com/openwrt/openwrt`).
     - `REPO_BRANCH`: The branch to build (default: `master`).
     - `CONFIG_FILE`: Path to your `.config` file (default: `.config`).
     - `TZ`: Timezone (default: `Asia/Ho_Chi_Minh`).
     - `schedule.cron`: Build schedule (default: weekly on Sundays at midnight UTC).
   - 🛠️ Modify `diy-part1.sh` and `diy-part2.sh` for custom feed sources or settings (e.g., default IP, additional packages).

4. **⚙️ Add Your Configuration**:

   - 📑 Place your `.config` file in the repository root. Generate it locally using `make menuconfig` or via SSH as described in P3TERX's guide.
   - ✅ Ensure the `.config` is compatible with your chosen `REPO_URL`.

5. **▶️ Trigger a Build**:

   - 📤 Push changes to the `main` branch to start a build.
   - 🖱️ Manually trigger a build from the **Actions** tab by selecting **Run workflow**.
   - ⏰ Scheduled builds run automatically based on the `cron` schedule.

## 🔍 Workflow Details

🔧 The workflow (`build-openwrt.yml`) performs the following steps:

 1. **📥 Checkout**: Clones your repository.
 2. **🛠️ Install Dependencies**: Sets up the Ubuntu environment with required tools.
 3. **📦 Clone OpenWrt Source**: Downloads the specified OpenWrt repository and branch.
 4. **⚙️ Load Configuration**: Applies your `.config` file and updates feeds.
 5. **📜 Run DIY Scripts**: Executes `diy-part1.sh` (pre) and `diy-part2.sh` (post).
 6. **🏗️ Build Firmware**: Compiles OpenWrt with parallel jobs, falling back to single-threaded if needed.
 7. **📂 Organize Files**: Collects `.bin` files into a `firmware` directory.
 8. **📤 Upload to Release**: Creates a new GitHub Release tagged `openwrt-<run_number>` with the firmware files.
 9. **📢 Send Notification**: Sends a Telegram message with release details.
10. **🗑️ Cleanup**: Deletes workflow runs older than 7 days (keeping at least 3) and releases beyond the latest 5.

## ⚠️ Troubleshooting

- **🛑 Build Fails**: Check the Actions logs for errors. Ensure your `.config` matches the `REPO_URL`. Run `make V=s` locally to debug.
- **🚫 No Release Created**: Verify `RELEASES_TOKEN` is set correctly and has `public_repo` scope.
- **📢 No Notifications**: Confirm `TELEGRAM_TOKEN` and `TELEGRAM_TO` are correct. Test the Telegram bot manually.
- **💾 Storage Issues**: The workflow deletes old runs and releases. If storage is still an issue, reduce `retain_days` or `keep_latest`.

## 🙌 Credits

- Inspired by P3TERX/Actions-OpenWrt
