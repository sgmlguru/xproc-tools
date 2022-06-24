<p:declare-step
	name="threaded-xslt"
	type="ccproc:threaded-xslt"
	exclude-inline-prefixes="#all"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:c="http://www.w3.org/ns/xproc-step"
	xmlns:data="http://www.corbas.co.uk/ns/transforms/data"
	xmlns:meta="http://www.corbas.co.uk/ns/transforms/meta"
	xmlns:cx="http://xmlcalabash.com/ns/extensions"
	xmlns:p="http://www.w3.org/ns/xproc"
	xmlns:ccproc="http://www.corbas.co.uk/ns/xproc/steps"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="3.0">

	<p:documentation> This program and accompanying files are copyright 2008, 2009, 2011, 2012,
		2013, 2015 Corbas Consulting Ltd. This program is free software: you can redistribute it
		and/or modify it under the terms of the GNU General Public License as published by the Free
		Software Foundation, either version 3 of the License, or (at your option) any later version.
		This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
		without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
		See the GNU General Public License for more details. You should have received a copy of the
		GNU General Public License along with this program. If not, see
		http://www.gnu.org/licenses/. If your organisation or company are a customer or client of
		Corbas Consulting Ltd you may be able to use and/or distribute this software under a
		different license. If you are not aware of any such agreement and wish to agree other
		license terms you must contact Corbas Consulting Ltd by email at corbas@corbas.co.uk. </p:documentation>


	<p:documentation>
		<p xmlns="http:/wwww.w3.org/1999/xhtml">This step takes a sequence of transformation
			elements and executes them recursively applying the each stylesheet to the result of the
			previous stylesheet. The final result is the result of threading the input document
			through each of the stylesheets in turn.</p>
		<p xmlns="http:/wwww.w3.org/1999/xhtml">Secondary documents are ignored.</p>
	</p:documentation>

	<p:input port="source" sequence="false" primary="true">
		<p:documentation>
			<p xmlns="http://www.w3.org/1999/xhtml">The primary input for the step is the document
				to be transformed.</p>
		</p:documentation>
	</p:input>

	<p:input port="stylesheets" sequence="true">
		<p:documentation>
			<p xmlns="http://www.w3.org/1999/xhtml">The secondary input port for the step contains
				the sequence of xslt stylesheets (already loaded) to be executed.</p>
		</p:documentation>
	</p:input>

	<p:input port="parameters" sequence="true">
		<p:documentation>
			<p xmlns="http:/www.w3.org/1999/xhtml">The parameters to be passed to the p:xslt
				steps.</p>
		</p:documentation>
	</p:input>

	<p:output port="result" primary="true" sequence="true">
		<p:documentation>
			<p xmlns="http://www.w3.org/1999/xhtml">The output of the step is the transformed
				document.</p>
		</p:documentation>
		<p:pipe port="matched" step="get-last-document"/>
	</p:output>

	<p:output port="intermediates" sequence="true">
		<p:documentation>
			<p xmlns="http://www.w3.org/1999/xhtml">The output of each step in the sequence.
				document. Each result is wrapped in a c:result element </p>
		</p:documentation>
		<p:pipe port="result" step="run-threaded-xslt"/>
	</p:output>


	<p:option name="verbose" select="'true'">
		<p:documentation xmlns="http://www.w3.org/1999/xhtml">
			<p>Set this to 'true' to get a listing of each stylesheet as it is applied.</p>
		</p:documentation>
	</p:option>
	
	
	<p:declare-step
		name="convert-meta"
		type="ccproc:convert-meta-to-param">
		<p:documentation xmlns="http:/wwww.w3.org/1999/xhtml">
			<p>This step converts attributes in the http://www.corbas.co.uk/ns/transforms/meta
				namesapce to parameters to be applied to the stylesheet. The attributes are not
				removed from the stylesheet. The result of this a step is a map.</p>
		</p:documentation>

		<p:input port="stylesheet" primary="true">
			<p:documentation xmlns="http:/wwww.w3.org/1999/xhtml">
				<p>The stylesheet to be modified</p>
			</p:documentation>
		</p:input>

		<p:output port="result" primary="true">
			<p:pipe port="result" step="build-parameters"/>
		</p:output>


		<p:xslt
			name="build-parameters"
			version="3.0">

			<!-- WE ARE PROCESSING A STYLESHEET! -->
			<p:with-input port="source">
				<p:pipe port="stylesheet" step="convert-meta"/>
			</p:with-input>
			<p:with-input port="stylesheet">
				<p:document href="../xslt/build-params.xsl"/>
				<!-- http://xml.corbas.co.uk/xml/xproc-tools/xslt/build-params.xsl -->
			</p:with-input>
		</p:xslt>

	</p:declare-step>


	<p:declare-step
		name="threaded-xslt-impl"
		type="ccproc:threaded-xslt-impl"
		exclude-inline-prefixes="#all">

		<p:documentation>
			<p xmlns="http:/wwww.w3.org/1999/xhtml">Internal implementation for
				ccproc:threaded-xslt. Handles the recursion and intermediate gathering without the
				need to expose the workings.</p>
		</p:documentation>

		<p:input port="source" sequence="false" primary="true">
			<p:documentation>
				<p xmlns="http://www.w3.org/1999/xhtml">Document to be transformed.</p>
			</p:documentation>
		</p:input>

		<p:input port="stylesheets" sequence="true">
			<p:documentation>
				<p xmlns="http://www.w3.org/1999/xhtml">Sequence of stylesheets</p>
			</p:documentation>
		</p:input>

		<p:input port="parameters" sequence="true">
			<p:documentation>
				<p xmlns="http:/www.w3.org/1999/xhtml">XSLT parameters</p>
			</p:documentation>
		</p:input>

		<p:output port="result" primary="true" sequence="true">
			<p:documentation>
				<p xmlns="http://www.w3.org/1999/xhtml">The output is the results of each stage of
					the transformation in sequence.</p>
			</p:documentation>
			<p:pipe port="result" step="determine-recursion"/>
		</p:output>
		

		<p:option name="verbose" select="'true'">
			<p:documentation xmlns="http://www.w3.org/1999/xhtml">
				<p>Set this to 'true' to get a listing of each stylesheet as it is applied.</p>
			</p:documentation>
		</p:option>

		<!-- Split of the first transformation from the sequence -->
		<p:split-sequence
			name="split-stylesheets"
			initial-only="true"
			test="position()=1">
			<p:with-input port="source">
				<p:pipe port="stylesheets" step="threaded-xslt-impl"/>
			</p:with-input>
		</p:split-sequence>

		<!-- How many of these are left? We actually only care to know  if there are *any* hence the limit. -->
		<p:count
			name="count-remaining-transformations"
			limit="1">
			<p:with-input port="source">
				<p:pipe port="not-matched" step="split-stylesheets"/>
			</p:with-input>
		</p:count>
		
		<p:variable name="test" select="number(/c:result)">
			<p:pipe port="result" step="count-remaining-transformations"/>
		</p:variable>
		
		<!--<p:identity message="{if ($test >0) then ('true') else ('false')}"/>-->


		<!-- find any metadata attributes on the stylesheet (these may be
			created by load-sequence-from-file) and convert them to a
			map to pass to Saxon -->
		<ccproc:convert-meta-to-param
			name="additional-params">
			<p:with-input port="stylesheet">
				<p:pipe port="matched" step="split-stylesheets"/>
			</p:with-input>
		</ccproc:convert-meta-to-param>
		
		
		<!-- what are we running (verbose only) -->
		<p:choose name="check-verbose">
			<p:when test="$verbose = 'true'">
				<!--<cx:message>

					<p:with-option name="message" select="concat('Running - ', 
							(/xsl:stylesheet/@meta:description, 
							/xsl:stylesheet/@meta:name, 
							tokenize(document-uri(/), '/')[last()])
							[1])">
						<p:pipe port="matched" step="split-stylesheets"/>
					</p:with-option>
				</cx:message>-->
				
				<!--<p:identity message="{
					'Running - ' ||
					/xsl:stylesheet/@meta:description ||
					/xsl:stylesheet/@meta:name ||
					tokenize(document-uri(/), '/')[last()][1]
					}">
					<p:with-input>
						<p:pipe port="matched" step="split-stylesheets"/>
					</p:with-input>
				</p:identity>-->
				
				<p:identity>
					<p:with-input>
						<p:inline>
							<p>Running</p>
						</p:inline>
					</p:with-input>
				</p:identity>
				
			</p:when>
			<p:otherwise>
				<p:identity/>
			</p:otherwise>
		</p:choose>
		<p:sink/>

		<!-- run the stylesheet, merging parameters - params from the
				XProc run override those in the manifest -->
		<p:xslt name="run-single-xslt" version="3.0">
			<p:with-input port="stylesheet">
				<p:pipe port="matched" step="split-stylesheets"/>
			</p:with-input>
			<p:with-input port="source">
				<p:pipe port="source" step="threaded-xslt-impl"/>
			</p:with-input>
			<p:with-option name="parameters" select=".">
				<p:pipe port="result" step="additional-params"/>
				<p:pipe port="parameters" step="threaded-xslt-impl"/>
			</p:with-option>
		</p:xslt>


		<!-- If there are any remaining stylesheets recurse. The primary
    	input is the result of our XSLT and the remaining
    	sequence from split-transformations above will be the 
    	transformation sequence 
   		-->
		<p:choose name="determine-recursion">

			<!--<p:xpath-context>
				<p:pipe port="result" step="count-remaining-transformations"/>
			</p:xpath-context>-->
			
			<!-- If we have any transformations remaining recurse -->
			<p:when test="$test > 0">
				
				<p:output port="result" sequence="true">
					<p:pipe port="result" step="run-single-xslt"/>
					<p:pipe port="result" step="continue-recursion"/>
				</p:output>

				<ccproc:threaded-xslt-impl name="continue-recursion">

					<p:with-input port="stylesheets">
						<p:pipe port="not-matched" step="split-stylesheets"/>
					</p:with-input>

					<p:with-input port="source">
						<p:pipe port="result" step="run-single-xslt"/>
					</p:with-input>

					<p:with-input port="parameters">
						<p:pipe port="parameters" step="threaded-xslt-impl"/>
					</p:with-input>

					<!-- make sure the verbose option is also transmitted -->
					<p:with-option name="verbose" select="$verbose"/>

				</ccproc:threaded-xslt-impl>

			</p:when>

			<!-- Otherwise, pass the output of our transformation back as the result -->
			<p:otherwise>

				<p:output port="result" sequence="true">
					<p:pipe port="result" step="terminate-recursion"/>
				</p:output>

				<p:identity name="terminate-recursion">
					<p:with-input port="source">
						<p:pipe port="result" step="run-single-xslt"/>
					</p:with-input>
				</p:identity>

			</p:otherwise>

		</p:choose>

	</p:declare-step>


	<!-- run it all -->
	<ccproc:threaded-xslt-impl name="run-threaded-xslt">
		
		<p:with-input port="source">
			<p:pipe port="source" step="threaded-xslt"/>
		</p:with-input>

		<p:with-input port="stylesheets">
			<p:pipe port="stylesheets" step="threaded-xslt"/>
		</p:with-input>

		<p:with-input port="parameters">
			<p:pipe port="parameters" step="threaded-xslt"/>
		</p:with-input>
		
		<p:with-option name="verbose" select="$verbose"/>

	</ccproc:threaded-xslt-impl>
	
	
	<p:variable
		name="count"
		select="count(collection())"
		collection="true"
		pipe="@run-threaded-xslt"/>


	<p:split-sequence
		name="get-last-document"
		test="position() = {$count}">
		<p:with-input>
			<p:pipe port="result" step="run-threaded-xslt"/>
		</p:with-input>
	</p:split-sequence>


</p:declare-step>
