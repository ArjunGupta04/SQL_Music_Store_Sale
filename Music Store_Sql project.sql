create database music_store;

-- Q1 Who is the senior most employee based on job title?
SELECT concat(last_name, ' ', first_name) as full_name, title, levels 
from employee
order by levels desc limit 1;

-- Q2 Which countries have the most Invoices?
select billing_country, count(invoice_id) as most_invoices
from invoice
group by billing_country
order by most_invoices desc limit 1;

-- Q3 What are top 3 values of total invoice?
select total from invoice
order by total desc limit 3;

	-- Q4 Which city has the best customers? We would like to throw a promotional Music  Festival in the city we made the most money. Write a query that returns one city that 
-- has the highest sum of invoice totals. Return both the city name & sum of all invoice totals ?
select billing_city, sum(total) as revenue_generated
from invoice
group by billing_city
order by revenue_generated desc limit 1;

-- Q5 Who is the best customer? The customer who has spent the most money will be declared the best customer. Write a query that returns the person who has spent the most money?
select concat(first_name, ' ', last_name) as full_name, sum(invoice.total) as total_revenue, customer.customer_id
from customer
join invoice on invoice.customer_id = customer.customer_id
group by full_name, customer.customer_id
order by total_revenue desc limit 1;

-- Q6 Write query to return the email, first name, last name, & Genre of all Rock Music listeners. Return your list ordered alphabetically by email starting with A
select distinct(customer.email) as email_id, customer.first_name, customer.last_name, track.genre_id, genre.name
from customer
join invoice on invoice.customer_id = customer.customer_id
join invoice_line on invoice_line.invoice_id = invoice.invoice_id
join track on track.track_id = invoice_line.track_id
join genre on genre.genre_id = track.genre_id
where genre.name LIKE 'ROCK'
order by email_id asc;

-- Q7 Let's invite the artists who have written the most rock music in our dataset. Write a query that returns the Artist name and total track count of the top 10 rock bands
SELECT artist.name, artist.artist_id, count(track.track_id) as total_tracks
from artist
join album2 on album2.artist_id = artist.artist_id
join track on track.album_id = album2.album_id
join genre on genre.genre_id = track.genre_id
where genre.genre_id = 1
group by artist.name, artist.artist_id
order by total_tracks desc limit 10;

 --  Q8 Return all the track names that have a song length longer than the average song length. Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first
select name, milliseconds
from track
where milliseconds > (
select avg(track.milliseconds) as average_length
from track)
order by milliseconds desc;





