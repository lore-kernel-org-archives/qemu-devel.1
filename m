Received: from eggs.gnu.org ([2001:4830:134:3::10]:53285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fiLEK-0000C4-GP
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 10:57:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fiLEH-00077N-IU
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 10:57:32 -0400
Received: from mail-sn1nam02on0093.outbound.protection.outlook.com
	([104.47.36.93]:27612
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fiLEH-00075G-AP
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 10:57:29 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Wed, 25 Jul 2018 14:57:25 +0000
Message-ID: <BN7PR08MB48689A35963D033DA1AD56B5C6540@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1532453527-22911-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1532453527-22911-49-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1532453527-22911-49-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 48/55] linux-user: Add target_syscall.h
 header for nanoMIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Sent: Tuesday, July 24, 2018 7:32 PM
> From: Aleksandar Rikalo <arikalo@wavecomp.com>
>=20
> Add target_syscall.h header for nanoMIPS.
>

target_syscall.h is missing

#ifndef NANOMIPS_TARGET_SYSCALL_H
#define NANOMIPS_TARGET_SYSCALL_H

...

#endif

Aleksandar M.=
