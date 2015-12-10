%include('header',title="confirm")

<html lang=en>
<head>
<title>Mendel - web interface</title>
<script type="text/javascript" src="/static/apps/mendel/mendel.js"></script>
<style>
  input[type="text"] {width:10em;}
  .form-horizontal .control-label{
    text-align:left;
  }
  .tab-content {
    /*background-color: #dfdfdf;*/ 
    border: 1px solid #ddd;
    padding: 10px;
  }
  tr:hover {
      background-color: #fff;
  }
  body { 
    /* background: #dfdfdf !important; */
    /*padding-top: 65px;*/ 
  }
  tr {
    background-color: #fff;
  }
  input[type="number"] {
    width:120px;    
  }
</style>
</head>

%include('navbar')
%include('apps/alert')
<div id="memory" align="center" class="alert-info"></div>
<div id="danger" align="center" class="alert-danger"></div>
<div id="warning" align="center" class="alert-warning"></div>

<body onload="fxn_init()">

<div class="container-fluid">

<form role="form" class="form-horizontal" name="mendel_input" 
      method="post" action="/confirm" novalidate>
<input type="hidden" name="app" value="{{app}}">
<input type="hidden" name="cid" value="{{cid}}">

<div class="col-xs-12" style="height:5px"></div>

<div class="form-group">
  <div class="col-xs-2">
    <button type="submit" class="btn btn-success"> <!-- pull-right -->
      Continue <em class="glyphicon glyphicon-forward"></em> </button>
  </div>
  <label for="desc" style="text-align:right" class="control-label col-xs-4">
    <a href="#" data-toggle="tooltip" title="Separate labels by commas">Labels:</a></label>
  <div class="col-xs-6">
    <input type="text" id="desc" name="desc" class="form-control" style="width:100%"
           data-role="tagsinput" title="e.g. v2.5.1,bottleneck">
  </div>
</div>

<div class="tribe" id="tribediv" style="display:none">
  Tribe:
  <select class="form-control" name="tribe_id">
     <option VALUE=".001">.001</option>
     <option VALUE=".002">.002</option>
  </select>
</div> 

<a href="/static/apps/mendel/help.html" class="help btn btn-info" target="status">help</a>
<!-- data-toggle="modal" data-target="#myModal" -->
<div>

  <!-- Nav tabs -->
  <!--<ul class="nav nav-tabs" role="tablist">-->
  <ul class="nav nav-pills" role="tablist">
    <li role="presentation" class="active"><a href="#basic" aria-controls="home" role="tab"    data-toggle="tab">Basic</a></li>
    <li role="presentation"><a href="#mutation" aria-controls="profile" role="tab" 
        data-toggle="tab">Mutation</a></li>
    <li role="presentation"><a href="#selection" aria-controls="messages" role="tab" 
        data-toggle="tab">Selection</a></li>
    <li role="presentation"><a href="#population" aria-controls="settings" role="tab" 
        data-toggle="tab">Population</a></li>
    <!-- <li role="presentation"><a href="#substructure" aria-controls="settings" role="tab" 
        data-toggle="tab">Substructure</a></li> -->
    <li role="presentation"><a href="#computation" aria-controls="settings" role="tab" 
        data-toggle="tab">Computation</a></li>
    <li role="presentation"><a href="#special" aria-controls="settings" role="tab" 
        data-toggle="tab">Special Applications</a></li>
  </ul>

  <!--*************************** BASIC TAB *******************************-->
  <div class="tab-content">
    <div role="tabpanel" class="tab-pane fade in active" id="basic">
      <div id="mutn_rate" class="form-group">
        <label for="mutn_rate" class="control-label col-xs-6">
          1. Total non-neutral mutation rate:<br>
             &nbsp;&nbsp;&nbsp; (per individual per generation)</label>
        <div class="col-xs-6">
          <input type="number" id="mutn_rate" name="mutn_rate"
                 value="{{mutn_rate}}" class="form-control"
                 min="0" max="10000" step="1"
                 onchange="compute_u(); fxn_auto_malloc(); validate(this)" 
                 title="0 - 10,000; can be fraction e.g. 0.5">
        </div>
      </div>
      <div class="form-group">
        <label for="frac_fav_mutn" class="control-label col-xs-6">
          2. Beneficial/deleterious ratio within non-neutral mutations:</label>
        <div class="col-xs-6">
          <input type="number" id="frac_fav_mutn" name="frac_fav_mutn"
                 value="{{frac_fav_mutn}}" class="form-control"
                 min="0.0" max="1.0" step="0.01"
                 onchange="compute_u(); fxn_auto_malloc(); validate(this)"
                 title="0.0 - 1.0 (e.g. if 1:1000, enter 0.001)">
        </div>
      </div>
      <div class="form-group">
        <label for="uben" class="control-label col-xs-6" style="text-align:right">
            beneficial mutation rate:</label>
        <div class="col-xs-6">
          <input type="number" name="uben" id="uben" class="form-control" readOnly=true>
        </div>
      </div>
      <div class="form-group">
        <LABEL for="udel" class="control-label col-xs-6" style="text-align:right">
            deleterious mutation rate:</label>
        <div class="col-xs-6">
          <input type="number" name="udel" id="udel" class="form-control" readOnly=true>
        </div>
      </div>
      <div class="form-group">
        <label id="pgr_label" for="reproductive_rate" class="control-label col-xs-6">
          3. Reproductive rate:</label>
        <div class="col-xs-6">
          <input type="number" class="form-control" id="reproductive_rate" 
                 name="reproductive_rate" value="{{reproductive_rate}}"
                 onchange="fxn_auto_malloc(); validate(this)"
                 min="1" max="6" step="1">
        </div>
      </div>
      <div class="form-group">
        <label id="pop_size_label" for="pop_size" class="control-label col-xs-6">
            4. Population size (per subpopulation):</label>
          <div class="col-xs-6">
            <input type="number" id="pop_size" name="pop_size" data-warning="1000"
                   value="{{pop_size}}" class="form-control"
                   onchange="fxn_auto_malloc(); validate(this)"
                   min="2" max="2000" step="1" title="2 - 5,000">
          </div>
      </div>
      <div class="form-group">
        <label id="gen_label" for="num_generations" class="control-label col-xs-6">
            5. Generations:</label>
        <div class="col-xs-6">
          <input type="number" id="num_generations" name="num_generations" 
                 min="1" max="20000" step="100" data-warning="10000"
                 onchange="fxn_auto_malloc(); validate(this)" 
                 class="form-control" value="{{num_generations}}" title="1 - 100,000">
        </div>
      </div>
    </div>

    <!--*************************** MUTATION TAB *******************************-->
    <div role="tabpanel" class="tab-pane fade" id="mutation">
      <div class="form-group">
        <label for="fitness_distrib_type" class="control-label col-xs-6">
          1. Distribution type:</label>
        <div class="col-xs-6">
          <select id="fitness_distrib_type" name="fitness_distrib_type" 
                  class="form-control" style="width:auto"
                  onchange="fxn_fitness_distrib_type_change();">
          %opts = {'1': 'Natural distribution (Weibull)', '0': 'All mutations equal'}
          %for key, value in opts.iteritems():
            %if key == fitness_distrib_type:
              <option selected value="{{key}}">{{value}}
            %else:
              <option value="{{key}}">{{value}}
            %end
          %end
          </select>
        </div>
      </div>

      <div id="ufe_div" style="display:none">

        <div class="form-group">
          <label for="uniform_fitness_effect_del" class="control-label col-xs-6">        
            &nbsp;&nbsp;&nbsp; a. equal effect for each deleterious mutation:</label>
          <div class="col-xs-6">
            <input type="number" name="uniform_fitness_effect_del" class="form-control"
                   min="0" max="0.1" step="0.001" title="0 - 0.1" onchange="validate(this)"
                   value="{{uniform_fitness_effect_del}}">
          </div>
        </div>

        <div class="form-group">
          <label for="uniform_fitness_effect_fav" class="control-label col-xs-6">        
            &nbsp;&nbsp;&nbsp; b. equal effect for each beneficial mutation:</label>
          <div class="col-xs-6">
            <input type="number" name="uniform_fitness_effect_fav" class="form-control"
                   min="0" max="0.1" step="0.0001" title="0 - 0.1" onchange="validate(this)" 
                   value="{{uniform_fitness_effect_fav}}">
          </div>
        </div>

      </div>

      <div id="weibull_div" style="display:none">

        <div class="form-group">
          <label class="control-label col-xs-12">
            &nbsp;&nbsp;&nbsp;
            Parameters shaping Weibull distribution of mutation effects:</label>
        </div>

        <div class="form-group">
          <label for="genome_size" class="control-label col-xs-6">
            &nbsp;&nbsp;&nbsp;
            a. functional genome size:<br> 
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <font size="-1">&rarr; G<sub>functional</sub> = 
              G<sub>actual</sub> - G<sub>junk</sub></font> </label>
          <div class="col-xs-6">
            <input type="number" name="genome_size" id="hgs" accesskey="1"
                   value="{{genome_size}}" class="form-control"
                   min="100" max="1e11" step="1000" onchange="validate(this)"
                   title="100 - 100 billion">
          </div>
        </div>

        <div class="form-group">
          <label for="high_impact_mutn_fraction" class="control-label col-xs-6">
            &nbsp;&nbsp;&nbsp; b. fraction of del. mutations with "major effect":</label>
          <div class="col-xs-6">
            <input type="number" name="high_impact_mutn_fraction"
                   value="{{high_impact_mutn_fraction}}" class="form-control"
                   min="0.0001" max="0.9" step="0.0001" title="0.0001 - 0.9"
                   onchange="validate(this)">
          </div>
        </div>

        <div class="form-group">
          <label for="high_impact_mutn_threshold" class="control-label col-xs-6">
                &nbsp;&nbsp;&nbsp; c. minimum del. effect defined as "major":</label>
          <div class="col-xs-6">
            <input type="number" name="high_impact_mutn_threshold"
                   value="{{high_impact_mutn_threshold}}" class="form-control"
                   min="0.01" max="0.9" step="0.01" title="0.01 - 0.9"
                   onchange="validate(this)">
          </div>
        </div>
        
        <div class="form-group">
          <label for="high_impact_mutn_threshold" class="control-label col-xs-6">
            &nbsp;&nbsp;&nbsp;
            d. maximum beneficial fitness effect:</label>
          <div class="col-xs-6">
            <input type="number" name="max_fav_fitness_gain" accesskey="2" 
                   class="form-control" value="{{max_fav_fitness_gain}}" 
                   min="0.000001" max="0.01" step="0.000001" title="0.000001 - 0.01"
                   onchange="validate(this)">
          </div>
        </div>

        <input type="hidden" name="max_fav_fitness_gain" 
               value="{{max_fav_fitness_gain}}">
        <input type="hidden" name="num_initial_fav_mutn" 
               value="{{num_initial_fav_mutn}}">

      </div> <!-- weibull_div -->

      <hr>

      <div class="form-group">
        <label class="control-label col-xs-6">
          2. Mutations &mdash; dominant vs. recessive?</label>
      </div>

      <div id="crdiv">
        <div class="form-group">
          <label for="fraction_recessive" class="control-label col-xs-6">
            &nbsp;&nbsp;&nbsp;
            a. fraction recessive (rest dominant):</label>
          <div class="col-xs-6">
            <input type="number" name="fraction_recessive"
                   value="{{fraction_recessive}}" min="0" max="1" step="0.1"
                   id="fraction_recessive" class="form-control" title="0.0 - 1.0"
                   onchange="validate(this)">
          </div>
        </div>
        <div class="form-group">
          <label for="recessive_hetero_expression" class="control-label col-xs-6">
            &nbsp;&nbsp;&nbsp;
            b. expression of recessive mutations (in heterozygote):</label>
          <div class="col-xs-6">
            <input type="number" name="recessive_hetero_expression"
                   value="{{recessive_hetero_expression}}" class="form-control"
                   min="0" max="0.5" step="0.1" title="0.0 - 0.5"
                   onchange="validate(this)">
          </div>
        </div>
        <div class="form-group">
          <label for="dominant_hetero_expression" class="control-label col-xs-6">
            &nbsp;&nbsp;&nbsp;
            c. expression of dominant mutations (in heterozygote):</label>
          <div class="col-xs-6">
            <input type="number" name="dominant_hetero_expression"
                   value="{{dominant_hetero_expression}}" class="form-control"
                   min="0.5" max="1.0" step="0.1" title="0.5 - 1.0"
                   onchange="validate(this)">
          </div>
        </div>   
      </div>

      <hr>
      <div class="form-group">
        <label for="combine_mutns" class="control-label col-xs-6">
          3. Combine mutations effects non-additively?</label>
        <div class="col-xs-6">
          <input type="checkbox" name="combine_mutns"
                 onclick="fxn_combine_mutns()" value="on" 
                  %if float(multiplicative_weighting) > 0:
                    checked
                  %end
          >
        </div>
      </div>

      <div id="mwdiv" style="display:none">
        <div class="form-group">
          <label for="multiplicative_weighting" class="control-label col-xs-6">
                &nbsp;&nbsp;&nbsp; :: fraction multiplicative effect:</label>
          <div class="col-xs-6">         
            <input type="number" name="multiplicative_weighting"
                   id="multiplicative_weighting" class="form-control"
                   value="{{multiplicative_weighting}}"
                   min="0" max="1" step="0.1" 
                   onchange="onchange=validate(this)"
                   title="0.0 - 1.0">
          </div>
        </div>
      </div>

      <hr>

      <div class="form-group">
        <label for="synergistic_epistasis" class="control-label col-xs-6">
          4. Include mutation-mutation interactions (synergistic epistasis)?</label>
        <div class="col-xs-6">
          <input type="checkbox" name="synergistic_epistasis"
                 value="on" onclick="fxn_synergistic_epistasis()"
                 %if synergistic_epistasis=='T':
                    checked
                 %end
          >
        </div>
      </div>
      <div class="form-group">
        <label for="se_nonlinked_scaling" class="control-label col-xs-6">
           &nbsp;&nbsp;&nbsp;
            a. scaling factor for non-linked SE interactions:</label>
        <div class="col-xs-6">
          <input type="number" name="se_nonlinked_scaling"
                 value="{{se_nonlinked_scaling}}" class="form-control"
                 min="0.0" max="1.0" step="0.1"
                 onchange="validate(this)" title="0.0 - 1.0" >
        </div>
      </div>

      <div class="form-group">
        <label for="se_linked_scaling" class="control-label col-xs-6">               
          &nbsp;&nbsp;&nbsp; b. scaling factor for linked SE interactions:</label>
        <div class="col-xs-6">
          <input type="number" name="se_linked_scaling"
                 value="{{se_linked_scaling}}" class="form-control"
                 min="0.0" max="1.0" step="0.1"
                 onchange="validate(this)" title="0.0 - 1.0" >
        </div>
      </div>

      <hr>
      <div class="form-group">
        <label for="upload_mutations" class="control-label col-xs-6">               
          5. Upload set of custom mutations?</label>
        <div class="col-xs-6">
          <input type="checkbox" name="upload_mutations"
                 value="on" onclick="show_hide_mutation_upload_form(1)" disabled="true"
                   %if upload_mutations=='T':
                    checked
                   %end
          >
        </div>
      </div>

      <hr>

      <div class="form-group">
        <label for="allow_back_mutn" class="control-label col-xs-6">               
          6. Allow back mutations?</label>
        <div class="col-xs-6">
          <input type="checkbox" name="allow_back_mutn"
                 value="on" onclick="check_back_mutn()"
                   %if allow_back_mutn=='T':
                    checked
                   %end
          >
        </div>
      </div>

    </div>

    <!--*************************** SELECTION TAB *******************************-->
    <div role="tabpanel" class="tab-pane fade" id="selection">

      <div class="form-group">
        <label for="fraction_random_death" class="control-label col-xs-6">
          <ol><li>Fraction of offspring lost apart from selection ("random death"):</ol>
        </label>
        <div class="col-xs-6">
          <input type="number" name="fraction_random_death" class="form-control"
                 value="{{fraction_random_death}}"
                 min="0" max="0.99" step="0.1"
                 onchange="validate(this); compute_memory()"
                 title="0.0 - 0.99">
        </div>
      </div>

      <div class="form-group">
        <label for="heritability" class="control-label col-xs-6">
          <ol start=2><li>Heritability:</ol> </label>
        <div class="col-xs-6">
          <input type="number" name="heritability" title="0 - 1"
                 min="0" max="1" step="0.1"
                 onchange="validate(this)" class="form-control"
                 value="{{heritability}}">
        </div>
      </div>

      <div class="form-group">
        <label for="non_scaling_noise" class="control-label col-xs-6">
          <ol start=3><li>Non-scaling noise:</ol></label>
        <div class="col-xs-6">
          <input type="number" name="non_scaling_noise" title="0 - 1"
                 min="0" max="1" step="0.1"
                 onchange="validate(this)" class="form-control"
                 value="{{non_scaling_noise}}">
        </div>
      </div>

      <div class="form-group">
        <label for="fitness_dependent_fertility" class="control-label col-xs-6">
          <ol start=4><li>Fitness-dependent fecundity decline?</ol></label>
        <div class="col-xs-6">
          <input type="checkbox" name="fitness_dependent_fertility"
                 accesskey="4" value="on"
                 %if fitness_dependent_fertility=='T':
                    checked
                 %end
          >
        </div>
      </div>

      <div class="form-group">
        <label for="selection_scheme" class="control-label col-xs-6">
          <ol start=5><li>Selection scheme:</ol></label>
        <div class="col-xs-6">
          <select id="selection_scheme" name="selection_scheme" accesskey="5"
                  class="form-control" style="width:auto" 
                  onchange="fxn_selection(this.value)">
            %opts = {'1': 'Truncation selection', '2': 'Unrestricted probability selection', '3': 'Strict proportionality probability selection', '4': 'Partial truncation selection'}
            %for key, value in opts.iteritems():
              %if key == selection_scheme:
                <option selected value="{{key}}">{{value}}
              %else:
                <option value="{{key}}">{{value}}
              %end
            %end
          </select>
        </div>
      </div>
       
      <div id="ptv">
        <div class="form-group">
          <label for="partial_truncation_value" class="control-label col-xs-6">
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               :: partial truncation parameter, k</label>
          <div class="col-xs-6">
              <input type="number" name="partial_truncation_value"
                  class="form-control" value="{{partial_truncation_value}}" 
                  min="0" max="1" step="0.1"
                  onchange="validate(this)" title="0.0 - 1.0">
          </div>
        </div>
      </div>

    </div>

    <!--*************************** POPULATION TAB ******************************-->
    <div role="tabpanel" class="tab-pane fade" id="population">
      <div class="form-group">
        <label for="recombination_model" class="control-label col-xs-6">
             1. Recombination model:</label>
        <div class="col-xs-6">
          <select id="recombination_model" name="recombination_model" 
                  class="form-control" style="width:auto">
                  %opts = {'1': 'Clonal reproduction', '2': 'Suppressed recombination', '3': 'Full sexual recombination'}
                  %for key, value in opts.iteritems():
                      %if key == recombination_model:
                          <option selected value="{{key}}">{{value}}
                      %else:
                          <option value="{{key}}">{{value}}
                      %end
                  %end
          </select>
        </div>
       </div>       
       
      <div class="form-group">
        <label for="fraction_self_fertilization" class="control-label col-xs-6">
          2. Fraction self fertilization:</label>
        <div class="col-xs-6">
          <input type="number" name="fraction_self_fertilization" title="0 - 1"
                 value="{{fraction_self_fertilization}}" onchange="validate(this)"
                 min="0" max="1" step="0.1" class="form-control">
        </div>
      </div>
       
      <div class="form-group">
        <label for="dynamic_linkage" class="control-label col-xs-6">
          3. Dynamic linkage?</label>
        <div class="col-xs-6">
          <input type="checkbox" name="dynamic_linkage" accesskey="2"
                 value="on" onclick="fxn_dynamic_linkage()"
                 %if dynamic_linkage=='T': 
                    checked
                 %end
          > 
        </div>      
      </div>

      <div class="form-group">
        <label for="haploid_chromosome_number" style="left:20px" class="control-label col-xs-6">
          :: haploid chromosome number:</label>      
        <div class="col-xs-6">
          <input type="number" name="haploid_chromosome_number" title="1 - 100"
                 min="1" max="100" step="1" onchange="validate(this)" class="form-control"
                 value="{{haploid_chromosome_number}}">
        </div>
      </div>

      <div class="form-group">
        <label id="num_linkage_subunits" style="left:20px" for="num_linkage_subunits" 
               class="control-label col-xs-6">
          :: number of linkage subunits:</label>      
        <div class="col-xs-6">
          <input type="number" name="num_linkage_subunits" title="1 - 10,000"
                 min="1" max="10000" data-warning="1000" step="1" 
                 onchange="fxn_auto_malloc(); validate(this)" 
                 class="form-control" value="{{num_linkage_subunits}}">
        </div>
      </div>

      <div class="form-group">
        <label for="num_linkage_subunits" class="control-label col-xs-12">
          4. Dynamic population size:</label>      
      </div>       

      <div class="form-group">
        <label for="pop_growth_model" style="left:20px" class="control-label col-xs-6">
          :: population growth model:</label>      
        <div class="col-xs-6">
          <select id="pop_growth_model" name="pop_growth_model" accesskey="5"
                  class="form-control" style="width:auto" 
                  onchange="fxn_pop_growth_model(this.value)">
            %opts = {'0': 'Off (fixed population size)', '1': 'Exponential growth', '2': 'Carrying capacity model'}
            %for key, value in opts.iteritems():
              %if key == pop_growth_model:
                <option selected value="{{key}}">{{value}}
              %else:
                <option value="{{key}}">{{value}}
              %end
            %end
          </select>
        </div>
      </div>

      <div class="form-group">
        <label for="pop_growth_rate" style="left:20px" class="control-label col-xs-6">
          :: population growth rate:</label>      
        <div class="col-xs-6">
          <input type="number" name="pop_growth_rate" class="form-control"
                 min="1" max="1.26" step="0.02" onchange="validate(this)"
                 value="{{pop_growth_rate}}">
        </div>
      </div>
       
      <div class="form-group">
        <label for="bottleneck_yes" class="control-label col-xs-6">
          5. Bottleneck?</label>      
        <div class="col-xs-6">
          <input type="checkbox" name="bottleneck_yes" value="on"
                 class="checkbox" onclick="fxn_bottleneck()" 
              % if bottleneck_yes == 'T':
                 CHECKED
              %end 
            >
        </div>
      </div>
       
      <div id="bydiv" style="display:none">

        <div class="form-group">
          <label for="bottleneck_generation" class="control-label col-xs-6">
                   &nbsp;&nbsp;&nbsp;
               :: generation when bottleneck starts:<br>
                   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                       <font size="-2"><em>note: negative values enable cyclic 
                                           bottlenecking</em></font></label>
          <div class="col-xs-6">
            <input type="number" name="bottleneck_generation"
                   value="{{bottleneck_generation}}" class="form-control"
                   min="-50000" max="50000" step="10"
                   onchange="check_bottleneck(); validate(this)" title="2 - 50,000">
          </div>
        </div>

        <div class="form-group">
          <label for="bottleneck_pop_size" class="control-label col-xs-6">
            &nbsp;&nbsp;&nbsp; :: population size during bottleneck:</label>
          <div class="col-xs-6">
            <input type="text" class="form-control" name="bottleneck_pop_size"
                   value="{{bottleneck_pop_size}}"  title="2 - 1,000">
          </div>
        </div>

        <div class="form-group">
          <label for="num_bottleneck_generations" class="control-label col-xs-6">
            &nbsp;&nbsp;&nbsp; :: duration of bottleneck - generations:</label>
          <div class="col-xs-6">
            <input type="number" name="num_bottleneck_generations" class="form-control"
                   min="1" max="5000" step="10" onchange="validate(this)"
                   value="{{num_bottleneck_generations}}" title="1 - 5,000">
          </div>
        </div>
        
      </div>

    </div>

    <!--*************************** SUBSTRUCTURE TAB ****************************-->
    <div role="tabpanel" class="tab-pane fade" id="substructure">

      <div class="form-group">
        <label for="is_parallel" class="control-label col-xs-6">
          Population substructure?</label>
        <div class="col-xs-6">
          <input type="checkbox" name="is_parallel" onclick="fxn_is_parallel()" 
                 value="on" 
                 %if is_parallel=='T':
                    checked
                 %end
          >
        </div>
      </div>

      <div id="psdiv" style="display:none">

        <div class="form-group">
          <label for="homogenous_tribes" class="control-label col-xs-6">
            1. Homogeneous subpopulations?</label>
          <div class="col-xs-6">
            <input type="checkbox" name="homogenous_tribes"
                   onclick="fxn_tribes(8)" value="on" 
                   %if homogenous_tribes=='T':
                       checked
                   %end
            >
          </div>
        </div>

        <div class="form-group">
          <label for="num_tribes" class="control-label col-xs-6">
            2. Number of subpopulations:</label>
          <div class="col-xs-6">
            <input type="number" name="num_tribes" class="form-control"
                   min="2" max="100" step="1" onchange="fxn_tribes(8)"
                   value="{{num_tribes}}" title="2 - 100">
          </div>
        </div>

        <div class="form-group">
          <label for="migration_model" class="control-label col-xs-6">
            3. Migration model:</label>
          <div class="col-xs-6">
            <select class="form-control" id="migration_model" style="width:auto"
                    name="migration_model">
                  %opts = {'1': 'Ring pass', '2': 'Stepping-stone model', '3': 'Island model'}
                  %for key, value in opts.iteritems():
                      %if key == migration_model:
                          <option selected value="{{key}}">{{value}}
                      %else:
                          <option value="{{key}}">{{value}}
                      %end
                  %end
              </select>
          </div>
        </div>

        <div class="form-group">
          <label for="num_tribes" class="control-label col-xs-6">
            4. Migrate:</label>

          <div class="input-group col-xs-6" style="width:320px; padding-left:15px">
            <input class="form-control" type="number" name="num_indiv_exchanged"
                   title="1 to Pop Size" onchange="fxn_migration()";
                   min="1" size=2 value="{{num_indiv_exchanged}}">
            <span class="input-group-addon">individual(s) per</span>
            <input type="number" name="migration_generations" class="form-control"
                   min="1" size=2 value="{{migration_generations}}">
            <span class="input-group-addon">gens</span>
          </div>
        </div>

        <div class="form-group">
          <label for="tribal_competition" class="control-label col-xs-6">
            5. Competition between subpopulations?</label>
          <div class="col-xs-6">
            <input type="checkbox" name="tribal_competition" 
              id="tribal_competition" onchange="fxn_tribes(8)" value="on"
              %if tribal_competition=='T':
                 checked
              %end
            >
          </div>
        </div>

        <div class="form-group">
          <label for="tc_scaling_factor" class="control-label col-xs-6">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            a. group selection scaling factor:</label>
          <div class="col-xs-6">
            <input type="number" name="tc_scaling_factor" id="tc_scaling_factor" 
                   min="0" max="1" step="0.1" onchange="validate(this)"
                   class="form-control" value="{{tc_scaling_factor}}"
                   title="0 - 1." readOnly=true>
          </div>
        </div>

        <div class="form-group">
          <label for="group_heritability" class="control-label col-xs-6">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            b. group heritability:</label>
          <div class="col-xs-6">
            <input type="number" name="group_heritability" 
                   title="0-1, 0: max noise 1: no noise"
                   min="0" max="1" step="0.1" value="{{group_heritability}}"
                   onchange="validate(this)" class="form-control">
          </div>
        </div>

        <div class="form-group">
          <label for="tribal_fission" class="control-label col-xs-6">
            6. Fission tribe?</label>
          <div class="col-xs-6">
            <input type="checkbox" name="tribal_fission" value="on"
              %if tribal_fission=='T':
                checked
              %end
            >
          </div>
        </div>

        <div class="form-group">
          <label for="altruistic" class="control-label col-xs-6">
            7. Upload altruistic mutations?</label>
          <div class="col-xs-6">
            <input type="checkbox" name="altruistic" value="on" 
                   onclick="show_hide_mutation_upload_form(2)" ></td>
          </div>
        </div>

        <div class="form-group">
          <label for="social_bonus_factor" class="control-label col-xs-6">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            a. social bonus scaling factor:</label>
          <div class="col-xs-6">
            <input type="number" style="width:7em;" name="social_bonus_factor"
                   class="form-control" min="0" max="1" step="0.1" 
                   value="1.0" onchange="validate(this)" title="0 - 1"></td>
          </div>
        </div>

      </div>
    </div>

    <!--*************************** COMPUTATION TAB *****************************-->
    <div role="tabpanel" class="tab-pane fade" id="computation">

      <div class="form-group">
        <label for="auto_malloc" class="control-label col-xs-6">
          1. Automatically allocate memory?</label>
        <div class="col-xs-6">
          <input type="checkbox" name="auto_malloc" value="on"
                 onclick="fxn_auto_malloc()"
                 %if auto_malloc=='T':
                    checked
                 %end
          >
        </div>
      </div>

      <div id="max_del_mutn_per_indiv" class="form-group">
        <label for="max_del_mutn_per_indiv" class="control-label col-xs-6">
          &nbsp;&nbsp;&nbsp; :: maximum deleterious mutations per individual:</label>
        <div class="col-xs-6">
          <input type="number" name="max_del_mutn_per_indiv"
                   onchange="compute_memory(); validate(this)" 
                   min="1000" max="5000000" step="1000"
                   value="{{max_del_mutn_per_indiv}}" class="form-control">
        </div>
      </div>

      <div id="max_fav_mutn_per_indiv" class="form-group">
        <label for="max_fav_mutn_per_indiv" class="control-label col-xs-6">
          &nbsp;&nbsp;&nbsp; :: maximum favorable mutations per individual:</label>
        <div class="col-xs-6">
          <input type="number" name="max_fav_mutn_per_indiv" accesskey="0"
                     onchange="compute_memory(); validate(this)"
                     min="1000" max="5000000" step="1000"
                     value="{{max_fav_mutn_per_indiv}}" class="form-control">
        </div>
      </div>

      <div id="max_neu_mutn_per_indiv" class="form-group">
        <label for="max_neu_mutn_per_indiv" class="control-label col-xs-6">
          &nbsp;&nbsp;&nbsp; :: maximum neutral mutations per individual:</label>
        <div class="col-xs-6">
          <input type="number" name="max_neu_mutn_per_indiv" accesskey="0"
                     onchange="compute_memory(); validate(this)"
                     min="1000" max="5000000" step="1000"
                     value="{{max_neu_mutn_per_indiv}}" class="form-control">
        </div>
      </div>

      <div class="form-group">
        <label for="track_neutrals" class="control-label col-xs-6">
          2. Track all mutations?<br>
          &nbsp;&nbsp;&nbsp;
          <font size="-1">(Note: must be checked if allele statistics 
                           are needed)</font></label>
        <div class="col-xs-6">
          <input type="checkbox" name="track_all_mutn" value="on"
                 onclick="fxn_track_all_mutn()"
                 %if tracking_threshold==1:
                    checked   
                 %end
          >
        </div>
      </div>
      
      <div class="form-group">
        <label for="tracking_threshold" class="control-label col-xs-6">
          &nbsp;&nbsp;&nbsp;
            To conserve memory and speed up runs, <br>
          &nbsp;&nbsp;&nbsp;
            do not track mutations with fitness effects less than:
        </label>
        <div class="col-xs-6">
          <input type="number" name="tracking_threshold"
                 onchange="validate(this)" class="form-control"
                 min="0" max="1" step="0.0001"
                 title="1e-4 ~ 1e-8" value="{{tracking_threshold}}">
        </div>
      </div>

      <div class="form-group">
        <label for="extinction_threshold" class="control-label col-xs-6">
          3. Go extinct when mean fitness reaches:</label>
        <div class="col-xs-6">
          <input type="number" name="extinction_threshold"
                 min="0" max="1" step="0.1"
                 onchange="validate(this)" class="form-control"
                 title="0-1" value="{{extinction_threshold}}">
        </div> 
      </div>  

      <div class="form-group">
        <label for="random_number_seed" class="control-label col-xs-6">
          4. Random number generator (RNG) seed:</label>
        <div class="col-xs-6">
          <input type="number" name="random_number_seed" title="1 - 1000" 
                 min="1" max="1e9" step="1" onchange="validate(this)"
                 class="form-control" value="{{random_number_seed}}">
        </div>
      </div>
       
      <div class="form-group">
        <label for="reseed_rng" class="control-label col-xs-6">
          &nbsp;&nbsp;&nbsp; :: Reseed the RNG every gen using PID&#8853;Time:<br>
          &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
          <font size="-1">(Warning: if checked, runs will not be repeatable)</font>
        </label>
        <div class="col-xs-6">
          <input type="checkbox" name="reseed_rng" value="on"
            %if reseed_rng=='T':
               checked
            %end 
          >
        </div>
      </div>

      <div class="form-group">
        <label for="write_dump" class="control-label col-xs-6">      
          5. Allow this run to be later re-started with new parameters?<br> 
          <font size="-1">&nbsp;&nbsp;&nbsp;&nbsp;
          (Note: these restart files are very large ~1GB)</font></label>
        <div class="col-xs-6">
          <input type="checkbox" name="write_dump" accesskey="3" value="on"
              %if write_dump=='T':
                 checked
              %end
          >
        </div>
      </div>

      <div class="form-group">
        <label for="restart_case" class="control-label col-xs-6">             
          6. Restart second (third, fourth) phase of run
             with these new parameters?</label>
        <div class="col-xs-6">
          <input type="checkbox" name="restart_case" accesskey="4"
            onclick="fxn_restart_case()" value="on" 
            %if restart_case=='T':
                checked
            %end
          >
        </div>
      </div>      
       
      <div id="rddiv" style="display:none">

        <div class="form-group">
          <label for="restart_dump_number" class="control-label col-xs-6">    
            &nbsp;&nbsp;&nbsp; :: restart from which phase of run:</label>
          <div class="col-xs-6">
            <input type="number" name="restart_dump_number" title="1 - 100"
                   min="1" max="100" step="1" onchange="validate(this)"
                   value="{{restart_dump_number}}" class="form-control">
          </div>
        </div>

        <div class="form-group">
          <label for="restart_case_id" class="control-label col-xs-6">    
          &nbsp;&nbsp;&nbsp; :: restart from which case ID:</label>
          <div class="col-xs-6">
            <input type="text" name="restart_case_id"
                   title="must be six letters" value="{{restart_case_id}}">
          </div>
        </div>

        <div class="form-group">
          <label for="restart_append" class="control-label col-xs-6">    
            &nbsp;&nbsp;&nbsp; :: append data to previous case:</label>
          <div class="col-xs-6">
            <input type="checkbox" name="restart_append" value="on" 
              %if restart_append=='T':
                  CHECKED
              %end 
            >
          </div>
        </div>

      </div>
       
      <div class="form-group">
        <label for="plot_allele_gens" class="control-label col-xs-6">    
            7. Compute allele frequencies every:</label>
        <div class="input-group col-xs-6" style="width:200px; padding-left:15px">
          <input type="number" name="plot_allele_gens" 
                 class="form-control" min="1" max="10000" step="1" 
                 onchange="validate(this)"
                 title="0-1" value="{{plot_allele_gens}}"> 
          <span class="input-group-addon">gens</span>
        </div>
      </div>

      <div class="form-group">
        <label for="verbosity" class="control-label col-xs-6">    
          8. Output verbosity level:</label> 
        <div class="col-xs-6">
          <select name="verbosity" class="form-control" style="width:auto" id="verbosity">
            %opts = {'0': '0-Output only history', '1': '1-Output necessary files', '2': '2-Output everything' } 
            %for key, value in opts.iteritems():
                %if key == verbosity:
                    <option selected value="{{key}}">{{value}}
                %else:
                    <option value="{{key}}">{{value}}
                %end
            %end
           </select>
          </div>
      </div>

    </div>

    <!--*********************** SPECIAL APPLICATIONS TAB *************************-->
    <div role="tabpanel" class="tab-pane fade" id="special">

      <div class="form-group">
        <label class="control-label col-xs-12">    
            1. Initial heterozygous alleles (ICA):</label>
      </div>

      <div class="form-group">
        <label for="num_contrasting_alleles" class="control-label col-xs-6">    
          &nbsp;&nbsp;&nbsp; :: number of initial contrasting alleles:<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <font size="-1">Note: fraction_recessive must be &gt; 0.0
          to work properly.</font> </label>
        <div class="col-xs-6">
          <input type="number" name="num_contrasting_alleles" title="1 - 1000"
                 min="1" max="1000" step="1" value="{{num_contrasting_alleles}}" 
                 onchange="alpha_warning(); validate(this)" class="form-control">
        </div>
      </div>

      <div class="form-group">
        <label for="max_total_fitness_increase" class="control-label col-xs-6">    
          &nbsp;&nbsp;&nbsp; :: maximum total fitness increase:<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <font size="-1">Note: this value must be &gt; 0 for ICA to work.</font> </label>
        <div class="col-xs-6">
          <input type="number" name="max_total_fitness_increase" title="0 - 1"
              value="{{max_total_fitness_increase}}" min="0" max="1" step="0.1"
              onchange="validate(this)"
              class="form-control">
        </div>
      </div>

      <div class="form-group">
        <label for="track_neutrals" class="control-label col-xs-6">    
          2. Include neutrals in analysis:</label>
        <div class="col-xs-6">
          <input type="checkbox" name="track_neutrals" onclick="fxn_track_neutrals()"
            %if track_neutrals=='T':
            checked
            %end
          >
        </div>
      </div>

      <div class="form-group">
        <label for="fraction_neutral" class="control-label col-xs-6">    
          &nbsp;&nbsp;&nbsp;    
          :: fraction of genome which is non-functional <em>junk</em>:</label>
        <div class="col-xs-6">
          <input type="number" name="fraction_neutral" id="fmun"
                 value="{{fraction_neutral}}" class="form-control"
                 min="0" max="1" step="0.1"
                 onchange="fxn_fraction_neutral(); fxn_auto_malloc(); validate(this)"
                 title="0 - 1">
        </div>
      </div>

      <div class="form-group">
        <label for="uneu" class="control-label col-xs-6">    
          &nbsp;&nbsp;&nbsp; :: neutral mutation rate: </label>
        <div class="col-xs-6">
          <input name="uneu" type="number" class="form-control" readOnly=true>
        </div>
      </div>

      <div class="form-group">
        <label for="polygenic_beneficials" class="control-label col-xs-6">    
          3. Waiting time experiments?</label>
        <div class="col-xs-6">
          <input type="checkbox" name="polygenic_beneficials" 
                     title="" onclick="fxn_polygenic_beneficials()" 
            %if polygenic_beneficials=='T':
              checked
            %end
          >
        </div>
      </div>

      <div class="form-group">
        <label for="polygenic_init" class="control-label col-xs-6">    
          &nbsp;&nbsp;&nbsp; :: initialization sequence:</label>
        <div class="col-xs-6">
          <input type="text" name="polygenic_init" id="polygenic_init" 
                 value="{{polygenic_init}}" class="form-control"
                 onchange="fxn_polygenic_target()" title="e.g. AAAAA">
        </div>
      </div>

      <div class="form-group">
        <label for="polygenic_target" class="control-label col-xs-6">    
          &nbsp;&nbsp;&nbsp; :: target sequence:</label>
        <div class="col-xs-6">
          <input type="text" name="polygenic_target" id="pbnr"
                 value="{{polygenic_target}}" class="form-control"
                 title="e.g. TCGTCG">
        </div>
      </div>

      <div class="form-group">
        <label for="polygenic_effect" class="control-label col-xs-6">    
          &nbsp;&nbsp;&nbsp; :: fitness effect associated with target:</label>
        <div class="col-xs-6">
          <input type="number" name="polygenic_effect" id="pbnr" class="form-control"
                 min="0" max="1" step="0.001" onchange="validate(this)"
                 value="{{polygenic_effect}}" title="0.0-1.0">
        </div>
      </div>

    </div>

  </div> 
  <!--*********************** END TAB CONTENT *************************-->


  <div id="upload_mutations_div" style="display:none" align="center">
    <fieldset style="background-color: white">
      <legend>Upload Mutations</legend>
      <table>
      <tr>
        <td><input type="hidden" name="mutn_file_id" style="width:7em;"
                   title="Currently this filename cannot be changed" 
                   readOnly="true"></td>
        <td></td>  
      </tr>
      </table>

      <font size="+1">
        <a href="/static/apps/mendel/upload_mutations.xlsx">download worksheet</a> ::
        <label name="upload_mutn_link"><a href="javascript:cid=dmi.case_id.value;popUp('mutn_upload.pl?run_dir=/Library/WebServer/Documents/mendel_user_data&user_id=wes&case_id=' + cid + '&mutn_file_id=',600,600);">upload mutations</a></label> ::
        <label name="upload_mutn_link"><a href="javascript:cid=dmi.case_id.value;mfid=dmi.mutn_file_id.value;popUp('more.pl?user_id=wes&case_id='+cid+'&file_name='+mfid+'&nothing=',600,600);">view mutations</a></label> 
      </font>
    </fieldset>
  </div>

  <input type="hidden" name="run_queue" value="builtin">
  <input type="hidden" name="engine" value="f">
  <input type="hidden" name="data_file_path" value="{{data_file_path}}">
  <br>

  </form>

</div> <!-- container-fluid -->

<div class="bs-example">
    <div id="myModal" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <!-- Content will be loaded here -->
            </div>
        </div>

    </div>
</div>

<script>
  $(document).ready(function() {    
    $('#desc').tagsinput('add', 'v2.5.1');
    $('[data-toggle="tooltip"]').tooltip(); 
  });
  dmi = document.mendel_input;
  //fxn_synergistic_epistasis_disable();
  document.getElementById("ptv").style.display = "none";
  dmi.pop_growth_rate.readOnly = false;
  // set select option boxes with proper values
  document.getElementById('fitness_distrib_type').value={{fitness_distrib_type}};
  document.getElementById('selection_scheme').value={{selection_scheme}};
  document.getElementById('pop_growth_model').value={{pop_growth_model}};
  document.getElementById('migration_model').value={{migration_model}};
</script>

%include('footer')
