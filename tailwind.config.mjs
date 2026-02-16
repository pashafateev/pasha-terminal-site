/** @type {import('tailwindcss').Config} */
export default {
  content: ['./src/**/*.{astro,html,js,jsx,md,mdx,svelte,ts,tsx,vue}'],
  theme: {
    extend: {
      fontFamily: {
        mono: ['"JetBrains Mono"', 'ui-monospace', 'SFMono-Regular', 'Menlo', 'monospace'],
      },
      colors: {
        term: {
          bg: 'var(--term-bg)',
          fg: 'var(--term-fg)',
          green: 'var(--term-green)',
          dim: 'var(--term-dim)',
          blue: 'var(--term-blue)',
          red: 'var(--term-red)',
          yellow: 'var(--term-yellow)',
          dotgreen: 'var(--term-green-dot)',
        },
      },
      animation: {
        'cursor-blink': 'cursor-blink 1s step-end infinite',
        'terminal-glow': 'terminal-glow 2s ease-in-out infinite alternate',
      },
      keyframes: {
        'cursor-blink': {
          '0%, 49%': { opacity: '1' },
          '50%, 100%': { opacity: '0' },
        },
        'terminal-glow': {
          from: { boxShadow: '0 0 0 rgba(57, 255, 20, 0)' },
          to: { boxShadow: '0 0 20px rgba(57, 255, 20, 0.08)' },
        },
      },
    },
  },
  plugins: [
    require('@tailwindcss/typography'),
  ],
}
