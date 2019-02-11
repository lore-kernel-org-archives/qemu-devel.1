Received: from eggs.gnu.org ([209.51.188.92]:54427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gtErC-00036G-Bg
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:54:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gtErA-0004vc-Ql
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:54:58 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:38937)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gtEr8-0004rO-DG
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:54:56 -0500
Received: by mail-ot1-x344.google.com with SMTP id n8so18620109otl.6
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 08:54:52 -0800 (PST)
MIME-Version: 1.0
References: <20190207160617.1142-1-marcandre.lureau@redhat.com>
	<20190211165026.GJ27585@redhat.com>
In-Reply-To: <20190211165026.GJ27585@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Feb 2019 16:54:40 +0000
Message-ID: <CAFEAcA-B4cm7aQkBnp5Uj_9gO2brxJXxo7j225OddopwGEyBWw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/18] Chardev patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, 11 Feb 2019 at 16:50, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Thu, Feb 07, 2019 at 05:05:59PM +0100, Marc-Andr=C3=A9 Lureau wrote:
> > The following changes since commit 632351e0e1a861f2eaf709b053c53f96a122=
5825:
> >
> >   Merge remote-tracking branch 'remotes/elmarco/tags/dump-pull-request'=
 into staging (2019-02-07 14:20:46 +0000)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/elmarco/qemu.git tags/chardev-pull-request
> >
> > for you to fetch changes up to df3afdedd23ade0c9de55cadeb1d85055689023f=
:
> >
> >   tests/test-char: add muxed chardev testing for open/close (2019-02-07=
 16:18:25 +0100)
> >
> > ----------------------------------------------------------------
> > Various chardev fixes
> >
> > ----------------------------------------------------------------
>
> BTW, I think as the maintainer sending the PULL request you are expected
> to have added your own S-o-B to every patch, rather than just a R-B.

Yes, indeed. Thanks for catching that.

-- PMM
