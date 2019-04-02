Received: from eggs.gnu.org ([209.51.188.92]:57406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Mateja.Marjanovic@rt-rk.com>) id 1hBH4F-0000jP-Qn
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 06:55:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Mateja.Marjanovic@rt-rk.com>) id 1hBH4D-00024c-8t
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 06:54:58 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:47087 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Mateja.Marjanovic@rt-rk.com>)
	id 1hBH4C-00023a-Qx
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 06:54:57 -0400
References: <1553845000-6537-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1553845000-6537-5-git-send-email-mateja.marjanovic@rt-rk.com>
	<CY4PR2201MB12547FD1D5E5B0260C984A79C6550@CY4PR2201MB1254.namprd22.prod.outlook.com>
From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
Message-ID: <2e4a40bc-b641-1dfa-01fa-c534e4f801ef@rt-rk.com>
Date: Tue, 2 Apr 2019 12:54:55 +0200
MIME-Version: 1.0
In-Reply-To: <CY4PR2201MB12547FD1D5E5B0260C984A79C6550@CY4PR2201MB1254.namprd22.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v3 4/5] target/mips: Different approach
 toward COPY_U MSA instr. and big endian fix
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


On 1.4.19. 20:02, Aleksandar Markovic wrote:
>> From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
>> Subject: [PATCH v3 4/5] target/mips: Different approach toward COPY_U MSA instr. and big endian fix
>>
>> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
> "Different approach toward..." -> "Refactor and fix COPY_U.<B|H|W> instructions"

Same goes for this, change in v4.

Thanks,
Mateja
