// GitHub Repo Info
const user = "TMTCo";
const repo = "scripts";

// Fetch file list from the GitHub API
async function fetchScripts() {
  const url = `https://api.github.com/repos/${user}/${repo}/contents`;
  const list = document.getElementById("script-list");
  list.innerHTML = "<li>Loading...</li>";

  try {
    const res = await fetch(url);
    if (!res.ok) throw new Error("GitHub API error");
    const files = await res.json();

    const scriptFiles = files.filter(file => file.type === "file");
    list.innerHTML = "";

    if (scriptFiles.length === 0) {
      list.innerHTML = "<li>No scripts found.</li>";
      return;
    }

    scriptFiles.forEach(file => {
      const li = document.createElement("li");
      const a = document.createElement("a");
      a.href = file.html_url;
      a.target = "_blank";
      a.textContent = file.name;
      li.appendChild(a);
      list.appendChild(li);
    });
  } catch (err) {
    list.innerHTML = `<li>Error loading scripts: ${err.message}</li>`;
  }
}

// Dark mode toggle
function setupThemeToggle() {
  const toggle = document.getElementById("theme-toggle");
  const prefersDark = window.matchMedia("(prefers-color-scheme: dark)").matches;
  const stored = localStorage.getItem("theme");

  if (stored === "dark" || (!stored && prefersDark)) {
    document.body.classList.add("dark");
  }

  toggle.addEventListener("click", () => {
    document.body.classList.toggle("dark");
    const isDark = document.body.classList.contains("dark");
    localStorage.setItem("theme", isDark ? "dark" : "light");
    toggle.textContent = isDark ? "☀️" : "🌙";
  });

  toggle.textContent = document.body.classList.contains("dark") ? "☀️" : "🌙";
}

document.addEventListener("DOMContentLoaded", () => {
  fetchScripts();
  setupThemeToggle();
});
