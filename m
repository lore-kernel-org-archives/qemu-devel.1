Received: from eggs.gnu.org ([209.51.188.92]:57693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Mateja.Marjanovic@rt-rk.com>) id 1hBH4f-0001AT-Ui
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 06:55:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Mateja.Marjanovic@rt-rk.com>) id 1hBH4d-0002WH-Up
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 06:55:25 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:33441 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Mateja.Marjanovic@rt-rk.com>)
	id 1hBH4b-0002Ut-QM
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 06:55:22 -0400
References: <1553845000-6537-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1553845000-6537-6-git-send-email-mateja.marjanovic@rt-rk.com>
	<CY4PR2201MB125450FAD705BA344A333FCCC6550@CY4PR2201MB1254.namprd22.prod.outlook.com>
From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
Message-ID: <d4b18b85-3a9d-8cb7-7f05-783b5ee4073a@rt-rk.com>
Date: Tue, 2 Apr 2019 12:55:20 +0200
MIME-Version: 1.0
In-Reply-To: <CY4PR2201MB125450FAD705BA344A333FCCC6550@CY4PR2201MB1254.namprd22.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v3 5/5] target/mips: Different approach
 toward INSERT MSA instr. and big endian fix
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


On 1.4.19. 20:03, Aleksandar Markovic wrote:
>> From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
>> Subject: [PATCH v3 5/5] target/mips: Different approach toward INSERT MSA instr. and big endian fix
> "Different approach toward..." -> "Refactor and fix INSERT.<B|H|W|D> instructions"

Same goes for this, change in v4.

Thanks,
Mateja
