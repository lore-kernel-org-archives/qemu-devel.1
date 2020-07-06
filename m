Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB06AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:19:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80098206DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:19:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80098206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsUm9-00062t-Pp
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 13:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jsUQa-00025h-OM; Mon, 06 Jul 2020 12:57:14 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:41299)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jsUQY-0005f4-GT; Mon, 06 Jul 2020 12:57:12 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MsI0I-1kl0ix03Ni-00thYz; Mon, 06 Jul 2020 18:57:05 +0200
Subject: Re: [PATCH] MAINTAINERS: Update Radoslaw Biernacki email address
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>, Leif Lindholm <leif@nuviainc.com>,
 qemu-arm <qemu-arm@nongnu.org>
References: <20200512170704.9290-1-rad@semihalf.com>
 <80ccdde4-77db-4e83-f711-6a7c389c31bf@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <fbd2ee79-2000-39f0-a97e-13067422abe0@vivier.eu>
Date: Mon, 6 Jul 2020 18:57:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <80ccdde4-77db-4e83-f711-6a7c389c31bf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:1yNW51V8QhtTgYyNclqyyRtrPwlDTPYSUezMqVH47r0l987INat
 z7HeggZzwBpeKKIimZRSc0N3s8UgIPNwAtJLjKMGVaNLwrQr/fL6+X+AJHSiKoDk6H0Oj9V
 6vaXgHq3b6B/alAF/SWcs3+FzBksAF2U7OQ5vMO9cWZg1ZsIfmFs+6WCKrZs6KaODcMtmSa
 1aTlf1QxbcO2H59OmI6zw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UgvZdlQCYME=:pMEDa1TmoSQJj51UImNJSH
 AHKtfXIu0G9WSUun1z+Xkz7GLU/TG/mahT5Eed2QT7K5krnLzfZXtJOSCMpeauvVs6Xdra0ya
 5T/BhDBC5UPqf+nBf4YvyYCIYbkonDGnd/yRRbn1WbDXX++ZUCf9lXzo5vnEIpSlCFRExZZXc
 Ur/zs/XiM4llT15q7mZkXGFW2A6uC0t8Ye6MHvLvroSL0ifjmpgMZyCxFZC7Hblk8xsPFB7Rz
 1BF973vA4ecNCwMjcTXceEfnOXbRM+t3fcXwrsS4mHJdu68FZQZ6YfR3wMTSHqv8gJ+e/THQC
 8Wm/UAun5CR7/Bzus9FTSGnTstpQhq9PuYESqwzhX6QNARtL7Ds9ifmDi6/sj+EdKyOizA5Ud
 s7xoW2C4v/A4Poyjc7qQWvkatsEr3fHNHHsKfrAv3pDjldx6PvPklkCc2YdzerACUyeSFdw1Q
 nPSqi33GJml3bixGnGOFil4P3J36AXgh4ooMSE4NPDN8yBJHZZRSw9UN76fEv9QIoEypsifiq
 /6K8wGWbmAzAg4MDkSwR9yZWXew+wi0UvVRDw+Tk3njFg3w4LYxoxp51C0A/SNrTYGI8O+GKo
 pCBc01goMDldsKxubIuseghGCvqGY8rDv85yy3sQxKbSVkXeM7OEJmy5ie16BFnpNoCsFB4aN
 AVx0XKdzJRMODDoI5gBTSWLU0hAFyCdUOescpl4CDdXhTwkWclY8/uTLcZQKRmsQNU511GvZK
 5KZVkPh19l0DpRZ35fhO+cvkBpPZT8lDwdcm0m7ZJSxAAif6iQytAfLkuNJt6slmaEVl6lHZp
 akW3YJyoRw2SJCi1KtOMxSQnhiyYymmNuXT58dzyH3ebdTfBWiyYoQiFTDklrrLwUUYw/8C
Received-SPF: none client-ip=212.227.126.134; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 12:45:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 04/07/2020 à 18:12, Philippe Mathieu-Daudé a écrit :
> Cc'ing qemu-trivial...
> 
> On 5/12/20 7:07 PM, Radoslaw Biernacki wrote:
>> My Linaro account is no longer active and stop forwarding emails to me.
>> Changing it to my current employer domain.
>>
>> Signed-off-by: Radoslaw Biernacki <rad@semihalf.com>
>> ---
>>  .mailmap    | 1 +
>>  MAINTAINERS | 2 +-
>>  2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/.mailmap b/.mailmap
>> index 6412067bde..668da447e3 100644
>> --- a/.mailmap
>> +++ b/.mailmap
>> @@ -46,6 +46,7 @@ Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com> <arikalo@wavecomp.com>
>>  Anthony Liguori <anthony@codemonkey.ws> Anthony Liguori <aliguori@us.ibm.com>
>>  James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
>>  Leif Lindholm <leif@nuviainc.com> <leif.lindholm@linaro.org>
>> +Radoslaw Biernacki <rad@semihalf.com> <radoslaw.biernacki@linaro.org>
>>  Paul Burton <pburton@wavecomp.com> <paul.burton@mips.com>
>>  Paul Burton <pburton@wavecomp.com> <paul.burton@imgtec.com>
>>  Paul Burton <pburton@wavecomp.com> <paul@archlinuxmips.org>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 1f84e3ae2c..a9d6893036 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -799,7 +799,7 @@ F: include/hw/misc/imx6_*.h
>>  F: include/hw/ssi/imx_spi.h
>>  
>>  SBSA-REF
>> -M: Radoslaw Biernacki <radoslaw.biernacki@linaro.org>
>> +M: Radoslaw Biernacki <rad@semihalf.com>
>>  M: Peter Maydell <peter.maydell@linaro.org>
>>  R: Leif Lindholm <leif@nuviainc.com>
>>  L: qemu-arm@nongnu.org
>>
> 
> 

Applied to my trivial-patches-for-5.1 branch.

Thanks,
Laurent

