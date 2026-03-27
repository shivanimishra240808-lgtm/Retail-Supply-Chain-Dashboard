import pandas as pd
import random
from datetime import datetime, timedelta

# sizes
num_customers = 10000
num_products = 2000
num_suppliers = 200
num_orders = 50000
num_order_items = 120000
num_shipments = 50000

regions = ["North America","Europe","Asia","India","Middle East"]
categories = ["Electronics","Furniture","Clothing","Sports","Accessories"]
carriers = ["DHL","FedEx","UPS","BlueDart"]
warehouses = ["WH-A","WH-B","WH-C","WH-D"]


# Customers
customers = pd.DataFrame({
    "customer_id": range(1,num_customers+1),
    "customer_name":[f"Customer_{i}" for i in range(1,num_customers+1)],
    "city":[random.choice(["Delhi","Mumbai","London","New York","Dubai"]) for _ in range(num_customers)],
    "region":[random.choice(regions) for _ in range(num_customers)],
    "join_date":[datetime(2022,1,1)+timedelta(days=random.randint(0,800)) for _ in range(num_customers)]
})


# Suppliers
suppliers = pd.DataFrame({
    "supplier_id": range(1,num_suppliers+1),
    "supplier_name":[f"Supplier_{i}" for i in range(1,num_suppliers+1)],
    "country":[random.choice(["India","China","USA","Germany","UAE"]) for _ in range(num_suppliers)],
    "rating":[random.randint(1,5) for _ in range(num_suppliers)],
    "lead_time_days":[random.randint(3,15) for _ in range(num_suppliers)]
})


# Products

products = pd.DataFrame({
    "product_id": range(1,num_products+1),
    "product_name":[f"Product_{i}" for i in range(1,num_products+1)],
    "category":[random.choice(categories) for _ in range(num_products)],
    "supplier_id":[random.randint(1,num_suppliers) for _ in range(num_products)],
    "price":[random.randint(10,500) for _ in range(num_products)]
})


# Orders

orders = pd.DataFrame({
    "order_id": range(1,num_orders+1),
    "customer_id":[random.randint(1,num_customers) for _ in range(num_orders)],
    "order_date":[datetime(2023,1,1)+timedelta(days=random.randint(0,365)) for _ in range(num_orders)],
    "region":[random.choice(regions) for _ in range(num_orders)]
})


# Order Items

order_items = pd.DataFrame({
    "order_item_id": range(1,num_order_items+1),
    "order_id":[random.randint(1,num_orders) for _ in range(num_order_items)],
    "product_id":[random.randint(1,num_products) for _ in range(num_order_items)],
    "quantity":[random.randint(1,5) for _ in range(num_order_items)]
})

order_items["sales"] = order_items["quantity"] * [random.randint(20,500) for _ in range(num_order_items)]
order_items["profit"] = order_items["sales"] * 0.2

# Shipments

shipments = pd.DataFrame({
    "shipment_id": range(1,num_shipments+1),
    "order_id":[random.randint(1,num_orders) for _ in range(num_shipments)],
    "carrier":[random.choice(carriers) for _ in range(num_shipments)],
    "shipping_cost":[random.randint(5,50) for _ in range(num_shipments)]
})

shipments["ship_date"] = [datetime(2023,1,1)+timedelta(days=random.randint(0,365)) for _ in range(num_shipments)]
shipments["delivery_date"] = shipments["ship_date"] + pd.to_timedelta([random.randint(2,10) for _ in range(num_shipments)], unit="D")


# Inventory

inventory = pd.DataFrame({
    "product_id": range(1,num_products+1),
    "warehouse":[random.choice(warehouses) for _ in range(num_products)],
    "stock_level":[random.randint(50,500) for _ in range(num_products)],
    "reorder_point":[random.randint(20,100) for _ in range(num_products)]
})


# Save CSV Files

customers.to_csv("customers.csv",index=False)
suppliers.to_csv("suppliers.csv",index=False)
products.to_csv("products.csv",index=False)
orders.to_csv("orders.csv",index=False)
order_items.to_csv("order_items.csv",index=False)
shipments.to_csv("shipments.csv",index=False)
inventory.to_csv("inventory.csv",index=False)

print("✅ Dataset generated successfully!")



