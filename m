Received: from eggs.gnu.org ([209.51.188.92]:50842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1grjkX-0005Rp-GU
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:29:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1grjkW-00070Z-OD
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:29:53 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:49026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1grjkW-0006tU-HK
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:29:52 -0500
Date: Thu, 7 Feb 2019 15:29:35 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20190207132935.ijtfsiafpfggugiz@function>
References: <20190205182848.29887-1-samuel.thibault@ens-lyon.org>
	<CAFEAcA8zvq6eUVWhAVSmaxKe4hyrDu08m==RbwKXvL+2zBDrnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8zvq6eUVWhAVSmaxKe4hyrDu08m==RbwKXvL+2zBDrnQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULLv3 00/32] More work towards libslirp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>

Peter Maydell, le jeu. 07 f=C3=A9vr. 2019 11:46:23 +0000, a ecrit:
> On Tue, 5 Feb 2019 at 18:28, Samuel Thibault
> <samuel.thibault@ens-lyon.org> wrote:
> >
> > The following changes since commit 01a9a51ffaf4699827ea6425cb2b834a35=
6e159d:
> >
> >   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20190205-pull-=
request' into staging (2019-02-05 14:01:29 +0000)
> >
> > are available in the Git repository at:
> >
> >   https://people.debian.org/~sthibault/qemu.git tags/samuel-thibault
> >
> > for you to fetch changes up to 1e924479dce65a26a7432bf5920f89c1bf957d=
74:
> >
> >   slirp: API is extern C (2019-02-05 20:27:27 +0200)
> >
> > ----------------------------------------------------------------
> > More work towards libslirp
> >
>=20
> Format string issues for the Windows build:

Oh, I am not getting these errors with make docker-test-mingw@fedora,
perhaps something would need to be fixed there to test as much as you do?

> All the other builds went OK.

Good :) I'll have a look at these formatting issues.

Samuel
