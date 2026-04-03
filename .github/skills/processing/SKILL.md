---
name: processing
description: "Processing (Java) creative coding reference and patterns. Use when: writing Processing sketches, using PApplet API (setup/draw lifecycle, shape primitives, transformations, color), working with P3D/P2D renderers, handling input events, using Processing libraries (oscP5, minim, toxiclibs), debugging rendering or performance, converting between Processing and Java idioms."
---

# Processing (Java) Skill

## When to Use

- Writing or editing `.pde` sketch files
- Using Processing drawing primitives, transformations, or 3D rendering
- Integrating Processing libraries (oscP5, minim, sound, video, etc.)
- Debugging frame rate, rendering artifacts, or memory issues
- Structuring multi-file Processing sketches

## Processing Sketch Structure

A Processing sketch is a folder containing `.pde` files. The main file must share the folder's name. Additional `.pde` files define classes and are automatically combined at compile time.

```
my_sketch/
├── my_sketch.pde       # Main file: setup(), draw(), event handlers
├── MyClass.pde         # Additional class
└── AnotherClass.pde    # Another class
```

## Lifecycle

```java
void setup() { }   // Called once at start
void draw() { }    // Called every frame (default 60 fps)
```

- `setup()`: Initialize size/renderer, load resources, set initial state
- `draw()`: Clear background, update state, render frame
- Use `frameRate(n)` to change target FPS
- Use `noLoop()` / `loop()` to pause/resume the draw loop

## Renderers

| Renderer | Usage | Notes |
|----------|-------|-------|
| Default (JAVA2D) | `size(800, 600)` | 2D, good for simple sketches |
| P2D | `size(800, 600, P2D)` | OpenGL-accelerated 2D |
| P3D | `size(800, 600, P3D)` | 3D with lighting, camera, depth |
| `fullScreen()` | `fullScreen(P3D)` | Full screen with specified renderer |

## Drawing Primitives

```java
// 2D shapes
point(x, y);
line(x1, y1, x2, y2);
rect(x, y, w, h);
ellipse(x, y, w, h);
arc(x, y, w, h, start, stop);
triangle(x1, y1, x2, y2, x3, y3);
quad(x1, y1, x2, y2, x3, y3, x4, y4);

// Curves
bezier(x1, y1, cx1, cy1, cx2, cy2, x2, y2);
curve(x1, y1, x2, y2, x3, y3, x4, y4);

// 3D shapes
box(size);
sphere(radius);
```

## Transformations

```java
pushMatrix();
translate(x, y, z);
rotate(angle);          // radians
rotateX(angle);
rotateY(angle);
rotateZ(angle);
scale(s);
popMatrix();            // Always pair with pushMatrix()
```

## Color & Style

```java
color c = color(r, g, b);          // RGB
color c = color(r, g, b, a);       // RGBA (a = alpha/opacity)
fill(c);
noFill();
stroke(c);
noStroke();
strokeWeight(w);
background(r, g, b);
lerpColor(c1, c2, amt);            // Interpolate between colors
```

## Math Utilities

```java
map(value, low1, high1, low2, high2);   // Remap value range
lerp(start, stop, amt);                  // Linear interpolation
constrain(val, min, max);
dist(x1, y1, x2, y2);
radians(degrees);
sin(angle); cos(angle); tan(angle);
random(low, high);
noise(x); noise(x, y);                   // Perlin noise
```

## Input Events

```java
void mousePressed() { }
void mouseReleased() { }
void mouseDragged() { }
void keyPressed() { }
void keyReleased() { }
// Built-in variables: mouseX, mouseY, pmouseX, pmouseY, key, keyCode
```

## Common Libraries

### oscP5 (OSC Protocol)

```java
import oscP5.*;
OscP5 oscP5;

void setup() {
    oscP5 = new OscP5(this, 8000);  // Listen on port 8000
}

void oscEvent(OscMessage msg) {
    if (msg.checkAddrPattern("/address")) {
        String s = msg.get(0).stringValue();
        float f = msg.get(1).floatValue();
        int i = msg.get(2).intValue();
    }
}
```

## Thread Safety

Processing's `draw()` runs on the animation thread. OSC callbacks (`oscEvent`) run on a separate network thread. Use thread-safe collections when sharing data:

```java
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;
List<MyObject> objects = new CopyOnWriteArrayList<MyObject>();
```

## Performance Tips

- Call `background()` each frame to clear (or use semi-transparent background for trails: `background(0, 40)`)
- Remove offscreen/dead objects from lists to prevent memory leaks
- Minimize object allocations inside `draw()`
- Use `println()` sparingly in `draw()` — it slows rendering
- Prefer `P2D`/`P3D` over default renderer for complex scenes
- Use `hint(DISABLE_DEPTH_TEST)` / `hint(ENABLE_DEPTH_TEST)` in P3D when mixing 2D and 3D

## Running Sketches

Processing sketches can be run via:
- **Processing IDE** (PDE): Open the main `.pde` file and click Run
- **processing-java CLI**: `processing-java --sketch=/path/to/sketch --run`
