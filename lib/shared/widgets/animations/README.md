# Animation Widgets

This directory contains reusable animation widgets to enhance the user experience throughout the Keri app.

## Available Animations

### 1. FadeInAnimation
A generic fade-in animation wrapper that can be applied to any widget.

**Usage:**
```dart
FadeInAnimation(
  duration: const Duration(milliseconds: 600),
  delay: const Duration(milliseconds: 200),
  curve: Curves.easeInOut,
  child: YourWidget(),
)
```

**Parameters:**
- `child` (required): The widget to animate
- `duration`: Animation duration (default: 600ms)
- `delay`: Delay before starting animation (default: 0ms)
- `curve`: Animation curve (default: Curves.easeInOut)

---

### 2. SlideFadeInAnimation
Combines slide and fade animations for a smooth entrance effect.

**Usage:**
```dart
SlideFadeInAnimation(
  duration: const Duration(milliseconds: 800),
  delay: const Duration(milliseconds: 200),
  beginOffset: const Offset(0, 0.5), // Slide from bottom
  child: YourWidget(),
)
```

**Parameters:**
- `child` (required): The widget to animate
- `duration`: Animation duration (default: 600ms)
- `delay`: Delay before starting animation (default: 0ms)
- `curve`: Animation curve (default: Curves.easeOut)
- `beginOffset`: Starting position offset (default: Offset(0, 0.3))
  - `Offset(0, 0.5)`: Slide from bottom
  - `Offset(-0.5, 0)`: Slide from left
  - `Offset(0.5, 0)`: Slide from right
  - `Offset(0, -0.5)`: Slide from top

---

### 3. FadeInText
A specialized text widget with fade-in animation that integrates with `AppTextStyles`.

**Factory Constructors:**

#### FadeInText.heading()
```dart
FadeInText.heading(
  text: 'Welcome to Keri',
  fontSize: AppSizes.fontSizeXLarge,
  textAlign: TextAlign.center,
  duration: const Duration(milliseconds: 600),
  delay: const Duration(milliseconds: 200),
)
```

#### FadeInText.title()
```dart
FadeInText.title(
  text: 'Fast Delivery',
  fontSize: AppSizes.fontSizeTitle,
  textAlign: TextAlign.center,
  delay: const Duration(milliseconds: 400),
)
```

#### FadeInText.body()
```dart
FadeInText.body(
  text: 'Get your packages delivered quickly and safely',
  fontSize: AppSizes.fontSizeMedium,
  textAlign: TextAlign.center,
  delay: const Duration(milliseconds: 600),
)
```

#### FadeInText.subtitle()
```dart
FadeInText.subtitle(
  text: 'Reliable Service',
  delay: const Duration(milliseconds: 300),
)
```

#### FadeInText.caption()
```dart
FadeInText.caption(
  text: 'Terms and conditions apply',
  color: Colors.grey,
)
```

**Parameters:**
- `text` (required): The text to display
- `color`: Custom text color (optional)
- `fontSize`: Custom font size (optional)
- `textAlign`: Text alignment (optional)
- `maxLines`: Maximum number of lines (optional)
- `overflow`: Text overflow behavior (optional)
- `duration`: Animation duration (default: 600ms)
- `delay`: Delay before starting animation (default: 0ms)
- `curve`: Animation curve (default: Curves.easeInOut)

---

### 4. ScaleAnimationTapWrapper
A tap wrapper that adds a scale animation when pressed (already exists).

**Usage:**
```dart
ScaleAnimationTapWrapper(
  onTap: () => print('Tapped!'),
  child: YourWidget(),
)
```

---

## Examples

### Staggered Text Animations
Create a beautiful staggered effect by increasing the delay for each text element:

```dart
Column(
  children: [
    FadeInText.heading(
      text: 'Welcome',
      delay: const Duration(milliseconds: 200),
    ),
    FadeInText.title(
      text: 'to Keri',
      delay: const Duration(milliseconds: 400),
    ),
    FadeInText.body(
      text: 'Your delivery partner',
      delay: const Duration(milliseconds: 600),
    ),
  ],
)
```

### Combining Animations
Mix different animations for rich effects:

```dart
Column(
  children: [
    SlideFadeInAnimation(
      delay: const Duration(milliseconds: 200),
      beginOffset: const Offset(0, 0.5),
      child: Image.asset('assets/logo.png'),
    ),
    FadeInText.title(
      text: 'Fast Delivery',
      delay: const Duration(milliseconds: 600),
    ),
  ],
)
```

### List Item Animations
Animate list items with staggered delays:

```dart
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return SlideFadeInAnimation(
      delay: Duration(milliseconds: 100 * index),
      beginOffset: const Offset(-0.3, 0),
      child: ListTile(
        title: Text(items[index]),
      ),
    );
  },
)
```

---

## Best Practices

1. **Keep durations reasonable**: 300-800ms for most animations
2. **Use delays for staggering**: Increment by 100-200ms for each element
3. **Don't over-animate**: Not every element needs animation
4. **Consider performance**: Avoid animating large lists without pagination
5. **Test on real devices**: Animations may feel different on actual hardware

---

## Performance Tips

- Use `const` constructors where possible
- Avoid animating widgets during scrolling
- Keep animation durations under 1000ms
- Use `RepaintBoundary` for complex animated widgets
- Consider disabling animations for accessibility preferences

