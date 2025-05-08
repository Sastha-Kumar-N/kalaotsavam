document.addEventListener('DOMContentLoaded', function() {
    // Mobile menu toggle
    const mobileMenu = document.getElementById('mobile-menu');
    const navMenu = document.querySelector('.nav-menu');

    mobileMenu.addEventListener('click', function() {
        mobileMenu.classList.toggle('active');
        navMenu.classList.toggle('active');
    });

    // Close mobile menu when clicking on a link
    const navLinks = document.querySelectorAll('.nav-link');
    navLinks.forEach(link => {
        link.addEventListener('click', function() {
            mobileMenu.classList.remove('active');
            navMenu.classList.remove('active');
        });
    });

    // Event rules functionality
    const eventItems = document.querySelectorAll('.event-list p');
    const rulesContent = document.getElementById('rulesContent');

    eventItems.forEach(item => {
        item.addEventListener('click', function() {
            const rule = this.getAttribute('data-rule');
            rulesContent.textContent = rule;
            
            // Remove active class from all items
            eventItems.forEach(i => i.classList.remove('active'));
            // Add active class to clicked item
            this.classList.add('active');
        });
    });

    // Change navbar style on scroll
    window.addEventListener('scroll', function() {
        const navbar = document.querySelector('.navbar');
        if (window.scrollY > 50) {
            navbar.style.backgroundColor = 'rgba(44, 62, 80, 0.9)';
            navbar.style.padding = '10px 0';
        } else {
            navbar.style.backgroundColor = 'transparent';
            navbar.style.padding = '15px 0';
        }
    });
});


// Getting formated date from date string
