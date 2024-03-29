module.exports = {
  mode: 'jit',
  purge: [
    './app/views/**/*.html.slim',
    './app/packs/**/*.{js,jsx,ts,tsx,css}'
  ],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {},
  },
  variants: {
    extend: {},
  },
  plugins: [
    require('@tailwindcss/typography'),
    require('@tailwindcss/forms'),
  ],
}
