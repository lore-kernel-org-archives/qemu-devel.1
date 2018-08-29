Received: from eggs.gnu.org ([2001:4830:134:3::10]:45193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fv3Xt-0006jt-5v
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 12:42:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fv3Xp-00008P-6U
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 12:42:17 -0400
Received: from mail-dm3nam03on0118.outbound.protection.outlook.com
	([104.47.41.118]:45133
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fv3Xo-0008SV-Sj
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 12:42:13 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Wed, 29 Aug 2018 16:42:08 +0000
Message-ID: <BN7PR08MB48687A4E92C78D63F13E05A9C6090@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <20180828130041.26445-1-jancraig@amazon.com>
In-Reply-To: <20180828130041.26445-1-jancraig@amazon.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 0/8] Add limited MXU instruction support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Craig Janeczek <jancraig@amazon.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Petar Jovanovic <pjovanovic@wavecomp.com>, Dinu Radian <dradian@wavecomp.com>

> From: Craig Janeczek <jancraig@amazon.com>
> Sent: Tuesday, August 28, 2018 3:00 PM
>
> Subject: [PATCH v3 0/8] Add limited MXU instruction support
>
> This patch set begins to add MXU instruction support for mips emulation.

Craig,

May I ask you what is the exact platform (CPU/board) that you are targeting=
 with this series? Do we need perhaps to add/modify something in translate_=
init.inc.c? I am very curious.

Thanks,
Aleksandar=
