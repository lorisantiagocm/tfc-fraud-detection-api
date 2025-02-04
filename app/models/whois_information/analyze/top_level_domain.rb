class WhoisInformation::Analyze::TopLevelDomain < Micro::Case
  attributes :top_level_domain

  TRUSTABLE_TERMS = %w[com br net io ai gov edu org int]
  COUNTRY_TERMS = %w[ac ad ae af ag ai al am ao ar as at au aw ax az ba bb bd be bf bg bh bi bj bm bn bo br bs
    bt bv bw by bz ca cc cd cf cg ch ci ck cl cm cn co cr cu cv cw cx cy cz de dj dk dm do dz ec ee eg er es
      et eu fi fj fk fm fo fr ga gb gd ge gf gg gh gi gl gm gn gp gq gr gs gt gu gw gy hk hm hn hr ht hu id ie
      il im in io iq ir is it je jm jo jp ke kg kh ki km kn kp kr kw ky kz la lb lc li lk lr ls lt lu lv ly ma
      mc md me mg mh mk ml mm mn mo mp mq mr ms mt mu mv mw mx my mz na nc ne nf ng ni nl no np nr nu nz om pa
      pe pf pg ph pk pl pm pn pr ps pt pw py qa re ro rs ru rw sa sb sc sd se sg sh si sj sk sl sm sn so sr st
      su sv sx sy sz tc td tf tg th tj tk tl tm tn to tr tt tv tw tz ua ug uk us uy uz va vc ve vg vi vn vu wf
      ws ye yt za zm zw]

  def call!
    found_country_terms = []
    found_trustable_terms = []

    TRUSTABLE_TERMS.each do |term|
      found_trustable_terms << term if top_level_domain == term
    end

    COUNTRY_TERMS.each do |country_term|
      found_country_terms << country_term if top_level_domain == country_term
    end

    Success result: { top_domain_trusted_terms: found_trustable_terms, top_domain_country_terms: found_country_terms }
  end
end
