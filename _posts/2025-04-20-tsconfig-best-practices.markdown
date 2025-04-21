---
layout: post
title:  "TypeScript configuration best practices"
date:   2025-04-20 23:38:39 -0700
categories: JavaScript
---

TypeScript has become the backbone of modern JavaScript development, offering type safety and enhanced developer experience across a variety of environments. However, configuring TypeScript correctly for your specific use case can be challenging. In this post, I'll break down the optimal TypeScript configurations for different scenarios and provide practical recommendations for your `tsconfig.json` and `package.json` files.

### Understanding the Key Configuration Options

Before diving into specific recommendations, let's understand the most critical configuration options:

- **`target`**: Specifies the ECMAScript version your TypeScript code will be transpiled to. This affects which JavaScript features will be downleveled (transformed to work in older environments) and which will be preserved as-is.
- **`module`**: Determines the module system for the output JavaScript (CommonJS, ESM, etc.). This affects how imports and exports are transformed in the compiled code.
- **`moduleResolution`**: Controls how TypeScript resolves import statements, determining where and how the compiler looks for imported modules.

### Configuration Recommendations by Environment

**Modern Node.js Applications**

For modern Node.js applications (v16+), the optimal configuration is:

```json
{
  "compilerOptions": {
    "target": "ESNext",
    "module": "NodeNext",
    "moduleResolution": "NodeNext",
    "esModuleInterop": true,
    "sourceMap": true,
    "strict": true
  }
}
```

**Reasoning:**
- **target: ESNext** - This setting tells TypeScript to target the latest ECMAScript version available. Modern Node.js has excellent support for the latest JavaScript features, so using ESNext allows you to take advantage of all available language features without unnecessary downleveling, producing cleaner and more efficient output code.
- **module: NodeNext** - This setting produces code compatible with Node.js's native ES modules implementation. It's the recommended setting for modern Node.js and ensures proper interoperability with the Node.js module system.
- **moduleResolution: NodeNext** - This matches the module resolution algorithm used by Node.js itself, ensuring TypeScript resolves imports the same way Node.js will at runtime.

Your `package.json` should include:

```json
{
  "type": "module",
  "engines": {
    "node": ">=22.14.0"
  }
}
```

For slightly older Node.js versions (v14), use:

```json
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "Node16",
    "moduleResolution": "Node16"
    // other options remain the same
  }
}
```

With a corresponding `package.json`:

```json
{
  "type": "module",
  "engines": {
    "node": ">=14.17.0"
  }
}
```

**Reasoning:**
- **target: ES2020** - Node.js 14 supports most ES2020 features, so we target this version to balance modern features with compatibility.
- **module: Node16** - While this seems counterintuitive for Node.js 14, it's appropriate because it was designed to support Node.js's implementation of ES modules as it existed in Node.js 16, which is largely compatible with Node.js 14.
- **moduleResolution: Node16** - Similarly, this uses a module resolution strategy that's compatible with Node.js 14 while supporting ES modules.

**Browser Applications**

For modern browser applications using a bundler like Webpack, Rollup, or Vite:

```json
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "ESNext",
    "moduleResolution": "Bundler",
    "lib": ["DOM", "DOM.Iterable", "ESNext"],
    "noEmit": true,
    "strict": true
  }
}
```

**Reasoning:**
- **target: ES2020** - Modern browsers support ES2020 features well, giving a good balance between modern syntax and broad compatibility. Your bundler can further transform this if needed based on your browserslist configuration.
- **module: ESNext** - This generates the most modern module syntax, which your bundler will then process. Bundlers work best with ESNext modules as input since they can better optimize the code.
- **moduleResolution: Bundler** - This newer option is specifically designed for projects using modern bundlers. It understands bundler-specific resolution techniques like package exports, import conditions, and subpath imports.

If you need to support older browsers like IE11:

```json
{
  "compilerOptions": {
    "target": "ES5",
    "module": "ESNext",
    "moduleResolution": "Bundler"
    // other options remain the same
  }
}
```

**Reasoning:**
- **target: ES5** - IE11 and other legacy browsers don't support ES6+ features, so we target ES5 to ensure compatibility. The bundler will include necessary polyfills.
- **module: ESNext** - We still use ESNext here because the bundler, not the browser, will process these imports. The bundler will transform them to a format compatible with older browsers.
- **moduleResolution: Bundler** - The resolution strategy doesn't change since it only affects how TypeScript finds modules during compilation, not the runtime behavior.

For React applications, add a `browserslist` configuration to your `package.json`:

```json
{
  "type": "module",
  "browserslist": {
    "production": [">0.2%", "not dead", "not op_mini all"],
    "development": ["last 1 chrome version", "last 1 firefox version", "last 1 safari version"]
  }
}
```

### Libraries and Packages

Creating libraries requires careful consideration of how your code will be consumed.

**Dual-Module Libraries (ESM/CJS)**

For libraries that need to support both ESM and CommonJS:

```json
// tsconfig.json
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "ESNext",
    "moduleResolution": "NodeNext",
    "declaration": true,
    "lib": ["DOM", "DOM.Iterable", "ESNext"],
    "strict": true
  }
}
```

**Reasoning:**
- **target: ES2020** - This provides a good balance between modern features and compatibility. Since libraries need to work in various environments, ES2020 is a safe choice that supports most modern features while being widely compatible.
- **module: ESNext** - Using ESNext for the primary build allows TypeScript to generate the most modern module format, which can then be processed into other formats (like CommonJS) during the build process.
- **moduleResolution: NodeNext** - This ensures your package works well in Node.js environments while still supporting ESM. It's crucial for dual-module packages because it understands both CommonJS and ESM resolution rules, including package.json exports.

Your `package.json` should include:

```json
{
  "type": "module",
  "main": "./dist/index.cjs",
  "module": "./dist/index.js",
  "types": "./dist/index.d.ts",
  "exports": {
    ".": {
      "import": "./dist/index.js",
      "require": "./dist/index.cjs",
      "types": "./dist/index.d.ts"
    }
  },
  "sideEffects": false
}
```

This configuration provides entry points for both module systems, and the `exports` field gives precise control over what files consumers can import.

For build scripts, consider:

```json
{
  "scripts": {
    "build:esm": "tsc --outDir dist",
    "build:cjs": "tsc --module commonjs --outDir dist/cjs",
    "build": "npm run build:esm && npm run build:cjs && node scripts/create-package-json.js"
  }
}
```

Where `scripts/create-package-json.js` creates a `package.json` in the dist/cjs directory with `{"type": "commonjs"}`.

### Special Cases

**Electron Applications**

For Electron apps:

```json
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "NodeNext",
    "moduleResolution": "NodeNext"
    // other options remain the same
  }
}
```

**Reasoning:**
- **target: ES2020** - Electron uses relatively recent versions of Node.js and Chromium, so ES2020 is well-supported and provides a good balance of features.
- **module: NodeNext** - Electron's main process is essentially Node.js, so using NodeNext ensures compatibility with Node.js's module system while supporting ESM.
- **moduleResolution: NodeNext** - This aligns with how the main process resolves modules in Electron, which follows Node.js resolution rules.

This works well because the main process uses Node.js while the renderer process is browser-based. You might have separate configurations for the renderer process if it has significantly different requirements.

### Monorepos with Mixed Environments

For monorepos with both Node.js backend and browser frontend, use separate `tsconfig.json` files for each part. A common approach is to have:

1. A base `tsconfig.json` with shared settings
2. Extended configurations for specific environments

**Reasoning:**
- Different parts of your application have different runtime environments and therefore different optimal configurations
- Using a shared base configuration ensures consistency for common rules
- Environment-specific configurations can then fine-tune settings like `target`, `module`, and `moduleResolution` for each specific runtime context

## Pro Tips for TypeScript Configuration

1. **Tree-Shaking**: Always include `"sideEffects": false` in your `package.json` for libraries to enable tree-shaking in bundlers
2. **Module Resolution**: Use `moduleResolution: "Bundler"` for projects using modern bundlers, and `NodeNext` for Node.js projects
3. **Strict Mode**: Enable `strict: true` by default and relax specific checks only when needed
4. **Explicit Package Types**: Use the `exports` field in `package.json` to provide clear entry points for different module systems

### Conclusion

Proper TypeScript configuration can significantly improve the developer experience and ensure your code runs correctly across different environments. By following these recommendations, you can create more maintainable, compatible, and efficient TypeScript projects.

Remember that these configurations may need adjustments based on your specific requirements, but they provide a solid foundation for most common scenarios. Happy coding!

### Common TypeScript Configuration Quick Reference

| Scenario | target | module | moduleResolution | Notes |
|----------|--------|--------|-----------------|-------|
| **Node.js Applications** |
| Modern Node.js (v22+) | ESNext | NodeNext | NodeNext | Best for current Node.js LTS versions |
| Node.js (v14) | ES2020 | Node16 | Node16 | For slightly older Node.js |
| Legacy Node.js (<v14) | ES2018 | CommonJS | Node | For compatibility with older Node.js |
| **Browser Applications** |
| Modern browsers with bundler (Webpack, Rollup, Vite) | ES2020 | ESNext | Bundler | Optimal for modern browser applications |
| Modern browsers without bundler | ES2020 | ES2020 | Node | For directly serving ES modules in browser |
| Supporting older browsers (IE11) | ES5 | ESNext | Bundler | Bundler will handle transpilation and polyfills |
| **Libraries and Packages** |
| Node.js library (for npm) | ES2020 | NodeNext | NodeNext | Best for libraries consumed by Node.js |
| Browser library (with bundler) | ES2020 | ESNext | Bundler | For libraries bundled for browsers |
| Dual-environment library | ES2020 | ESNext | NodeNext | For libraries used in both Node.js and browsers |
| Framework-specific library | ES2020 | ESNext | Bundler | Best used with dual package.json exports |
| **Special Cases** |
| TypeScript with React | ES2020 | ESNext | Bundler | Works well with React's JSX transformation |
| TypeScript with Angular | ES2022 | ESNext | Bundler | Angular CLI handles module resolution |
| TypeScript with Deno | ES2022 | ESNext | Node | Deno uses URLs for imports |
| TypeScript with Bun | ES2022 | ESNext | Bundler | Bun has built-in bundling capabilities |
| **Hybrid/Full Stack Projects** |
| Monorepo with Node.js backend and browser frontend | ES2020 | * | * | Use separate tsconfig files for each part |
| Isomorphic/Universal JavaScript | ES2020 | ESNext | NodeNext | Code shared between server and client |
| Electron applications | ES2020 | NodeNext | NodeNext | Main process uses Node.js, renderer process is browser |
