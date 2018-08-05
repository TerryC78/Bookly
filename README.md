# PubFree

## TL;DR
To try our code by a local Django server:
```bash
git clone https://github.com/TerryC78/Bookly.git
pip install https://github.com/atereshkin/django-web3-auth/archive/master.zip
python web/publish/manage.py runserver
```
## Platform/Tool/Libraries we used
### Platform
We deployed through Quarkchain testnet, and the smart contract works. Our FE uses Django and we have a basic version of Django web server that talks with BE smart contract.

### Library
We used django-web3-auth library which can be installed here:
```bash
pip install https://github.com/atereshkin/django-web3-auth/archive/master.zip
```

## Platform Users

There will be two distinction of users:

### Content Creators (authors,bloggers, professors, etc)
* Earn tokens from sales proceeds (90% of sales price,10% goes to XX?)
* Spend tokens by promoting their content

### Content Consumers (students, consumers)
* Purchase content with tokens
* Earn tokens with book reviews
* Earn tokens by ratings other book reviews

## Token Utility
A utility token will be created and applied in the following use cases:

### Content (e-books, e-zine, newsletters, podcasts, e-textbooks)
* Tokens will be used to pay to purchase content on platform
* Bonus Token Payout/Rewards will be implemented to allow “tipping” by users
* Bonus Token Payout/Rewards will be implemented to promote certain content?

### Content Reviews (User Ratings & Reviews on Content Created)
* Tokens will be used to payout on ratings/reviews for content on platform
* Bonus Tokens Rewards will be implemented to reward quality ratings/review on platform
* Bonus Tokens Rewards will be paid out to users who build merit and credibility
