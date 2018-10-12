Received: from eggs.gnu.org ([2001:4830:134:3::10]:33238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gAxLZ-0005Nz-AR
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:19:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gAxLT-0007T8-PG
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:19:17 -0400
Received: from mail-eopbgr710135.outbound.protection.outlook.com
	([40.107.71.135]:54816
	helo=NAM05-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gAxLT-0007Qd-Ep
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:19:11 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 12 Oct 2018 13:19:04 +0000
Message-ID: <BN6PR2201MB1251DC37525E1B19F1E44AC3C6E20@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1539256947-22807-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1539256947-22807-2-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539256947-22807-2-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 01/22] elf: Fix PT_MIPS_XXX constants
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
>=20
> Fix existing and add missing PT_MIPS_XXX constants in elf.h.
> This is copied from kernel header arch/mips/include/asm/elf.h.
>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
