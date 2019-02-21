Received: from eggs.gnu.org ([209.51.188.92]:60329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gws1z-00047D-AH
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 12:21:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gws1t-0001nd-Rb
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 12:21:07 -0500
Received: from mail-dm3nam05on0711.outbound.protection.outlook.com
	([2a01:111:f400:fe51::711]:22976
	helo=NAM05-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gws1r-0001jg-Jt
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 12:21:01 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Thu, 21 Feb 2019 17:20:43 +0000
Message-ID: <BN6PR2201MB125126B1D6FE31AF45612BACC67E0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1550166444-22882-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<CAFEAcA_AX-AkSnXFCB8eKHQ0+yAFFpRK2pRaTokwHu5kZtOAtA@mail.gmail.com>
In-Reply-To: <CAFEAcA_AX-AkSnXFCB8eKHQ0+yAFFpRK2pRaTokwHu5kZtOAtA@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PULL 00/15] MIPS queue for February 14th, 2019
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

> Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
> for any user-visible changes. (I note that the "MIPS" section is
> currently quite empty-looking.)

You are right, some items (that had already been integrated) were missing.
I made the section more verbose, and hopefully there will be more items
there by March 12th.

Just want to tell you that some of the MIPS changes since 3.1 are not
visible to the end user (cleanups, tests, and some features that will be
enabled/activated at some point in the future, but not before 4.0), so it
looks more appropriate to me that they are not mentioned in the 4.0
release notes.

Regards,
Aleksandar=
