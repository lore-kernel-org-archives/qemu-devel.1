Received: from eggs.gnu.org ([209.51.188.92]:56758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Mateja.Marjanovic@rt-rk.com>) id 1hBH33-0007xV-I7
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 06:53:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Mateja.Marjanovic@rt-rk.com>) id 1hBH31-0000rp-Cr
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 06:53:45 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:37391 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Mateja.Marjanovic@rt-rk.com>)
	id 1hBH2y-0000l5-CW
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 06:53:41 -0400
References: <1553845000-6537-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1553845000-6537-3-git-send-email-mateja.marjanovic@rt-rk.com>
	<CY4PR2201MB1254FCEE59DB7763A7E71EFAC6550@CY4PR2201MB1254.namprd22.prod.outlook.com>
From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
Message-ID: <1dac2b0f-03eb-b1cf-aa25-89aa533f5869@rt-rk.com>
Date: Tue, 2 Apr 2019 12:53:27 +0200
MIME-Version: 1.0
In-Reply-To: <CY4PR2201MB1254FCEE59DB7763A7E71EFAC6550@CY4PR2201MB1254.namprd22.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v3 2/5] target/mips: MSA instructions st,
 big endian host fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@wavecomp.com>


On 1.4.19. 19:58, Aleksandar Markovic wrote:
>> From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
>> Subject: [PATCH v3 2/5] target/mips: MSA instructions st, big endian host fix
>>
>> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
>>
>> Fix the case when the host is running on a big endian machine,
>> and change the approach toward st instruction helpers.
>>
>> Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
>> ---
> The same comment as in the patch 1/5.
>
> Also, please align both equation signs and argument indexes in the
> new bodies of the helpers.
It will be done in v4.
>
> Thanks,
> Aleksandar
Thanks,
Mateja
