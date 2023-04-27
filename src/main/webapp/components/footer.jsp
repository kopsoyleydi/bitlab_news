<div class="container" style="min-height: 200px;">
    <div class="row mt-3">
        <div class="col-12">
        </div>
    </div>
</div>
<div class="container p-4">
    <footer class="d-flex flex-wrap justify-content-between align-items-center py-3 my-4 border-top mb-1">
        <p class="col-md-4 mb-0 text-body-secondary">BitLab News</p>
        <a href="/" class="col-md-4 d-flex align-items-center justify-content-center mb-3 mb-md-0 me-md-auto link-body-emphasis text-decoration-none">
            <svg class="bi me-2" width="40" height="32"><use xlink:href="#bootstrap"></use></svg>
        </a>
        <ul class="nav col-md-4 justify-content-end">
            <li class="nav-item"><a href="#" class="nav-link px-2 text-body-secondary">Home</a></li>
            <%
                if(currentUser != null){
            %>
            <li class="nav-item"><a href="/profile" class="nav-link px-2 text-body-secondary">Profile</a></li>
            <li class="nav-item"><a href="/settings" class="nav-link px-2 text-body-secondary">Settings</a></li>
            <%
                }
            %>
            <li class="nav-item"><a href="#" class="nav-link px-2 text-body-secondary">FAQs</a></li>
            <li class="nav-item"><a href="#" class="nav-link px-2 text-body-secondary">About</a></li>
        </ul>
    </footer>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
        crossorigin="anonymous"></script>
