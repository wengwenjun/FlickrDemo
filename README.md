# FlickrDemo
### Structure:
#### Model: 
      Animator Object FlickerImage object
#### View:
     CollectionView DetailImageView
#### Controller: 
       Collectionview logic
       DetailImageView logic
       BackendServiceCall
### How to Build the app
       pod install
       open FlickerDemo.xcworkspace

### Feature Included
      fetch latest yesterday interestingness pictures from Flickr
      use pageination and lazy loading 
      use a customized animation to present the detail picture
      handler the error code from http request 
      use sdwebimage to cache the image for ux improvement
      auto layout good for universal size device(iphone & ipad) 

### things can be improved if more time 
      add ui test cases
      the customized animation could be more designable 
      Lazy loading could be more smooth 
      I am on support this week, so my time is little limited. I use Swift instead of objective c to present my skill better and save a little bit of time
