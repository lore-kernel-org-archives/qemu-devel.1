Received: from eggs.gnu.org ([2001:4830:134:3::10]:55926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gB2EB-0007pM-43
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 14:31:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gB2E4-0002TT-QC
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 14:31:59 -0400
Received: from mail-eopbgr690102.outbound.protection.outlook.com
	([40.107.69.102]:46592
	helo=NAM04-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gB2E4-0002TB-Gy
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 14:31:52 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 12 Oct 2018 18:31:45 +0000
Message-ID: <BN6PR2201MB125161B53D73CCB70A0F200FC6E20@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1539362376-12010-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1539362376-12010-6-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539362376-12010-6-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v5 05/28] linux-user: Add infrastructure
 for handling MIPS-specific prctl()
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

> Subject: [PATCH v5 05/28] linux-user: Add infrastructure for handling MIP=
S-specific prctl()
>
> From: Stefan Markovic <smarkovic@wavecomp.com>
>
>Add infrastructure for handling MIPS-specific prctl(). This is,
for now, just an empty placeholder. The real handling will be
implemented in subsequent patches.
>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
> linux-user/syscall.c | 8 ++++++++
> 1 file changed, 8 insertions(+)

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
