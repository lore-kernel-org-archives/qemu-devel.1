Received: from eggs.gnu.org ([2001:4830:134:3::10]:36235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gRaYU-0007Ae-Ip
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 05:25:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gRaYR-0006xg-EJ
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 05:25:22 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39015)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gRaYR-0006xE-89
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 05:25:19 -0500
Received: by mail-wm1-f68.google.com with SMTP id n133so4803387wmd.4
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 02:25:19 -0800 (PST)
References: <20181125205000.10324-1-philmd@redhat.com>
	<20181125205000.10324-8-philmd@redhat.com>
	<19bfc512-65ac-9968-3930-8b423efde241@redhat.com>
	<BN6PR2201MB12517471D0B4ADEE146C1414C6D00@BN6PR2201MB1251.namprd22.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1ce06557-1b19-c736-e2d0-674263cf4f79@redhat.com>
Date: Tue, 27 Nov 2018 11:25:16 +0100
MIME-Version: 1.0
In-Reply-To: <BN6PR2201MB12517471D0B4ADEE146C1414C6D00@BN6PR2201MB1251.namprd22.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-3.1 07/25] MAINTAINERS: Add a missing
 entry for the Fulong 2E machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, Thomas Huth <thuth@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>

On 27/11/18 10:58, Aleksandar Markovic wrote:

[moving Aleksandar reply down to avoid top-posting on technical list]

> From: Thomas Huth <thuth@redhat.com>
> On 2018-11-25 21:49, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  MAINTAINERS | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index aa17e9bbd3..81a22b2ccf 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -864,6 +864,7 @@ R: Stefan Markovic <smarkovic@wavecomp.com>
>>  S: Odd Fixes
>>  F: hw/mips/mips_fulong2e.c
>>  F: hw/isa/vt82c686.c
>> +F: hw/pci-host/bonito.c
>>
>>  F: include/hw/isa/vt82c686.h
> 
> Please remove the empty line between bonito.c and vt82c686.h - or we
> could use my patch here from last Thursday instead:
> 
>  https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg04526.html

> I like better the patch that Thomas linked to. I think Philippe should
have included Thomas' patch, rather than creating new, overlapping,
patches. Confusion about straitforward things! Aleksandar

Yes you are right, I missed Thomas's patch, so please disregard mine.

Thanks!

Phil.

> 
>  Thomas
> 
> 
