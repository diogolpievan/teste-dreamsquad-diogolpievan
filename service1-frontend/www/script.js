document.addEventListener('DOMContentLoaded', function() {
  const themeToggle = document.getElementById('theme-checkbox');
  const savedTheme = localStorage.getItem('theme') || 'light';
  
  // Aplicar tema salvo
  if (savedTheme === 'dark') {
    document.documentElement.setAttribute('data-theme', 'dark');
    themeToggle.checked = true;
  }
  
  // Ouvinte de mudança no toggle
  themeToggle.addEventListener('change', function() {
    if (this.checked) {
      document.documentElement.setAttribute('data-theme', 'dark');
      localStorage.setItem('theme', 'dark');
    } else {
      document.documentElement.removeAttribute('data-theme');
      localStorage.setItem('theme', 'light');
    }
  });
});
