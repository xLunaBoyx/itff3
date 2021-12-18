<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/admin/adminMenu.css">

    <div class="l-navbar" id="navbar">
        <nav class="nav">
            <div>
                <div class="nav__brand">
                    <ion-icon name="menu-outline" class="nav__toggle" id="nav-toggle"></ion-icon>
                    <a href="#" class="nav__logo">ITFF</a>
                </div>
                
				<div class="nav__list">
                    <a href="#" class="nav__link">
                        <ion-icon name="home-outline" class="nav__icon md hydrated" role="img" aria-label="home outline"></ion-icon>
                        <span class="nav_name">Dashboard</span>
                    </a>
                    <a href="#" class="nav__link">
                        <ion-icon name="chatbubbles-outline" class="nav__icon md hydrated" role="img" aria-label="chatbubbles outline"></ion-icon>
                        <span class="nav_name">Messenger</span>
                    </a>

                    <div href="#" class="nav__link collapse active" style="grid-template-columns: 20px max-content 1fr; display: grid; align-items: center; column-gap: 0.75rem; padding: 0.75rem; color: var(--white-color); border-radius: 0.5rem; margin-bottom: 1rem; transition: .3s; cursor: pointer;">
                        <ion-icon name="folder-outline" class="nav__icon md hydrated" role="img" aria-label="folder outline"></ion-icon>
                        <span class="nav_name">Projects</span>

                        <ion-icon name="chevron-down-outline" class="collapse__link md hydrated rotate" role="img" aria-label="chevron down outline"></ion-icon>

                        <ul class="collapse__menu showCollapse">
                            <a href="#" class="collapse__sublink">Data</a>
                            <a href="#" class="collapse__sublink">Group</a>
                            <a href="#" class="collapse__sublink">Members</a>
                        </ul>
                    </div>

                    <a href="#" class="nav__link">
                        <ion-icon name="pie-chart-outline" class="nav__icon md hydrated" role="img" aria-label="pie chart outline"></ion-icon>
                        <span class="nav_name">Analytics</span>
                    </a>

                    <div href="#" class="nav__link collapse" style="grid-template-columns: 20px max-content 1fr; display: grid; align-items: center; column-gap: 0.75rem; padding: 0.75rem; color: var(--white-color); border-radius: 0.5rem; margin-bottom: 1rem; transition: .3s; cursor: pointer;">
                        <ion-icon name="people-outline" class="nav__icon md hydrated" role="img" aria-label="people outline"></ion-icon>
                        <span class="nav_name">Team</span>

                        <ion-icon name="chevron-down-outline" class="collapse__link md hydrated" role="img" aria-label="chevron down outline"></ion-icon>

                        <ul class="collapse__menu">
                            <a href="#" class="collapse__sublink">Data</a>
                            <a href="#" class="collapse__sublink">Group</a>
                            <a href="#" class="collapse__sublink">Members</a>
                        </ul>
                    </div>

                    <a href="#" class="nav__link">
                        <ion-icon name="settings-outline" class="nav__icon md hydrated" role="img" aria-label="settings outline"></ion-icon>
                        <span class="nav_name">Settings</span>
                    </a>
                </div>
                <a href="${pageContext.request.contextPath }" class="nav__link">
                    <ion-icon name="log-out-outline" class="nav__icon"></ion-icon>
                    <span class="nav_name">Exit</span>
                </a>
            </div>
        </nav>
    </div>

<!-- IONICONS -->
<script src="https://unpkg.com/ionicons@5.2.3/dist/ionicons.js"></script>

<script type="text/javascript">
/* EXPANDER MENU */
const showMenu = (toggleId, navbarId, bodyId) => {
    const toggle = document.getElementById(toggleId),
    navbar = document.getElementById(navbarId),
    bodypadding = document.getElementById(bodyId)

    if( toggle && navbar ) {
        toggle.addEventListener('click', ()=>{
            navbar.classList.toggle('expander');

            bodypadding.classList.toggle('body-pd')
        })
    }
}

showMenu('nav-toggle', 'navbar', 'body-pd')

/* LINK ACTIVE */
const linkColor = document.querySelectorAll('.nav__link')
function colorLink() {
    linkColor.forEach(l=> l.classList.remove('active'))
    this.classList.add('active')
}
linkColor.forEach(l=> l.addEventListener('click', colorLink))

/* COLLAPSE MENU */
const linkCollapse = document.getElementsByClassName('collapse__link')
var i

for(i=0;i<linkCollapse.length;i++) {
    linkCollapse[i].addEventListener('click', function(){
        const collapseMenu = this.nextElementSibling
        collapseMenu.classList.toggle('showCollapse')

        const rotate = collapseMenu.previousElementSibling
        rotate.classList.toggle('rotate')
    });
}
</script>