# Build OpenWrt With GitHub Actions

![GitHub](https://img.shields.io/badge/license-MIT-blue.svg) ![GitHub last commit](https://img.shields.io/github/last-commit/hhai93/Build-OpenWrt-With-GitHub-Actions)
This repository automates building custom OpenWrt firmware using GitHub Actions, inspired by [P3TERX/Actions-OpenWrt](https://github.com/P3TERX/Actions-OpenWrt). It supports scheduled builds, firmware uploads to GitHub Releases, Telegram notifications. The setup is highly customizable and user-friendly.

---

## ✨ Features

- 🕒 **Scheduled Builds**: Run builds automatically or manually.
- 📦 **Firmware Upload**: Publishes `.bin` and `.img` files to GitHub Releases and Artifacts.
- 📢 **Notifications**: Sends Telegram alerts for new releases.
- 🗑️ **Storage Cleanup**: Removes old runs and releases to save space.
- 🛠️ **Customizable**: Adjust source, branch, config, and DIY scripts easily.
- 🔒 **SSH Access**: Interactive `make menuconfig` via SSH for advanced configuration.

---

## ✅ Prerequisites

📋 Ensure you have:

- 🖥️ A GitHub account and repository (fork this repo or create a new one).
- 🤖 A Telegram bot token and chat ID (optional, via [BotFather](https://t.me/BotFather)).
- 🔑 A GitHub Personal Access Token with `public_repo` scope.
- ⚙️ An OpenWrt `.config` file (generate via `make menuconfig` or copy from another source).

---

## 🛠️ Setup Instructions

📝 Follow these steps:

1. **📂 Fork or Clone Repository**:
   - 🍴 Fork this repository or create a new one with these files:
     - `.github/workflows/build-openwrt.yml`: Main workflow.
     - `diy-part1.sh`: Pre-feed customizations.
     - `diy-part2.sh`: Post-feed customizations.
     - `.config`: Your OpenWrt configuration.
   - 📄 Verify file presence in the repository root.

2. **🔒 Set GitHub Secrets**:
   - 🛡️ Go to **Settings > Secrets and variables > Actions > Secrets**.
   - ➕ Add:
     - `RELEASES_TOKEN`: GitHub Personal Access Token (`public_repo` scope). [Guide](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token).
     - `TELEGRAM_TOKEN`: Telegram bot token.
     - `TELEGRAM_ID`: Telegram chat ID (use [@userinfobot](https://t.me/userinfobot)).

3. **🎨 Customize Workflow**:
   - ✏️ Edit `.github/workflows/build-openwrt.yml`:
     - `REPO_URL`: OpenWrt source (default: `https://github.com/openwrt/openwrt`).
     - `REPO_BRANCH`: Branch (default: `master`).
     - `CONFIG_FILE`: Config file path (default: `.config`).
     - `DIY_P1_SH`/`DIY_P2_SH`: Custom script paths.
     - `TZ`: Timezone (default: `Asia/Ho_Chi_Minh`).
     - `schedule.cron`: Build schedule (default: weekly Sundays, midnight UTC).
   - 🛠️ Modify `diy-part1.sh` (e.g., add feeds) and `diy-part2.sh` (e.g., change IP).

4. **⚙️ Add Configuration**:
   - 📑 Place `.config` in the repository root. Generate via `make menuconfig` locally or use SSH (see below).
   - ✅ Ensure `.config` matches `REPO_URL` to avoid build failures.

5. **▶️ Trigger Build**:
   - 📤 Push to `main` branch to start a build.
   - 🖱️ Manually trigger via **Actions > Build OpenWrt > Run workflow** (set `SSH connection to Actions` to `true` for SSH access).
   - ⏰ Scheduled builds run per `cron` schedule.

---

## 🔍 Workflow Details

🔧 The workflow (`build-openwrt.yml`) executes:

1. **📥 Checkout**: Clones repository.
2. **💾 Maximize Space**: Frees disk space for large builds.
3. **🛠️ Install Dependencies**: Sets up Ubuntu with OpenWrt build tools.
4. **🔒 SSH Access**: Enables `tmate` SSH for interactive configuration (if enabled).
5. **📦 Clone Source**: Downloads OpenWrt source (`REPO_URL`, `REPO_BRANCH`).
6. **📜 Update Feeds**: Runs `diy-part1.sh`, updates feeds, runs `diy-part2.sh`.
7. **⚙️ Load Config**: Applies `.config` and runs `make defconfig`.
8. **⬇️ Download Packages**: Fetches package sources.
9. **🏗️ Build Firmware**: Compiles OpenWrt, retrying single-threaded if needed.
10. **📂 Organize Files**: Collects `.bin`/`.img` into `firmware` directory.
11. **📤 Upload Artifacts**: Stores firmware as GitHub Artifacts (1-day retention)
12. **🏷️ Generate Release Tag**: Creates a dated tag (e.g., `2025.04.17`).
13. **📦 Upload Release**: Publishes firmware to GitHub Releases.
14. **📢 Send Notification**: Notifies via Telegram.
15. **🗑️ Cleanup**: Deletes old runs (>7 days, keeps 3) and releases (>5 latest).

---

## 🎨 Customization

- **🌐 Source Repo**: Set `REPO_URL` to OpenWrt, ImmortalWrt, etc.
- **⏰ Build Frequency**: Change `cron` (e.g., `'0 0 * * *'` for daily).
- **📜 DIY Scripts**: Add to `diy-part1.sh` (feeds) or `diy-part2.sh` (settings).
- **🌍 Timezone**: Update `TZ` (e.g., `America/New_York`).
- **🚫 Disable Features**: Set `UPLOAD_FIRMWARE` or `UPLOAD_RELEASE` to `false`.
- **🔒 SSH Access**: Enable `ssh` input for `make menuconfig`.

---

## 🔐 SSH Access Setup

🔧 Use SSH to debug or run `make menuconfig` interactively:

1. **▶️ Trigger Workflow with SSH**:
   - 🖱️ In the **Actions** tab, select **Build OpenWrt** and click **Run workflow**.
   - ✅ Set `SSH connection to Actions` to `true` in the form.
   - 🚀 Click **Run workflow**.

2. **📜 Get SSH Command**:
   - 📂 Open the running workflow’s **build** job in the **Actions** tab.
   - 🔍 Expand the **SSH connection to Actions** step.
   - 📋 Copy the `SSH` command (e.g., `ssh 123abc@ny4.tmate.io`) or note the `Web` URL.

3. **🔗 Connect via SSH**:
   - 💻 In a terminal, run the SSH command (e.g., `ssh 123abc@ny4.tmate.io`).
   - 🌐 Alternatively, open the `Web` URL (e.g., `https://tmate.io/t/123abc`) in a browser.
   - 🛠️ Interact with the runner (e.g., `cd openwrt; make menuconfig` after cloning).

4. **🏁 Exit SSH**:
   - 🚪 Run `exit` to close the SSH session and resume the workflow.
   - 🔄 Keep the session open for debugging while the workflow runs (use `detached: true` for background SSH).

**Tips**:
- Press `Ctrl+C` in the log viewer if the SSH command doesn’t appear.
- Save `.config` to `$GITHUB_WORKSPACE` (e.g., `cp openwrt/.config $GITHUB_WORKSPACE/.config`).

---

## ⚠️ Troubleshooting

- **🛑 Build Fails**: Check Actions logs. Verify `.config` compatibility with `REPO_URL`. Run `make V=s` locally to debug.
- **🚫 No Release**: Ensure `RELEASES_TOKEN` has `public_repo` scope.
- **📢 No Notifications**: Validate `TELEGRAM_TOKEN` and `TELEGRAM_ID`. Test bot manually.
- **💾 Storage Full**: Cleanup retains 7 days of runs and 5 releases. Reduce `retain_days` or `keep_latest` if needed.
- **🔒 SSH Issues**: If `tmate` fails, check logs for SSH command or URL.

---

## 🙌 Credits

- 🌟 P3TERX/Actions-OpenWrt for the original template and guide.
- 🤝 OpenWrt community for their excellent contributions.
