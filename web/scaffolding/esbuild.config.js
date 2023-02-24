import * as esbuild from 'esbuild'

await esbuild.build({
	entryPoints: ['src/scripts/index.ts'],
	inject: ['src/scripts/graph.ts', 'src/scripts/lib.ts'],
	bundle: true,
	outfile: 'dist/scripts/index.js',
	treeShaking: true,
	tsconfig: './tsconfig.json',
	drop: ['console', 'debugger']
})