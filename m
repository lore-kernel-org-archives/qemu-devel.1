Received: from eggs.gnu.org ([209.51.188.92]:55958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Mateja.Marjanovic@rt-rk.com>) id 1hBH26-0007Ep-UZ
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 06:52:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Mateja.Marjanovic@rt-rk.com>) id 1hBH03-0006fG-Up
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 06:50:40 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:45920 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Mateja.Marjanovic@rt-rk.com>)
	id 1hBH03-0006dX-Ie
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 06:50:39 -0400
References: <1553845000-6537-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1553845000-6537-2-git-send-email-mateja.marjanovic@rt-rk.com>
	<CY4PR2201MB12549D7CBB646334CF97A231C6550@CY4PR2201MB1254.namprd22.prod.outlook.com>
From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
Message-ID: <e6d5a066-908c-4911-4db5-c281bf41edf7@rt-rk.com>
Date: Tue, 2 Apr 2019 12:50:36 +0200
MIME-Version: 1.0
In-Reply-To: <CY4PR2201MB12549D7CBB646334CF97A231C6550@CY4PR2201MB1254.namprd22.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v3 1/5] target/mips: MSA instructions ld,
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


On 1.4.19. 19:56, Aleksandar Markovic wrote:
>> From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
>> Subject: [PATCH v3 1/5] target/mips: MSA instructions ld, big endian host fix
>>
> Start the title with the imperative, such as "target/mips: Fix..."
>
> Use full instruction names, as explained in previous reviews.
I will do that from now on.
>
>> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
>>
>> Fix the case when the host is running on a big endian machine,
>> and change the approach toward ld instruction helpers.
>>
>> Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Thanks,
Mateja
