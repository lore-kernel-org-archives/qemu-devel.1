Received: from eggs.gnu.org ([2001:4830:134:3::10]:58350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dcmWe-0004lr-Lz
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 01:48:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dcmWb-0007oO-DB
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 01:48:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dcmWb-0007nF-6y
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 01:48:53 -0400
Date: Wed, 2 Aug 2017 01:48:51 -0400 (EDT)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1988178312.746911.1501652931078.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAFEAcA-VkU5tG9fV16+vSKkQCgZ2BSoHLtwe-VhDOsbOsm9Vww@mail.gmail.com>
References: <1501604245-33460-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA-VkU5tG9fV16+vSKkQCgZ2BSoHLtwe-VhDOsbOsm9Vww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/17] Misc changes for QEMU 2.10-rc1 (?)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

> > ----------------------------------------------------------------
> > * Xen fix (Anthony)
> > * chardev fixes (Anton, Marc-Andr=C3=A9)
> > * small dead code removal (Zhongyi)
> > * documentation (Dan)
> > * bugfixes (David)
> > * decrease migration downtime (Jay)
> > * improved error output (Laurent)
> > * RTC tests and bugfix (me)
> > * Bluetooth clang analyzer fix (me)
> > * KVM CPU hotplug race (Peng Hao)
> > * Two other patches from Philippe's clang analyzer series
> >
>=20
> Applied, thanks, but can you check whatever it is in your
> workflow that's mangling non-ascii characters?

It's https://bugzilla.mozilla.org/show_bug.cgi?id=3D1017768.  Usually
I apply patches with patchew, which bypasses that bug.

Paolo
