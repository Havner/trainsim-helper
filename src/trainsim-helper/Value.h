#pragma once

#include "stdafx.h"

#include <string>


#define INVALID					(-99999)
#define ISVALID(n)				((n) > INVALID)
#define INVALID_STRING			"STRING_MISSING"


template<typename T>
T aton(const char*)
{
	return INVALID;
}
template<>
float aton(const char* s)
{
	return (float)atof(s);
}
template<>
double aton(const char* s)
{
	return atof(s);
}
template<>
int aton(const char* s)
{
	return atoi(s);
}

template<typename T>
struct Value
{
	T v;
	Value() : v(INVALID) {}
	Value& operator=(const T& o) {
		v = o;
		return *this;
	}
	Value& operator=(const char* o) {
		v = aton<T>(o);
		return *this;
	}
	operator bool() const {
		return ISVALID(v);
	}
	T operator()() {
		return v;
	}
};

template<>
struct Value<std::string>
{
	std::string v;
	Value() : v(INVALID_STRING) {}
	Value& operator=(const char *o) {
		v = std::string(o);
		return *this;
	}
	operator bool() const {
		return v.compare(INVALID_STRING) != 0;
	}
	const char *operator()() {
		return v.c_str();
	}
};
