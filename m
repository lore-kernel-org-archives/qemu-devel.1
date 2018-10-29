Received: from eggs.gnu.org ([2001:4830:134:3::10]:36547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gHEbN-0003TM-1c
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 16:57:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gHEbC-0002Gh-F5
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 16:57:27 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:50593)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gHEbB-0002Dp-Te
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 16:57:22 -0400
References: <1540821315-28346-1-git-send-email-stefan.markovic@rt-rk.com>
	<BN6PR2201MB1251DB91FBD5E2C3FF3F3A67C6F30@BN6PR2201MB1251.namprd22.prod.outlook.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <ffa4f303-311b-a6f2-f591-e6ead03c885e@vivier.eu>
Date: Mon, 29 Oct 2018 21:56:11 +0100
MIME-Version: 1.0
In-Reply-To: <BN6PR2201MB1251DB91FBD5E2C3FF3F3A67C6F30@BN6PR2201MB1251.namprd22.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 0/6] target/mips: Add support for
 prctl() PR_GET_FP_MODE and PR_SET_FP_MODE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, Stefan Markovic <stefan.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>

Le 29/10/2018 à 15:53, Aleksandar Markovic a écrit :
>> From: Stefan Markovic <stefan.markovic@rt-rk.com>
>> Subject: [PATCH v2 0/6] target/mips: Add support for prctl() PR_GET_FP_MODE and PR_SET_FP_MODE
>>
>> From: Stefan Markovic <smarkovic@wavecomp.com>
>>
>> This series includes support for prctl() PR_GET_FP_MODE and PR_SET_FP_MODE. This requires
>> extracting MIPS.abiflags section from ELF file and fp_abi value handling.
> 
> Stefan, the patch titles don't have appropriate prefixes "elf:" and "user-mode:", but I can fix that while integrating.
> 
> Laurent, heads up: I plan to include this series in a MIPS pull request that is planned for today.

No problem. I didn't have the time to do anything today.

Thanks,
Laurent
