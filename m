Received: from eggs.gnu.org ([2001:4830:134:3::10]:58174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gFarp-0002uG-0u
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 04:19:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gFag7-0003t5-1h
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 04:07:42 -0400
Received: from mail-eopbgr720098.outbound.protection.outlook.com
	([40.107.72.98]:8272
	helo=NAM05-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gFag5-0003sR-IB
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 04:07:38 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Thu, 25 Oct 2018 08:07:33 +0000
Message-ID: <BN6PR2201MB1251830A8054EF6B2D5C2DA6C6F70@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1540383527-7923-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1540383527-7923-17-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540383527-7923-17-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v7 16/20] target/mips: Add emulation of MXU
 instruction D16MAC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, "jancraig@amazon.com" <jancraig@amazon.com>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>

> Subject: [PATCH v7 16/20] target/mips: Add emulation of MXU instruction D=
16MAC
>=20
> From: Craig Janeczek <jancraig@amazon.com>
>=20
> Add support for emulating the D16MAC MXU instruction.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
