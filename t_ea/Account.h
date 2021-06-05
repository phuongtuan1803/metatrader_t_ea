#pragma once
class Account
{
public:
	double balance_ = 0;
	double credit_ = 0;
	LPWSTR company_ = 0;
	LPWSTR currency_ = 0;
	double equity_ = 0;
	double freemargin_ = 0;
	double freemarginmode_ = 0;
	int leverage_ = 0;
	double margin_ = 0;
	LPWSTR name_ = 0;
	int number_ = 0;
	double profit_ = 0;
	LPWSTR server_ = 0;
	int stopoutlevel_ = 0;
	int stopoutmode_ = 0;

	Account() {

	}

	Account(
		const double balance,
		const double credit,
		const LPWSTR company,
		const LPWSTR currency,
		const double equity,
		const double freemargin,
		const double freemarginmode,
		const int leverage,
		const double margin,
		const LPWSTR name,
		const int number,
		const double profit,
		const LPWSTR server,
		const int stopoutlevel,
		const int stopoutmode
		) {
		balance_ = balance;
		credit_ = credit;
		company_ = company;
		currency_ = currency;
		equity_ = equity;
		freemargin_ = freemargin;
		freemarginmode_ = freemarginmode;
		leverage_ = leverage;
		margin_ = margin;
		name_ = name;
		number_ = number;
		profit_ = profit;
		server_ = server;
		stopoutlevel_ = stopoutlevel;
		stopoutmode_ = stopoutmode;
	}
};

