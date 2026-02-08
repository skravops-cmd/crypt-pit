const lengthSlider = document.getElementById('length');
const lengthValue = document.getElementById('length-value');
const uppercaseCheckbox = document.getElementById('uppercase');
const lowercaseCheckbox = document.getElementById('lowercase');
const numbersCheckbox = document.getElementById('numbers');
const symbolsCheckbox = document.getElementById('symbols');
const passwordField = document.getElementById('password');
const copyButton = document.getElementById('copy');

const UPPERCASE = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
const LOWERCASE = 'abcdefghijklmnopqrstuvwxyz';
const NUMBERS = '0123456789';
const SYMBOLS = '!@#$%^&*()_+[]{}|;:,.<>?/`~';

// Function to generate password string
function generatePasswordString() {
  const length = parseInt(lengthSlider.value);
  let chars = '';
  if (uppercaseCheckbox.checked) chars += UPPERCASE;
  if (lowercaseCheckbox.checked) chars += LOWERCASE;
  if (numbersCheckbox.checked) chars += NUMBERS;
  if (symbolsCheckbox.checked) chars += SYMBOLS;

  if (!chars) return '';

  let password = '';
  for (let i = 0; i < length; i++) {
    password += chars.charAt(Math.floor(Math.random() * chars.length));
  }
  return password;
}

// Function to display password in animated blocks
function displayPassword() {
  const password = generatePasswordString();
  passwordField.innerHTML = '';
  for (let i = 0; i < password.length; i += 4) {
    const block = document.createElement('div');
    block.className = 'password-block';
    block.style.animationDelay = `${i * 0.02}s`; // stagger animation
    block.textContent = password.slice(i, i + 4);
    passwordField.appendChild(block);
  }
}

// Update length display and regenerate password
lengthSlider.addEventListener('input', () => {
  lengthValue.textContent = lengthSlider.value;
  displayPassword();
});

// Regenerate password whenever checkboxes change
[uppercaseCheckbox, lowercaseCheckbox, numbersCheckbox, symbolsCheckbox].forEach(cb => {
  cb.addEventListener('change', displayPassword);
});

// Copy password to clipboard
function copyPassword() {
  let password = '';
  passwordField.querySelectorAll('.password-block').forEach(b => password += b.textContent);
  navigator.clipboard.writeText(password);
  copyButton.textContent = 'Copied!';
  setTimeout(() => copyButton.textContent = 'Copy', 1500);
}

passwordField.addEventListener('click', copyPassword);
copyButton.addEventListener('click', copyPassword);

// Initial password on load
displayPassword();
