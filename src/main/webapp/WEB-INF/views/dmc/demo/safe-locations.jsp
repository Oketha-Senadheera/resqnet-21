<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
            <layout:dmc-dashboard pageTitle="ResQnet - Safe Locations Admin" activePage="safe-locations">

                <jsp:body>

                    <style>
                        .section {
                            background: #fff;
                            border: 1px solid var(--color-border);
                            border-radius: var(--radius-lg);
                            padding: 1.25rem;
                        }

                        .section h2 {
                            margin: 0;
                            font-size: 1.05rem;
                        }

                        .section-head {
                            display: flex;
                            align-items: center;
                            justify-content: space-between;
                            margin: 0 0 1rem;
                        }

                        .safe-grid {
                            display: grid;
                            grid-template-columns: 1fr 2fr;
                            gap: 1.25rem;
                        }

                        /* Expanded map area */
                        .list {
                            display: flex;
                            flex-direction: column;
                            gap: 0.6rem;
                            max-height: 500px;
                            overflow-y: auto;
                        }

                        .loc {
                            background: var(--color-surface);
                            border: 1px solid var(--color-border);
                            padding: 0.85rem 1rem;
                            border-radius: var(--radius-md);
                            cursor: pointer;
                        }

                        .loc:hover {
                            background: var(--color-hover-surface);
                        }

                        .name {
                            font-weight: 700;
                            font-size: .9rem;
                            margin-bottom: 0.25rem;
                        }

                        .coords {
                            color: #666;
                            font-size: .75rem;
                        }

                        .map {
                            background: var(--color-surface);
                            border: 1px solid var(--color-border);
                            border-radius: var(--radius-md);
                            min-height: 500px;
                            overflow: hidden;
                            position: relative;
                        }

                        /* Simple Modal */
                        .modal-overlay {
                            position: fixed;
                            top: 0;
                            left: 0;
                            width: 100%;
                            height: 100%;
                            background: rgba(0, 0, 0, 0.5);
                            display: none;
                            justify-content: center;
                            align-items: center;
                            z-index: 1000;
                        }

                        .modal-box {
                            background: #fff;
                            padding: 1.5rem;
                            border-radius: var(--radius-lg);
                            width: 300px;
                            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
                        }

                        .modal-box h3 {
                            margin-top: 0;
                        }

                        .form-group {
                            margin-bottom: 1rem;
                        }

                        .form-group label {
                            display: block;
                            margin-bottom: .5rem;
                            font-size: .9rem;
                        }

                        .form-group input {
                            width: 100%;
                            padding: .5rem;
                            border: 1px solid var(--color-border);
                            border-radius: var(--radius-md);
                        }

                        .modal-actions {
                            display: flex;
                            justify-content: flex-end;
                            gap: 0.5rem;
                        }

                        @media (max-width: 900px) {
                            .safe-grid {
                                grid-template-columns: 1fr;
                            }
                        }
                    </style>

                    <main class="content" id="mainContent" tabindex="-1">
                        <section class="section" aria-label="Safe Locations">
                            <div class="section-head">
                                <h2>Safe Locations (Admin)</h2>
                                <div style="font-size:0.8rem; color:#666;">Click on the map to add a new location</div>
                            </div>
                            <div class="safe-grid">
                                <div class="list" id="locList">
                                    <c:forEach var="loc" items="${locations}">
                                        <div class="loc"
                                            style="display:flex; justify-content:space-between; align-items:center;"
                                            onclick="panToLocation(${loc.latitude}, ${loc.longitude})">
                                            <div>
                                                <div class="name">${loc.name}</div>
                                                <div class="coords">${loc.latitude}, ${loc.longitude}</div>
                                            </div>
                                            <form action="${pageContext.request.contextPath}/dmc/safe-locations"
                                                method="post"
                                                onsubmit="event.stopPropagation(); return confirm('Are you sure you want to delete this location?');">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="id" value="${loc.id}">
                                                <button type="submit" class="btn btn-outline"
                                                    style="padding: 0.5rem; color: #d32f2f; border-color: #d32f2f; font-size: 0.8rem;">
                                                    Delete
                                                </button>
                                            </form>
                                        </div>
                                    </c:forEach>
                                    <c:if test="${empty locations}">
                                        <div style="padding:1rem; color:#666; font-size:0.9rem;">
                                            <em>No safe locations found. Add one on the map!</em>
                                        </div>
                                    </c:if>
                                </div>
                                <div class="map" id="map-container-admin"></div>
                            </div>
                        </section>
                    </main>

                    <!-- Modal -->
                    <div class="modal-overlay" id="addLocModal">
                        <div class="modal-box">
                            <h3>Add Safe Location</h3>
                            <input type="hidden" id="newLat">
                            <input type="hidden" id="newLng">
                            <div class="form-group">
                                <label>Location Name</label>
                                <input type="text" id="locName" placeholder="e.g. Town Hall Shelter">
                            </div>
                            <div class="modal-actions">
                                <button class="btn btn-outline" id="cancelBtn">Cancel</button>
                                <button class="btn btn-primary" id="saveBtn">Save</button>
                            </div>
                        </div>
                    </div>

                    <script src="https://maps.googleapis.com/maps/api/js?key=${googleMapsApiKey}&callback=initMap" async
                        defer></script>
                    <script>
                        let map;
                        let tempMarker;

                        function initMap() {
                            const defaultPos = { lat: 6.9271, lng: 79.8612 }; // Colombo default
                            map = new google.maps.Map(document.getElementById("map-container-admin"), {
                                zoom: 12,
                                center: defaultPos,
                            });

                            // Load existing markers
                            <c:forEach var="loc" items="${locations}">
                                new google.maps.Marker({
                                    position: {lat: ${loc.latitude}, lng: ${loc.longitude} },
                                map: map,
                                title: "${loc.name}",
                                icon: 'http://maps.google.com/mapfiles/ms/icons/red-dot.png'
                                });
                            </c:forEach>

                            map.addListener("click", (e) => {
                                const lat = e.latLng.lat();
                                const lng = e.latLng.lng();

                                if (tempMarker) tempMarker.setMap(null);

                                tempMarker = new google.maps.Marker({
                                    position: { lat, lng },
                                    map: map,
                                    icon: 'http://maps.google.com/mapfiles/ms/icons/green-dot.png', // Distinguish new marker
                                    animation: google.maps.Animation.DROP
                                });

                                openModal(lat, lng);
                            });
                        }

                        const modal = document.getElementById('addLocModal');
                        const nameInput = document.getElementById('locName');
                        const latInput = document.getElementById('newLat');
                        const lngInput = document.getElementById('newLng');

                        function openModal(lat, lng) {
                            modal.style.display = 'flex';
                            latInput.value = lat;
                            lngInput.value = lng;
                            nameInput.value = '';
                            nameInput.focus();
                        }

                        document.getElementById('cancelBtn').addEventListener('click', () => {
                            modal.style.display = 'none';
                            if (tempMarker) tempMarker.setMap(null);
                        });

                        document.getElementById('saveBtn').addEventListener('click', () => {
                            const name = nameInput.value;
                            const lat = parseFloat(latInput.value);
                            const lng = parseFloat(lngInput.value);

                            if (!name) { alert('Please enter a name'); return; }

                            const payload = { name, lat, lng };

                            fetch('${pageContext.request.contextPath}/dmc/safe-locations/save', {
                                method: 'POST',
                                headers: { 'Content-Type': 'application/json' },
                                body: JSON.stringify(payload)
                            })
                                .then(res => {
                                    if (res.ok) {
                                        // Success
                                        modal.style.display = 'none';
                                        alert('Safe Location Saved! refreshing...');
                                        window.location.reload(); // Reload to see new item in list and map
                                    } else {
                                        alert('Error saving location');
                                    }
                                })
                                .catch(err => console.error(err));
                        });

                        if (window.lucide) lucide.createIcons();

                        document.querySelectorAll('.nav-item').forEach((btn) => {
                            btn.addEventListener('click', () => {
                                const s = btn.getAttribute('data-section');
                                if (s === 'safe-locations') return;
                            });
                        });

                        function panToLocation(lat, lng) {
                            if (map) {
                                map.setCenter({ lat: lat, lng: lng });
                                map.setZoom(15);
                            }
                        }
                    </script>

                </jsp:body>

            </layout:dmc-dashboard>