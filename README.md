# 📊 Stocet - Stock, Bond & CMSP Explorer

**Stocet** is a Flutter mobile app designed to help users explore key elements of Ethiopia’s capital market: **Stocks**, **Bonds**, and **Capital Market Service Providers (CMSPs)**, and make investment decisions with a **Mini Investment Advisor** feature.

Built with 💙 Flutter and ⚙️ Riverpod, this app is modular, cleanly structured, and fully offline using mock data.

---

## ✅ Features

- 📈 **Stock List Page** – View and sort Ethiopian stocks by performance.
- 💵 **Bond List Page** – Explore bonds with coupon rate and maturity filters.
- 🏢 **CMSP Explorer** – Discover registered capital market service providers with detailed educational profiles.
- 🧠 **Mini Investment Advisor** – Calculate optimal asset allocation and expected return based on your capital and investor profile.
- 🌗 Built-in light/dark support (WIP).
- 💻 Works fully offline with local JSON data.

---

## 📸 Screenshots

### 1️⃣ Task 1: Stock Sorting & Viewing

- ✅ Sorted stock list with performance data

![Stock Sort](assets/screenshots/task1_sortby.png)  
![Stock List](assets/screenshots/task1_stock.png)

---

### 2️⃣ Task 2: Bond List Filter

- ✅ Browse bonds by coupon rate and maturity

![Bond List](assets/screenshots/task2_bond.png)

---

### 3️⃣ Task 3: CMSP Explorer

- ✅ List and detail view for Ethiopian Capital Market Service Providers (CMSPs)

![CMSP Explorer](assets/screenshots/task3_cmsp.png)

---

### 4️⃣ Task 4: Mini Investment Advisor

- ✅ 3-step flow to set capital, view allocation, and see projected returns
- ✅ Auto allocation logic based on Active/Passive investor types
- ✅ Visual breakdown and success/failure goal indication

![Setup Screen](assets/screenshots/task4_setup.png)  
![Allocation Screen](assets/screenshots/task4_allocation.png)  
![Result Screen](assets/screenshots/task4_result.png)

---

## 🗂 Folder Structure

```bash
lib/
├── main.dart
├── models/           # Data models (Stock, Bond, CMSP, Portfolio)
├── providers/        # Riverpod providers
├── screens/          # All pages (Stock, Bond, CMSP, Portfolio)
├── widgets/          # Reusable UI components
└── assets/
    └── data/         # Local mock JSON files
    └── screenshots/  # App screenshots
