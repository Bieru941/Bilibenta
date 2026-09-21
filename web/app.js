const products=[
 {title:"iPhone 13",price:"₱18,500",location:"Cavite",icon:"📱"},
 {title:"Gaming Keyboard",price:"₱1,200",location:"Manila",icon:"⌨️"},
 {title:"Study Desk",price:"₱2,500",location:"Laguna",icon:"🪑"},
 {title:"Air Jordan Shoes",price:"₱3,800",location:"Quezon City",icon:"👟"},
 {title:"Mechanical Watch",price:"₱2,100",location:"Pasay",icon:"⌚"},
 {title:"Laptop Stand",price:"₱850",location:"Makati",icon:"💻"},
 {title:"Backpack",price:"₱900",location:"Naic",icon:"🎒"},
 {title:"Bluetooth Speaker",price:"₱1,500",location:"Imus",icon:"🔊"}
];
function render(list=products){document.getElementById("products").innerHTML=list.map(p=>`<article class="product"><div class="product-img">${p.icon}</div><div class="product-body"><h3>${p.title}</h3><div class="price">${p.price}</div><div class="muted">${p.location}</div></div></article>`).join("")}
function filterProducts(){const q=document.getElementById("search").value.toLowerCase();render(products.filter(p=>(p.title+p.location).toLowerCase().includes(q)))}
function openLogin(){show(`<h2>Login</h2><p>This web preview is ready for Supabase authentication.</p><label>Email</label><input type="email" placeholder="you@example.com"><label>Password</label><input type="password" placeholder="Password"><button class="primary" style="margin-top:18px;width:100%" onclick="alert('Connect Supabase authentication to enable login.')">Login</button>`)}
function openSell(){show(`<h2>Create Listing</h2><label>Product name</label><input placeholder="e.g. iPhone 13"><label>Price</label><input placeholder="₱0.00"><label>Description</label><textarea placeholder="Describe your item"></textarea><button class="primary" style="margin-top:18px;width:100%" onclick="alert('Connect Supabase database/storage to publish listings.')">Publish Listing</button>`)}
function show(html){document.getElementById("modalContent").innerHTML=html;document.getElementById("modal").classList.add("show")}
function closeModal(){document.getElementById("modal").classList.remove("show")}
render();
