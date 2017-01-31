Received: from eggs.gnu.org ([2001:4830:134:3::10]:48989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYbNo-0003ba-OZ
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:34:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYbNl-000416-KR
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:34:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cYbNl-00040u-Dy
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:34:13 -0500
Message-ID: <1485880450.1076.7.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 31 Jan 2017 17:34:10 +0100
In-Reply-To: <CAFEAcA9MbE1QwcXaxOEot4J0+Fua8mXOG-KoxQOdcD4vWmwcsg@mail.gmail.com>
References: <1485877831-28786-1-git-send-email-kraxel@redhat.com>
	<CAFEAcA9MbE1QwcXaxOEot4J0+Fua8mXOG-KoxQOdcD4vWmwcsg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PULL v2 00/11] ui patch queue
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

On Di, 2017-01-31 at 16:22 +0000, Peter Maydell wrote:
> On 31 January 2017 at 15:50, Gerd Hoffmann <kraxel@redhat.com> wrote:
> >   Hi,
> >
> > Here comes the ui patch queue.  Nothing outstanding here.  Bugfixes and
> > small improvements all user interfaces.
> >
> > v2 updates:
> >   * change "C.utf-8" locale to "C.UTF-8".
>=20
> > Kevin Wolf (1):
> >       gtk: Hardcode LC_CTYPE as C.utf-8
>=20
> ...commit message no longer matches change.

Subject is unchanged indeed.  The update is noted in the body of the
commit message though.  Is that good enough or do you want a v3 pull
with the subject updated too?

cheers,
  Gerd
