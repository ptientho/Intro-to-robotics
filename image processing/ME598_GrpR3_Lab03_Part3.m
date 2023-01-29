function ME598_GrpR3_Lab03_Part3("C:\Users\Krupansh Shah\Desktop\Semester 2\Introduction to Robotics\Lab 3\ConeImage3_output.jpg")

[areas, centroids] = blobAnalysis("C:\Users\Krupansh Shah\Desktop\Semester 2\Introduction to Robotics\Lab 3\ConeImage3_output.jpg");
image = imread("C:\Users\Krupansh Shah\Desktop\Semester 2\Introduction to Robotics\Lab 3\ConeImage3_output.jpg");
[angles, proximities] = get_3b(image, centroids, areas);
overheadView(angles, proximities, 5);

end