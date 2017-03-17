Received: from eggs.gnu.org ([2001:4830:134:3::10]:51878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1coreg-0003O4-D6
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 09:10:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1coreb-0007Vn-E1
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 09:10:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1coreb-0007Uv-8j
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 09:10:49 -0400
Message-ID: <1489756242.4270.6.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Fri, 17 Mar 2017 14:10:42 +0100
In-Reply-To: <20170317115631.GG8050@redhat.com>
References: <1489748902-21765-1-git-send-email-peter.maydell@linaro.org>
	<20170317114953.GF8050@redhat.com>
	<CAFEAcA8Sky0cX+7U257AdG=imYYcdqRgL--o=86xCHMY6Kr3zw@mail.gmail.com>
	<20170317115631.GG8050@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] configure: Warn about deprecated hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, "patches@linaro.org" <patches@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>

On Fri, 2017-03-17 at 11:56 +0000, Daniel P. Berrange wrote:
> > Yeah. I'm just struggling with setting up a FreeBSD VM so we
> > can compile test that. Interesting that GNU/kFreeBSD has users.
>=C2=A0
> I wouldn't go so far as to say GNU/kFreeBSD has users. It had a few peo=
ple
> who have noticed bits of libvirt didn't compile at times, but I'm not s=
ure
> if they actually used the result, or were just building libvirt for sak=
e of
> having full platform coverage in Debian packages.

GNU/kFreeBSD is no longer a release architecture as of
Debian 8.

--=C2=A0
Andrea Bolognani / Red Hat / Virtualization
