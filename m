Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F38AC3F68F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 15:19:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67F42218AC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 15:19:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67F42218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihxaD-0004C4-Ii
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 10:19:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1ihxYZ-0002e6-Kn
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 10:17:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1ihxYY-00017p-Hg
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 10:17:39 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:41805)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1ihxYV-0000iw-TE; Thu, 19 Dec 2019 10:17:36 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1Mv2gw-1hr5st3zSS-00qx9k; Thu, 19 Dec 2019 16:17:28 +0100
Subject: Re: [PATCH] MAINTAINERS: Update Yuval Shaia's email address
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yuval Shaia <yuval.shaia@oracle.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <20191126102637.2038-1-yuval.shaia@oracle.com>
 <df5ed556-f636-0d8e-5882-89560e90e884@gmail.com>
 <cefbec21-8b62-f04d-f5ad-b211fa596569@vivier.eu>
 <9ac3330c-d2ff-beb2-dc5e-64172450eaf9@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <98b39066-93fb-540e-eef4-3b18980f25b8@vivier.eu>
Date: Thu, 19 Dec 2019 16:17:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <9ac3330c-d2ff-beb2-dc5e-64172450eaf9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:N67vDFbxGmQbVTx6yuXLA3H0RUnbFfWNd8U7vayg266taXoELdP
 gtwSMEXySqQxGBTExEZoJe8Zsvm2/GYcsR5fn19Pfk8tiAolobp8ALDZ5PUXXWeK08ddHOs
 GWp/BWhUpHWwwgejMGQAuCVK1hiuMpGNIO/zCXDYqiQPJZWUv3WW/vD3Qqwq9T+nzTpYfwN
 UrfDf2kop0euV4mi9ktKA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HoKkVgAfPlA=:usEDgbOo0QmoxXZ5Jz0q/J
 PGObzJn8pliFa6x8Wt+ZWCdNGOGUZz173LTo2hXClzDvg/Fu4/LVUEfWUVdgDw1JfeTEbiR7j
 hjojbtxqHT9rN0FIJ2aLTz1+t4+fWtHRoShLZ6G3MrxqlttBeL7ht/0MJ66eWWhiVGRrEJyUO
 MQsDhuzJKBoVZtoNRbUlXbKteFTBQKwo4L+cr7+BtDK8jczeAODvFgNK0aedKU9fiBzUh5PWw
 H+rIhZnub9NyCyqeTjlTu7WNxZKmj2bZIiLZmvFMhVI9ni+zK7uIaLo+eb7UpDRUQJMgCahDs
 4yrsWtDppVXnIavrZNzk0ghkAJMTclLP4tNy8WQBYiXZNwQ5x4dCkHNFDWbtG7rf5xbGkfODr
 UxtdnXzPab82Px9yHjlWiDGJlF2WkIc3kCut+IxWa0kV2AGqJm3T/WH+jX6/YRzJbCE/VKpte
 39c8dk3PgAU5SJbODA5s4jHmIkouzNEM1BfhRpqAIf/FfHvTQ8z9a7jIb3H5fMyY75IeG2j4X
 p92Bp+uz4HQr0iz+LPoQaTdl/3tI/iSq1xuplD2HcOqPXbCoiLH4eUPSD8ekLxK2Hq7H9t62z
 hT4tpQOMyGVcEZbNXm+ImDC7y9qvH+DkDJdpXpr4EK2dh3x//ZjYfPVcD3xng5roocgp0yNZf
 vTjtCFwPyFWN15GrkiTLQoe0ZykQ3ThoqomUyobGtXCN/XU2owDNB11uqziXTOHAKV6Te6wHK
 H+ErpOo4SB8ZiHLRIuA7UUMHV0PschoUF6wu6aEeS7xLFbzlkqX3GEDcNMTGbpaxW+dVofzSs
 ZTVGnOIORGFqnYnPftv7lVj4mzif8Y48dyPXfweBB3GEJJxUK7WC+SzYChmpCEQsEN9IY6QD+
 Vifrq61fhWuNaP8Nz2g4qZaD+Mp3coPTG4C5ZUQQU=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.72.192.74
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 19/12/2019 à 16:15, Marcel Apfelbaum a écrit :
> Hi Laurent,
> 
> On 12/19/19 11:46 AM, Laurent Vivier wrote:
>> Le 18/12/2019 à 20:50, Marcel Apfelbaum a écrit :
>>>
>>> On 11/26/19 12:26 PM, Yuval Shaia wrote:
>>>> Use gmail account for maintainer tasks.
>>>>
>>>> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
>>>> ---
>>>>    MAINTAINERS | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 5e5e3e52d6..4297b54fcb 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -2640,7 +2640,7 @@ F: tests/test-replication.c
>>>>    F: docs/block-replication.txt
>>>>      PVRDMA
>>>> -M: Yuval Shaia <yuval.shaia@oracle.com>
>>>> +M: Yuval Shaia <yuval.shaia.ml@gmail.com>
>>>>    M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>>>>    S: Maintained
>>>>    F: hw/rdma/*
>>> Hi,
>>>
>>> Can someone grab this patch ?
>> I can take this in a trivial-branch PR, but the next one will not be
>> before next week.
>>
> 
> That is ok.
> 
>> Could you add your Acked-by?
> 
> Sure,
> 
> Acked-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

Applied to my trivial-patches branch.

Thanks,
Laurent



