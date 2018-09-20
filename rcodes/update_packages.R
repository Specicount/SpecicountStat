package_df <- as.data.frame(installed.packages("/Library/Frameworks/R.framework/Versions/3.5/Resources/library/"))
package_list <- as.character(package_df$Package)
install.packages(package_list)