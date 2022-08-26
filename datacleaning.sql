select * from NashvilleHousing

--Standardize date format
select Sale_Date from NashvilleHousing

Alter table Nashvillehousing
Add Sale_Date Date;

Update NashvilleHousing
Set Sale_Date = convert(date, SaleDate)

--Populate Property Address Data
select * from NashvilleHousing
--where PropertyAddress is null
order by ParcelID

select a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress, isnull(a.PropertyAddress,b.PropertyAddress) 
from NashvilleHousing a
join NashvilleHousing b
on a.ParcelID=b.ParcelID
and a.UniqueID <> b.UniqueID
where a.PropertyAddress is null

update a
set PropertyAddress = isnull(a.PropertyAddress,b.PropertyAddress) 
from NashvilleHousing a
join NashvilleHousing b
on a.ParcelID=b.ParcelID
and a.UniqueID <> b.UniqueID
where a.PropertyAddress is null


--Breaking out address into individual columns (Address, City, State)
select
SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress) -1) as Address
,SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress) +1,LEN(PropertyAddress)) as Address
from NashvilleHousing

Alter table Nashvillehousing
Add Address nvarchar(255);

Update NashvilleHousing
Set Address = SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress) -1)

Alter table Nashvillehousing
Add City nvarchar(255);

Update NashvilleHousing
Set City = SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress) +1,LEN(PropertyAddress))

select 
PARSENAME(Replace(OwnerAddress,',','.'),3),
PARSENAME(Replace(OwnerAddress,',','.'),2),
PARSENAME(Replace(OwnerAddress,',','.'),1)
from NashvilleHousing
where OwnerAddress is not null

Alter table Nashvillehousing
Add Owner_Add nvarchar(255);

Update NashvilleHousing
Set Owner_Add = PARSENAME(Replace(OwnerAddress,',','.'),3)

Alter table Nashvillehousing
Add OwnerCity nvarchar(255);

Update NashvilleHousing
Set OwnerCity = PARSENAME(Replace(OwnerAddress,',','.'),2)

Alter table Nashvillehousing
Add OwnerState nvarchar(255);

Update NashvilleHousing
Set OwnerState = PARSENAME(Replace(OwnerAddress,',','.'),1)

select * from NashvilleHousing

--Change Y and N to Yes and No in "sold as vacant" field
select distinct(SoldasVacant),count(SoldasVacant)
from NashvilleHousing
group by SoldasVacant
order by 2

select SoldasVacant,
case when SoldasVacant = 'Y' then 'Yes'
     when soldasVacant = 'N' then 'No'
	 else SoldasVacant
	 end
from NashvilleHousing

update NashvilleHousing
set SoldasVacant=case when SoldasVacant = 'Y' then 'Yes'
     when soldasVacant = 'N' then 'No'
	 else SoldasVacant
	 end


--Delete unused columns
alter table NashvilleHousing
drop column SaleDate

select * from NashvilleHousing