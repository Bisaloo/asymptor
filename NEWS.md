# asymptor 1.1.0

## Minor changes

* there is now a warning about a possible flaw in the methods in the README, the DESCRIPTION, and the `estimate_asympto()` function documentation.

# asymptor 1.0

## Major breaking changes

* the public interface of `estimate_asympto()` has changed to take three 
arguments `date`, `cases`, `deaths` instead of one `df` with three columns.
The reason for this change is that the old behaviour forced specific column
names that might not match the datasets from users.

## Minor changes

* Unexported functions now use the `@noRd` roxygen tag, which mean they will
not appear in the manual
* The citation for the package now refers to the correct package

# asymptor 0.2

* First release.
