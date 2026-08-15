    </div> <!-- End container -->
    <footer class="py-4 mt-auto border-top" style="background-color: var(--color-secondary);">
        <div class="container text-center">
            <p class="mb-0 fw-bold fs-6" style="color: var(--color-foreground);">&copy; 2024 161 Garment</p>
            <small style="color: var(--color-muted); font-size: 0.75rem;">PRJ301 Assignment</small>
        </div>
    </footer>
    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Lenis Smooth Scrolling -->
    <script src="https://unpkg.com/@studio-freight/lenis@1.0.39/dist/lenis.min.js"></script>
    <script>
        const lenis = new Lenis({
            duration: 1.2,
            easing: (t) => Math.min(1, 1.001 - Math.pow(2, -10 * t)), 
            direction: 'vertical',
            gestureDirection: 'vertical',
            smooth: true,
            mouseMultiplier: 1,
            smoothTouch: false,
            touchMultiplier: 2,
            infinite: false,
        })
        function raf(time) {
            lenis.raf(time)
            requestAnimationFrame(raf)
        }
        requestAnimationFrame(raf)
    </script>
</body>
</html>
