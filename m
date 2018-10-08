Received: from eggs.gnu.org ([2001:4830:134:3::10]:47355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1g9W7w-0002yh-1c
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:03:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1g9W7n-0000Sy-FA
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:03:14 -0400
Received: from mail-eopbgr710112.outbound.protection.outlook.com
	([40.107.71.112]:60747
	helo=NAM05-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1g9W7n-0000R3-5Y
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:03:07 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 8 Oct 2018 14:03:02 +0000
Message-ID: <BN6PR2201MB12511229AE9C933EDBC0D105C6E60@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1538752793-6875-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1538752793-6875-5-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1538752793-6875-5-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 4/7] target/mips: Add bit definitions
 for DSP R3 ASE
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


> From: Stefan Markovic <smarkovic@wavecomp.com>
>
> Add DSP R3 ASE related bit definition for insn_flags and hflags.
>=20
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>

This should be integrated with other pending insn_flags cleanups.

hflags need cleaning too, but this is not planned this year. Any such
cleanup should be beyond the scope of this patch. So:

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>=
