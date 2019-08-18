# FILE. . . . . d:/hak/hlt/src/hlt/language/Makefile
# EDIT BY . . . Hassan Ait-Kaci
# ON MACHINE. . Hp-Dv7
# STARTED ON. . Fri Apr 13 19:48:18 2012
########################################################################
# Last modified on Sat May 11 06:42:26 2019 by hak
########################################################################
HOME		= D:/hak
HLT_HOME	= ${HOME}/hlt

# CVS		= cvs #-d :local:${CVSROOT}
SOURCES		= io/*.java \
		  util/*.java \
		  tools/*.java \
		  syntax/*.java \
		  syntax/xml/*.java \
		  design/*/*.java \
                  jaccapps/*/sources/*.java jaccapps/*/sources/*.grm \
		  Makefile */Makefile */*/Makefile jaccapps/aql/benches

JDOM		= ${HLT_HOME}/classes/jdom-2.0.6/jdom-2.0.6.jar
CLASSPATH	= ${HLT_HOME}/classes;${JDOM}
PACKMAIN	= hlt
PACKPREF	= language
PACKAGE		= ${PACKMAIN}.${PACKPREF}.${PACKNAME}
PACKPATH	= ${PACKMAIN}/${PACKPREF}/${PACKNAME}
CLASSROOT	= ${HLT_HOME}/classes
SRCPATH		= ${HLT_HOME}/src/${PACKMAIN}/${PACKPREF}
PACKSRCDIR	= ${SRCPATH}/${PACKNAME}
CLASSDIR	= ${CLASSROOT}/${PACKPATH}
DOCDIR		= ${HLT_HOME}/doc/${PACKMAIN}/code/${PACKPREF}/${PACKNAME}
SAVEDIR		= ${HLT_HOME}/save/language
REST		= Makefile jaccapps attic
JC		= @javac -classpath "${CLASSPATH}" -O -d "${CLASSROOT}" -Xlint:deprecation #-Xlint:unchecked
SAY		= @echo "***"
RM		= @/usr/bin/rm
TRASH		= ${PACKSRCDIR}/,* ${PACKSRCDIR}/,.* ${PACKSRCDIR}/*~ \
		  ${PACKSRCDIR}/@*@ ${PACKSRCDIR}/.*~ core 
# Hilite command:
HL		= @java -classpath ${HLT_HOME}/classes hlt.language.tools.HiliteCommand -! -s / \
		  -css ${HLT_HOME}/classes/resources/Hilite.Style.css \
		  -con ${HLT_HOME}/classes/resources/Hilite.Configuration.Jacc \
# Xml documentation generator dir path:
XMLDOCPATH	= ${SRCPATH}/syntax/xml

NOW		= ${shell date +%Y-%m-%d@%I-%M-%p}
DATEDIR		= ????-??-??@??-??-?M

########################################################################
help, info : tidy
	${SAY} You can \"make\" any of the following:
	${SAY} "  all           compile all the hlt.language package"
	${SAY} "  api           (re)generate the javadoc api of all hlt.language packages"
	${SAY} "  doc           make (re)generate all the documentation for all hlt.language packages"
	${SAY} "  backup        save the current and backup the previous sources of all the hlt.language packages and apps"
	${SAY} "  save          destructively save the current sources of the hlt.language.io package and apps"
	${SAY} "  basic         same as: \"make tools util io syntax\""
	${SAY} "  full          same as: \"make all api doc\""
	${SAY}
	${SAY} "  bootstrap_io  compile only io/FileTools.java io/IO.java"
	${SAY} "  io            compile the complete hlt.language.io package"
	${SAY} "  io_doc        (re)generate the javadoc api of the hlt.language.io package"
	${SAY} "  io_backup     save the current and backup the previously saved sources of the hlt.language.io package"
	${SAY} "  io_save       destructively save the current sources of the hlt.language.io package"
	${SAY}
	${SAY} "  tools         compile the complete hlt.language.tools package"
	${SAY} "  tools_doc     (re)generate the javadoc api of the hlt.language.tools package"
	${SAY} "  tools_backup  save the current and backup the previously saved sources of the hlt.language.tools package"
	${SAY} "  tools_save    destructively save the current sources of the hlt.language.tools package"
	${SAY}
	${SAY} "  util          compile the complete hlt.language.util package"
	${SAY} "  util_doc      (re)generate the javadoc api of the hlt.language.util package"
	${SAY} "  util_backup   save the current and backup the previously saved sources of the hlt.language.util package"
	${SAY} "  util_save     destructively save the current sources of the hlt.language.util package"
	${SAY}
	${SAY} "  syntax        compile the complete hlt.language.syntax package"
	${SAY} "  syntax_doc    (re)generate the javadoc api of the hlt.language.syntax packages (including xml doc)"
	${SAY} "  syntax_backup save the current and backup the previously saved sources of the hlt.language.syntax package"
	${SAY} "  syntax_save   destructively save the current sources of the hlt.language.syntax package"
	${SAY} "  xml           (re)generate the hlt.language.syntax.xml package and documentation"
	${SAY}
	${SAY} "  design        compile the complete hlt.language.design package"
	${SAY} "  design_doc    (re)generate the javadoc api of the hlt.language.design package"
	${SAY} "  design_backup save the current and backup the previously saved sources of the hlt.language.design package"
	${SAY} "  design_save   destructively save the current sources of the hlt.language.design package"
	${SAY} "  design_all    invoke \"make all\" on ./design/Makefile"
	${SAY} "  design_full   invoke \"make full\" on ./design/Makefile"
	${SAY}
	${SAY} "  help          print this information"
	${SAY} "  info          print this information"
########################################################################
single: syntax xml
########################################################################
all: tools util io syntax design_all
	${SAY} All ${PACKMAIN}.${PACKPREF} packages have been regenerated
########################################################################
design: design_all
########################################################################
full: tools util io syntax doc design_full api
########################################################################
api: clean
	@make -C ${HLT_HOME}/src all
########################################################################
doc: tools_doc util_doc io_doc syntax_doc design_doc
########################################################################
save: tools_save util_save io_save syntax_save design_save rest_save
########################################################################
backup: tools_backup util_backup io_backup syntax_backup design_backup rest_backup
########################################################################
util: util_pack
########################################################################
tools: bootstrap_io tools_pack
########################################################################
io: io_pack
########################################################################
syntax: syntax_pack
########################################################################
syntax_all: syntax_xml syntax_pack syntax_doc
########################################################################
design_all:
	@make -f "${SRCPATH}/design/Makefile" "DIRFIX = design/" all
########################################################################
design_doc:
	${SAY} Generating the documentation of the source files of the hlt.language.design.* packages
	@make -f "${SRCPATH}/design/Makefile" "DIRFIX = design/" doc
########################################################################
design_full:
	@make -f "${SRCPATH}/design/Makefile" "DIRFIX = design/" full
########################################################################
bootstrap_io:
	${SAY} Compiling io bootstrap classes...
	${JC} io/FileTools.java io/IO.java
	${SAY} Compilation of bootstrap classes done
########################################################################
util_pack:
	@make -f "${SRCPATH}/Makefile" "PACKNAME=util" gen_pack
tools_pack:
	@make -f "${SRCPATH}/Makefile" "PACKNAME=tools" gen_pack
io_pack:
	@make -f "${SRCPATH}/Makefile" "PACKNAME=io" gen_pack
syntax_pack:
	${SAY} Regenerating the hlt.language.syntax package
	@make -f "${SRCPATH}/Makefile" "PACKNAME=syntax" gen_pack
########################################################################
xml syntax_xml:
	${SAY} Regenerating the hlt.language.syntax.xml package and documentation
	@make -C "${XMLDOCPATH}" all > /dev/null
	${SAY} The XmlAnnotationParser classes have been deployed!
########################################################################
util_doc:
	${SAY} Generating the documentation of the source files of the hlt.language.util package
	@make -f "${SRCPATH}/Makefile" "PACKNAME=util" gen_doc
tools_doc:
	${SAY} Generating the documentation of the source files of the hlt.language.tools package
	@make -f "${SRCPATH}/Makefile" "PACKNAME=tools" gen_doc
io_doc:
	${SAY} Generating the documentation of the source files of the hlt.language.io package
	@make -f "${SRCPATH}/Makefile" "PACKNAME=io" gen_doc
syntax_doc:
	${SAY} Generating the documentation of the source files of the hlt.language.syntax packages
	@make -f "${SRCPATH}/Makefile" "PACKNAME=syntax" gen_doc
	${SAY} Generating XML annotation documentation ...
	@make -C "${XMLDOCPATH}" doc > /dev/null
	${SAY} Moving XML annotation documentation files to ${DOCDIR}syntax/xml/
	@cp -r "${XMLDOCPATH}/XmlAnnotationDoc" "${DOCDIR}syntax/xml/"
	${SAY} See grammar XML hyperdocumentation in ${DOCDIR}000StartHere.html
########################################################################
util_save:
	@make -f "${SRCPATH}/Makefile" "PACKNAME=util" gen_save
tools_save:
	@make -f "${SRCPATH}/Makefile" "PACKNAME=tools" gen_save
io_save:
	@make -f "${SRCPATH}/Makefile" "PACKNAME=io" gen_save
syntax_save:
	@make -f "${SRCPATH}/Makefile" "PACKNAME=syntax" gen_save
#	@make -C "${SRCPATH}/syntax/xml" save
design_save:
	@make -f "${SRCPATH}/Makefile" "PACKNAME=design" gen_save
#	@make -f "${SRCPATH}/design/Makefile" "DIRFIX = design/" save
rest_save: clean
	@tar cvf ${PACKMAIN}.${PACKPREF}.rest.tar ${REST} > /dev/null
	@gzip ${PACKMAIN}.${PACKPREF}.rest.tar
	${SAY} Removing previously saved version of ${REST} files
	@rm -rf ${SAVEDIR}/rest/${DATEDIR}
	${SAY} Saving rest \(${REST}\) files
	@mkdir ${SAVEDIR}/rest/${NOW}
	@mv -f ${PACKMAIN}.${PACKPREF}.rest.tar.gz ${SAVEDIR}/rest/${DATEDIR}
########################################################################
gen_save: clean
	@tar cvf ${PACKAGE}.tar ${PACKNAME} > /dev/null
	@gzip ${PACKAGE}.tar
	${SAY} Removing previously saved version of package ${PACKAGE}
	@rm -rf ${SAVEDIR}/${PACKNAME}/${DATEDIR}
	${SAY} Saving current package ${PACKAGE} in ${SAVEDIR}/${PACKNAME}
	@mkdir ${SAVEDIR}/${PACKNAME}/${NOW}
	@mv -f ${PACKAGE}.tar.gz ${SAVEDIR}/${PACKNAME}/${DATEDIR}
########################################################################
util_backup:
	@make -f "${SRCPATH}/Makefile" "PACKNAME=util" gen_backup
tools_backup:
	@make -f "${SRCPATH}/Makefile" "PACKNAME=tools" gen_backup
io_backup:
	@make -f "${SRCPATH}/Makefile" "PACKNAME=io" gen_backup
syntax_backup:
	@make -f "${SRCPATH}/Makefile" "PACKNAME=syntax" gen_backup
design_backup:
	@make -f "${SRCPATH}/Makefile" "PACKNAME=design" gen_backup
rest_backup: clean
	@tar cvf ${PACKMAIN}.${PACKPREF}.rest.tar ${REST} > /dev/null
	@gzip ${PACKMAIN}.${PACKPREF}.rest.tar
	${SAY} Backing up previously saved version in ${SAVEDIR}/rest/BACKUPS
	@mv ${SAVEDIR}/rest/${DATEDIR} ${SAVEDIR}/rest/BACKUPS
	${SAY} Saving ${PACKMAIN}.${PACKPREF}.rest.tar.gz in ${SAVEDIR}/rest
	@mkdir ${SAVEDIR}/rest/${NOW}
	@mv -f ${PACKMAIN}.${PACKPREF}.rest.tar.gz ${SAVEDIR}/rest/${DATEDIR}
########################################################################
gen_backup: clean
	@tar cvf ${PACKAGE}.tar ${PACKNAME} > /dev/null
	@gzip ${PACKAGE}.tar
	${SAY} Backing up previously saved version in ${SAVEDIR}/${PACKNAME}/BACKUPS
	@mv ${SAVEDIR}/${PACKNAME}/${DATEDIR} ${SAVEDIR}/${PACKNAME}/BACKUPS
	${SAY} Saving current package ${PACKAGE} in ${SAVEDIR}/${PACKNAME}
	@mkdir ${SAVEDIR}/${PACKNAME}/${NOW}
	@mv -f ${PACKAGE}.tar.gz ${SAVEDIR}/${PACKNAME}/${DATEDIR}
########################################################################
gen_pack: tidy
	${SAY} Compiling ${PACKAGE} package...
	${JC} ${PACKNAME}/*.java
	${SAY} Regeneration of ${PACKAGE} package completed
########################################################################
gen_doc: tidy
	${SAY} Generating hilited HTML source code for ${PACKAGE} package
	${HL} -p ${PACKAGE} -d ${DOCDIR} ${PACKSRCDIR}/*.java #> /dev/null
########################################################################
tidy:
	${SAY} Tidying up directory ${PACKSRCDIR}
	${RM} -rf ${TRASH}
########################################################################
basic: clean
	${SAY} Compiling basic language package set 
	${JC} ${SRCPATH}/tools/*.java ${SRCPATH}/util/*.java ${SRCPATH}/io/*.java ${SRCPATH}/syntax/*.java 
########################################################################
cvs: clean
# Importing as done above below works, but none of the following do! It's because cvs does
# not work recursively but only directly on file names in the directory where they reside!
#
# A possible workaround is to walk dowmn the dir trees using find:
# First, add all the directories, but not any named "CVS" (because cvs barfs on dirs named "CVS"):
# find . -type d \! -name CVS -exec cvs add '{}' \;
# Then add all the files, excluding anything in a CVS directory:
# find . \( -type d -name CVS -prune \) -o \( -type f -exec cvs add '{}' \; \)
#
# If this works, then it should be refined to add only specific files not everything. Or write as
# shell script that takes a list of specific pattern files.
#
# NOTE TO MYSELF: Do that when you have time to spare ... for now the hell with cvs - use
# "make backup instead"
# (Also need to check dir path specified for hlt project in ${CVSROOT}/CVSROOT/modules).
#
#	${SAY} Importing hlt project files into ${CVSROOT} repository
#	${CVS} import -m "Initial check-in" hlt HLT INITIAL || true	# Initial check-in
#	${SAY} Checking out files from ${CVSROOT} repository for hlt project
#	${CVS} checkout ${SOURCES} || true	# To create local copies of files from the repository
#	${SAY} Committing files to ${CVSROOT} repository for hlt project
#	${CVS} commit ${SOURCES} || true	# To commmit (e.g. replace) files into the respository
#	${SAY} Adding files to ${CVSROOT} repository for hlt project
#	${CVS} add ${SOURCES} || true		# To add latest versions of the source files to the respository
########################################################################
clean:
	@make -s -C ${HOME} -f .cleanup "ROOT = ${PWD}" > /dev/null
########################################################################
