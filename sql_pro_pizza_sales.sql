use pizzasales;
select* from pizzas;
select pizza_id,sum(quantity) from order_details group by pizza_id;

select sum(quantity*price) from pizzas inner join order_details on pizzas.pizza_id=order_details.pizza_id;

select * from pizza_types join pizzas on pizzas.pizza_type_id=pizza_types.pizza_type_id order by price desc limit 1;

select quantity,name as nami from pizzas join pizza_types on pizzas.pizza_type_id=pizzas.pizza_type_id join order_details on pizzas.pizza_id=order_details.pizza_id group by nami; 

select sum(quantity) from order_details group by quantity;

select sum(order_details.quantity),pizza_types.category as cat from pizzas join pizza_types on pizzas.pizza_type_id=pizza_types.pizza_type_id join order_details on order_details.pizza_id=pizzas.pizza_id group by cat;

select sum(rev) from (select sum(order_details.quantity),hour(orders.time) from order_details join orders on order_details.order_id=orders.order_id group by hour(orders.time)

select count(name),pizza_types.category from pizza_types group by pizza_types.category;

select avg(b) from (select sum(order_details.quantity) as b,orders.date from order_details join orders on order_details.order_id=orders.order_id group by orders.date);

select pizza_types.name as pn, sum(order_details.quantity*pizzas.price) as rev from pizzas join pizza_types on pizza_types.pizza_type_id=pizzas.pizza_type_id join order_details on order_details.pizza_id=pizzas.pizza_id group by pn order by rev desc limit 3;


select pizza_type_id,sum(quantity*price)/(select sum(rev) from (select sum(quantity*price) as rev from pizzas join order_details on pizzas.pizza_id=order_details.pizza_id group by pizza_type_id) as calc)*100 as sales from pizzas join order_details on pizzas.pizza_id=order_details.pizza_id group by pizza_type_id;
select name,category,rev from(
select category,name,rev,rank() over(partition by category order by rev desc) as rn from(
select pizza_types.category,pizza_types.name,sum(quantity*price) as rev 
from pizzas join pizza_types on pizzas.pizza_type_id=pizza_types.pizza_type_id 
join order_details on order_details.pizza_id=pizzas.pizza_id 
group by category,pizza_types.name) as a) as b where rn<=3