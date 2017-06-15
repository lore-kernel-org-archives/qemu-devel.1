Received: from eggs.gnu.org ([2001:4830:134:3::10]:42948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dLZMG-0002YB-Q4
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 14:19:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dLZMF-00006H-Tl
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 14:19:04 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:34166)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dLZMF-000068-Nb
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 14:19:03 -0400
Received: by mail-wm0-x231.google.com with SMTP id d64so1614569wmf.1
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 11:19:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8abfe17b-3fed-81c9-aad4-f99f31243c31@redhat.com>
References: <20170614105547.Horde.Qq_wt1XJCR6spCHFrm8xE9K@www.quantumachine.net>
	<CAFEAcA8idTcunTM61VVOnHSgryo1ZS5wK+MkZgCnn5C0h4+KuA@mail.gmail.com>
	<8abfe17b-3fed-81c9-aad4-f99f31243c31@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Jun 2017 19:18:42 +0100
Message-ID: <CAFEAcA-Ex2Ve5gya1foMUrHSgSoMFd_oKfo+5h5G_ac5NSi82w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] DragonFly BSD support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: =?UTF-8?Q?Antonio_Huete_Jim=C3=A9nez?= <tuxillo@quantumachine.net>, QEMU Developers <qemu-devel@nongnu.org>

On 15 June 2017 at 19:09, John Snow <jsnow@redhat.com> wrote:
> Peter, do we have a wiki page detailing what it takes to get an
> operating system considered "supported" with hints and tips for
> prospective maintainers?

We don't, but as you say there aren't that many cases where
it will come up in future, and one of the primary requirements
is "care enough to come and talk to us", so personally I'm
happy just dealing with this on the mailing list.

thanks
-- PMM
