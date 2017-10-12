Received: from eggs.gnu.org ([2001:4830:134:3::10]:45166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e2aUY-0000gp-8g
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 06:13:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e2aUX-0001I7-E8
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 06:13:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e2aUX-0001Ds-8C
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 06:13:25 -0400
Message-ID: <1507803203.26812.20.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 12 Oct 2017 12:13:23 +0200
In-Reply-To: <20171012100736.GH16125@redhat.com>
References: <20171011083604.11820-1-kraxel@redhat.com>
	<CAFEAcA9uXw7XYOBu9cKY+B=OWNbS=cRp7BKcXacLTaRLx9RWdA@mail.gmail.com>
	<20171011154951.GA6163@redhat.com>
	<CAFEAcA8OZALycKmsrC=MrftfF0YytXzRxGrzbetmSvddfTVf1g@mail.gmail.com>
	<20171012082456.GB16125@redhat.com>
	<1507800626.26812.13.camel@redhat.com>
	<20171012093337.GE16125@redhat.com>
	<1507802687.26812.17.camel@redhat.com>
	<20171012100736.GH16125@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/10] Ui 20171011 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, 2017-10-12 at 11:07 +0100, Daniel P. Berrange wrote:
> On Thu, Oct 12, 2017 at 12:04:47PM +0200, Gerd Hoffmann wrote:
> > =C2=A0 Hi,
> >=20
> > > Not AFAICT - if i try it just never completes connect()
> >=20
> > Hmm, so maybe we should mirror the thing on git.qemu.org and use
> > that?
>=20
> Can that be made 100% automated - I don't want to have to push
> changes to
> two different git repos.

Yes, seabios works that way for example.

cheers,
  Gerd
