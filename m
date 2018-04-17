Received: from eggs.gnu.org ([2001:4830:134:3::10]:41719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1f8QWc-0006Ea-RZ
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 09:19:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1f8QWZ-0001vF-L0
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 09:19:58 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:36998
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1f8QWZ-0001uh-CR
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 09:19:55 -0400
References: <CAFEAcA-FaS+HeihGmbhrLAR8e=jmz-Og+OKGakGX7MGb_KgwCw@mail.gmail.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <d002e4ff-e0c9-f66e-a25a-51605a79b55f@weilnetz.de>
Date: Tue, 17 Apr 2018 15:19:53 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-FaS+HeihGmbhrLAR8e=jmz-Og+OKGakGX7MGb_KgwCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Last call for release-critical fixes for 2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

Am 17.04.2018 um 15:03 schrieb Peter Maydell:
> I'm planning to tag rc4 this afternoon (UK time), which I expect
> to be the last rc for the 2.12 series. This is your last chance
> to flag up anything we absolutely must fix for this release.
> Please reply to this email and also update
> https://wiki.qemu.org/Planning/2.12#Known_issues
> if there's anything we've missed.
> 
> thanks
> -- PMM

Update po files? That's not a "must fix", but it would be nice to have
those files synchronized with ui/gtk.c again.

Regards
Stefan
