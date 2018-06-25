Received: from eggs.gnu.org ([2001:4830:134:3::10]:40895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1fXQ9d-0004Bp-8Q
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:59:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1fXQ9c-00046Q-D6
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:59:33 -0400
Message-Id: <1529927965.3221404.1419429536.7B0D907A@webmail.messagingengine.com>
From: Andrew Jeffery <andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
References: <20180625110721.22485-1-joel@jms.id.au>
	<0627e87c-6d3c-a64a-6d6d-2a632c73ebf7@amsat.org>
Date: Mon, 25 Jun 2018 21:29:25 +0930
In-Reply-To: <0627e87c-6d3c-a64a-6d6d-2a632c73ebf7@amsat.org>
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Add ASPEED BMCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: =?utf-8?Q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-devel@nongnu.org

On Mon, 25 Jun 2018, at 20:43, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Joel,
>=20
> On 06/25/2018 08:07 AM, Joel Stanley wrote:
> > This adds Cedric as the maintainer, with Andrew and I as reviewers, for
> > the ASPEED boards and the peripherals we use.
>=20
> Good idea, this should speed up ASPEED reviews.
>=20
> >=20
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > ---
> >  MAINTAINERS | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 2874ddce6097..14bcf2ed3e3d 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -644,6 +644,17 @@ M: Subbaraya Sundeep <sundeep.lkml@gmail.com>
> >  S: Maintained
> >  F: hw/arm/msf2-som.c
> >=20=20
> > +ASPEED BMCs
> > +M: C=C3=A9dric Le Goater <clg@kaod.org>
> > +R: Andrew Jeffery <andrew@aj.id.au>
> > +R: Joel Stanley <joel@jms.id.au>
> > +L: qemu-arm@nongnu.org
> > +S: Maintained
> > +F: hw/*/*aspeed*
> > +F: include/*/*aspeed*
>=20
> This line does not match, however include/hw/*/*aspeed* does.
>=20
> With that fixed:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Similarly:

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

>=20
> > +F: hw/net/ftgmac100.c
> > +F: include/hw/net/ftgmac100.h
> > +
> >  CRIS Machines
> >  -------------
> >  Axis Dev88
> >=20
