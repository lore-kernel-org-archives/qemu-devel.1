Received: from eggs.gnu.org ([2001:4830:134:3::10]:44144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fxXyy-0006NS-Kb
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 09:36:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fxXyv-00062O-QP
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 09:36:32 -0400
Received: from mail-cys01nam02on0094.outbound.protection.outlook.com
	([104.47.37.94]:22393
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fxXyu-0005wM-VZ
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 09:36:29 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Wed, 5 Sep 2018 13:36:22 +0000
Message-ID: <BN7PR08MB48688D7CF58F3239D42AE18BC6020@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <20180830193019.20104-1-jancraig@amazon.com>
In-Reply-To: <20180830193019.20104-1-jancraig@amazon.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 0/9] Add limited MXU instruction support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Craig Janeczek <jancraig@amazon.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>

> From: Craig Janeczek <jancraig@amazon.com>
> Sent: Thursday, August 30, 2018 9:30 PM
>
> Subject: [PATCH v4 0/9] Add limited MXU instruction support

> This patch set begins to add MXU instruction support for mips emulation.

Hi, Craig,

I mentioned some time ago that we planned to revamp translate.c. Related to=
 that, I would like to tweak your whole series (this will be most of the ti=
me moving code from place to place, and basically leaving your code intact,=
 just reorganized differently; I'll try to collect most of the MXU code in =
a separate file). To be efficient (avoid long explanation and email threads=
), I would like to do it just after you submit v5 - I would then submit v6,=
 and you would continue working on such modified series, creating v7 by you=
rself etc., if needed.

In relation to that, when do you plan to submit v5?

Thanks,
Aleksandar=
