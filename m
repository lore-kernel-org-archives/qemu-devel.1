Received: from eggs.gnu.org ([2001:4830:134:3::10]:39604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gAZwJ-0002Sw-K3
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:19:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gAZwE-0008Ee-J0
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:19:39 -0400
Received: from mail-bl2nam02on0130.outbound.protection.outlook.com
	([104.47.38.130]:33926
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gAZwE-0008Dc-Cf
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:19:34 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Thu, 11 Oct 2018 12:19:31 +0000
Message-ID: <BN6PR2201MB12510F030208D6D43766AD0DC6E10@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1539256947-22807-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1539256947-22807-18-git-send-email-aleksandar.markovic@rt-rk.com>,
	<43cd472e-cc66-469c-e4d3-6d4db71e4494@redhat.com>
In-Reply-To: <43cd472e-cc66-469c-e4d3-6d4db71e4494@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 17/22] target/mips: Implement emulation
 of nanoMIPS EVA instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Stefan Markovic <smarkovic@wavecomp.com>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, "laurent@vivier.eu" <laurent@vivier.eu>, Petar Jovanovic <pjovanovic@wavecomp.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>


> What about NMS core without caches? Shouldn't we use:
>
>                       check_nms(ctx);

I don't see any support in the nanoMIPS documentation for this.

Thanks,
Aleksandar=
