Received: from eggs.gnu.org ([2001:4830:134:3::10]:38003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anatoly.trosinenko@gmail.com>) id 1eg60r-0007lI-VP
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 04:46:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anatoly.trosinenko@gmail.com>) id 1eg60n-0001wL-DT
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 04:46:05 -0500
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:36007)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anatoly.trosinenko@gmail.com>)
	id 1eg60n-0001w0-92
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 04:46:01 -0500
Received: by mail-oi0-x22b.google.com with SMTP id 24so1562422oij.3
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 01:46:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180129082727.jvh4nc2cquuqylrv@sirius.home.kraxel.org>
References: <CAE5jQCeSL5fRXBh5F9L3G5JkkwmS=sU9VS6Bu82Xpq5fMd=K8Q@mail.gmail.com>
	<20180129082727.jvh4nc2cquuqylrv@sirius.home.kraxel.org>
From: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Date: Mon, 29 Jan 2018 12:45:59 +0300
Message-ID: <CAE5jQCccUxqTR4H6Ap+cTcPwvxtNaqCA9eAFg7ZfeSxMe85MpQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] SDL2 UI behavior of switching views
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

Got it, thank you!

29 =D1=8F=D0=BD=D0=B2. 2018 =D0=B3. 11:27 =D0=94=D0=9F =D0=BF=D0=BE=D0=BB=
=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D1=82=D0=B5=D0=BB=D1=8C "Gerd Hoffmann" <kra=
xel@redhat.com>
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:

> On Sun, Jan 28, 2018 at 06:43:44PM +0300, Anatoly Trosinenko wrote:
> > When QEMU is run with GTK UI, it changes what is drawn on its single
> window
> > when I press Ctrl-Alt-{1,2,3,4}. But when I use SDL2 UI, it opens
> multiple
> > windows: a separate window per each view (display, monitor, serial,
> > parallel). Is it by design or is it a bug?
>
> It's intentional.  With gtk you can have separate windows too (try
> "View/Detach Tab").
>
> cheers,
>   Gerd
>
>
