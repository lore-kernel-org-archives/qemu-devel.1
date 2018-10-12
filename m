Received: from eggs.gnu.org ([2001:4830:134:3::10]:57284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gB2Jd-0003Bj-Ab
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 14:37:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gB2JY-0008Ma-Q6
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 14:37:37 -0400
Received: from mail-sn1nam02on0094.outbound.protection.outlook.com
	([104.47.36.94]:7136
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gB2JY-0008KN-Ih
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 14:37:32 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 12 Oct 2018 18:37:26 +0000
Message-ID: <BN6PR2201MB1251BC5724A27538817CC45CC6E20@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1539362376-12010-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1539362376-12010-26-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539362376-12010-26-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v5 25/28] hw/mips: Add Data Scratch Pad RAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>

> Subject: [PATCH v5 25/28] hw/mips: Add Data Scratch Pad RAM
>
>From: Yongbok Kim <yongbok.kim@mips.com>
>
> The optional Data Scratch Pad RAM (DSPRAM) block provides a
general scratch pad RAM used for temporary storage of data. The
DSPRAM provides a connection to on-chip memory or memory-mapped
registers, which are accessed in parallel with the L1 data
cache to minimize access latency.
>
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---

This patch is incomplete - some files are missing.

Thanks,
Aleksandar=
