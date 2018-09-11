Received: from eggs.gnu.org ([2001:4830:134:3::10]:57267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=785d5c3bf=jancraig@amazon.com>)
	id 1fzhxN-0000iK-5I
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 08:39:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=785d5c3bf=jancraig@amazon.com>)
	id 1fzhqX-00053r-Es
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 08:32:49 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:46758)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=785d5c3bf=jancraig@amazon.com>)
	id 1fzhqX-0004tf-6C
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 08:32:45 -0400
From: "Janeczek, Craig" <jancraig@amazon.com>
Date: Tue, 11 Sep 2018 12:27:28 +0000
Message-ID: <ec22dcbb7c4b4dbabb5052a05524c1d1@EX13D12UEA003.ant.amazon.com>
References: <20180830193019.20104-1-jancraig@amazon.com>
	<BN7PR08MB48688D7CF58F3239D42AE18BC6020@BN7PR08MB4868.namprd08.prod.outlook.com>
In-Reply-To: <BN7PR08MB48688D7CF58F3239D42AE18BC6020@BN7PR08MB4868.namprd08.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
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
To: Aleksandar Markovic <amarkovic@wavecomp.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>

I plan on getting back to this development effort next week.

-----Original Message-----
From: Aleksandar Markovic <amarkovic@wavecomp.com>=20
Sent: Wednesday, September 5, 2018 9:36 AM
To: Janeczek, Craig <jancraig@amazon.com>; qemu-devel@nongnu.org
Cc: aurelien@aurel32.net
Subject: Re: [PATCH v4 0/9] Add limited MXU instruction support

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
Aleksandar
