
drop table if exists dim_customers;
create table dim_customers (
  customer_key                bigint generated always as identity primary key,
  geography_key               bigint,
  customer_alternate_key      varchar(100),
  first_name                  varchar(100),
  last_name                   varchar(100),
  birth_date                  date,
  marital_status              varchar(50),
  gender                      varchar(20),
  email_address               varchar(255),
  yearly_income               numeric(14,2),
  total_children              smallint,
  english_education           varchar(150),
  spanish_education           varchar(150),
  french_education            varchar(150),
  english_occupation          varchar(150),
  spanish_occupation          varchar(150),
  french_occupation           varchar(150),
  house_owner_flag            boolean,
  number_cars_owned           smallint,
  address_line1               varchar(400),
  phone                       varchar(50),
  date_first_purchase         date,
  commute_distance            varchar(50),
  constraint chk_yearly_income_nonneg check (yearly_income is null or yearly_income >= 0)
);


drop table if exists dim_date;
create table dim_date (
  date_key                    integer primary key,
  full_date_alternate_key     date not null unique,
  day_number_of_week          smallint not null,
  english_day_name_of_week    varchar(30),
  spanish_day_name_of_week    varchar(30),
  french_day_name_of_week     varchar(30),
  day_number_of_month         smallint not null,
  day_number_of_year          smallint not null,
  week_number_of_year         smallint,
  english_month_name          varchar(30),
  spanish_month_name          varchar(30),
  french_month_name           varchar(30),
  month_number_of_year        smallint,
  calendar_quarter            smallint,
  calendar_year               smallint,
  calendar_semester           smallint,
  fiscal_quarter              smallint,
  fiscal_year                 smallint,
  fiscal_semester             smallint
);


drop table if exists dim_product_category;
create table dim_product_category (
  product_category_key            bigint generated always as identity primary key,
  product_category_alternate_key  varchar(100),
  english_product_category_name   varchar(250),
  spanish_product_category_name   varchar(250),
  french_product_category_name    varchar(250)
);


drop table if exists dim_product_subcategory;
create table dim_product_subcategory (
  product_subcategory_key            bigint generated always as identity primary key,
  product_subcategory_alternate_key  varchar(100),
  english_product_subcategory_name   varchar(250),
  spanish_product_subcategory_name   varchar(250),
  french_product_subcategory_name    varchar(250),
  product_category_key               bigint references dim_product_category(product_category_key) on update cascade on delete set null
);


drop table if exists dim_products;
create table dim_products (
  product_key               bigint primary key,
  unit_price                text,
  product_alternate_key     text,
  product_subcategory_key   text,
  weight_unit_measure_code  text,
  size_unit_measure_code    text,
  english_product_name      text,
  spanish_product_name      text,
  french_product_name       text,
  standard_cost             text,
  finished_goods_flag       text,
  color                     text,
  safety_stock_level        text,
  reorder_point             text,
  list_price                text,
  size                      text,
  size_range                text,
  weight                    text,
  days_to_manufacture       text,
  product_line              text,
  dealer_price              text,
  class                     text,
  style                     text,
  model_name                text,
  english_description       text,
  french_description        text,
  chinese_description       text,
  arabic_description        text,
  hebrew_description        text,
  thai_description          text,
  german_description        text,
  japanese_description      text,
  turkish_description       text,
  start_date                text,
  end_date                  text,
  status                    text
);


drop table if exists dim_sales_territory;
create table dim_sales_territory (
  sales_territory_key             bigint generated always as identity primary key,
  sales_territory_alternate_key   varchar(100),
  sales_territory_region          varchar(100),
  sales_territory_country         varchar(100),
  sales_territory_group           varchar(100)
);


drop table if exists fact_internet_sales;
create table fact_internet_sales (
  product_key             integer,
  order_date_key          integer,
  due_date_key            integer,
  ship_date_key           integer,
  customer_key            integer,
  promotion_key           integer,
  currency_key            integer,
  sales_territory_key     integer,
  sales_order_number      text,
  sales_order_line_number integer,
  revision_number         integer,
  order_quantity          integer,
  unit_price              numeric,
  extended_amount         numeric,
  product_standard_cost   numeric,
  total_product_cost      numeric,
  sales_amount            numeric,
  tax_amt                 numeric,
  freight                 numeric,
  order_date              text,
  due_date                text,
  ship_date               text
);



-- 1) Lookup product name into Sales

select
    f.product_key,
    p.english_product_name,
    p.unit_price
from fact_internet_sales f
join dim_products p 
    on f.product_key = p.product_key;

-- 2) Lookup customer fullname and product unit price into Sales

-- Customer FullName

select
    f.customer_key,
    concat(c.first_name, ' ', c.last_name) as customer_fullname
from fact_internet_sales f
join dim_customers c
    on f.customer_key = c.customer_key;

-- Unit Price

select
    f.product_key,
    p.unit_price
from fact_internet_sales f
join dim_products p
    on f.product_key = p.product_key;

-- 3) Create date fields from orderdatekey (year, monthno, monthname, quarter, yearmonth, weekdayno, weekdayname, financial month 
-- & quarter)

-- Year

select
    product_key,
    order_date,
    left(order_date, 4) as year
from fact_internet_sales
limit 20;


-- Month Number

select
    product_key,
    order_date,
    substring(order_date, 6, 2) as month_no
from fact_internet_sales
limit 20;

-- Month Name

select
    product_key,
    order_date,
    to_char(to_date(order_date, 'YYYY-MM-DD'), 'Month') as month_name
from fact_internet_sales;


-- Quarter

select
    product_key,
    order_date,
    (cast(substring(order_date, 6, 2) as int) + 2) / 3 as quarter_no
from fact_internet_sales;


-- Year Month

select
    product_key,
    order_date,
    to_char(to_date(order_date, 'YYYY-MM-DD'), 'YYYY-Mon') as year_month
from fact_internet_sales;

-- Weekday Number

select
    product_key,
    order_date,
    extract(dow from to_date(order_date, 'YYYY-MM-DD')) as weekday_no
from fact_internet_sales;

-- Weekday Name

select
    product_key,
    order_date,
    to_char(to_date(order_date, 'YYYY-MM-DD'), 'Day') as weekday_name
from fact_internet_sales;

-- 4) Calculate Sales Amount (with discount as percentage decimal)

-- Unit Distount
alter table fact_internet_sales
add column unit_discount numeric(10,4);

update fact_internet_sales
set unit_discount =
    1 - (extended_amount / nullif(sales_amount, 0));

-- Gross Amount

alter table fact_internet_sales
add column gross_amount numeric(14,2);

update fact_internet_sales
set gross_amount = unit_price * order_quantity;


select
    order_quantity,
    unit_price,
    extended_amount,
    gross_amount,
    unit_discount,
    sales_amount
from fact_internet_sales;

-- 5) Calculate Production Cost

select
    product_standard_cost as unit_cost,
    order_quantity,
    product_standard_cost * order_quantity as production_cost
from fact_internet_sales;

-- 6) Total Profit

alter table fact_internet_sales
add column production_cost numeric;

update fact_internet_sales
set production_cost = product_standard_cost * order_quantity;

select
    round(sum(sales_amount - production_cost), 2) as profit
from fact_internet_sales;

-- 7) Year-wise Sales 

select
    left(order_date, 4) as year,
    round(sum(sales_amount), 2) as total_sales
from fact_internet_sales
group by year
order by year;

-- 8) Month-wise sales

select
    left(order_date, 4) as year,
    substring(order_date, 6, 2) as month_no,
    to_char(to_date(order_date, 'YYYY-MM-DD'), 'Mon') as month_name,
    round(sum(sales_amount), 2) as total_sales
from fact_internet_sales
group by year, month_no, month_name
order by year, month_no;

-- 9) Quarter-Wise Sales

select
    left(order_date, 4) as year,
    'Q' || extract(quarter from to_date(order_date, 'YYYY-MM-DD')) as quarter,
    round(sum(sales_amount), 2) as total_sales
from fact_internet_sales
group by year, quarter
order by year, quarter;

-- 10) Total Sales

select
    round(sum(sales_amount), 2) as total_sales
from fact_internet_sales;

-- 11) Total Products

select
    count(distinct product_key) as total_products
from fact_internet_sales;

-- 12) Total Customers

select
    count(distinct customer_key) as total_customers
from dim_customers;









