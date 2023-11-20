import React, { useState, useEffect } from 'react';
import Slider from 'react-slick';
import 'slick-carousel/slick/slick.css';
import 'slick-carousel/slick/slick-theme.css';

const ChangingImages = () => {
	const imageUrls = [
		'/images/image1.jpeg',
		'/images/image2.jpeg',
		'/images/image3.jpeg',
		'/images/image4.jpeg',
		'/images/image5.jpeg',
		'/images/image6.jpeg',
		'/images/image7.jpeg',

	];

	const [currentImageIndex, setCurrentImageIndex] = useState(0);

	useEffect(() => {
		const interval = setInterval(() => {
			setCurrentImageIndex((prevIndex) => (prevIndex + 1) % imageUrls.length);
		}, 1000);

		return () => clearInterval(interval);
	}, [imageUrls]);

	const settings = {
		infinite: true,
		speed: 1000,
		slidesToShow: 3, // Show one slide at a time
		slidesToScroll: 1,
		autoplay: true,
		autoplaySpeed: 4000,
		centerMode: true, // Enable center mode
		centerPadding: '0', // Adjust the padding to control how much of the previous and next slides are visible
	};

	return (
		<Slider {...settings}>
			{imageUrls.map((imageUrl, index) => (
				<div key={index} className='slider'>
					<img src={imageUrl} alt={`Image ${index + 1}`} className='centered-image' />
				</div>
			))}
		</Slider>
	);
};

export default ChangingImages;