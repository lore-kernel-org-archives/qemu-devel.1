Received: from eggs.gnu.org ([2001:4830:134:3::10]:41756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fQe5E-0003Gj-5d
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:27:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fQe57-0002No-O4
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:27:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fQe57-0002NO-IH
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:26:53 -0400
Date: Wed, 6 Jun 2018 16:26:45 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180606192645.GW7451@localhost.localdomain>
References: <20180530184156.15634-1-crosa@redhat.com>
	<fe720a76-5d39-e26a-79a8-9ffb6c6b7113@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <fe720a76-5d39-e26a-79a8-9ffb6c6b7113@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 0/5] Acceptance/functional tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Fam Zheng <famz@redhat.com>, Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Amador Pahim <amador@pahim.org>

On Tue, Jun 05, 2018 at 11:49:07AM -0300, Philippe Mathieu-Daud=E9 wrote:
> Hi Eduardo,
>=20
> On 05/30/2018 03:41 PM, Cleber Rosa wrote:
> > TL;DR
> > =3D=3D=3D=3D=3D
> >=20
> > Another version, with a minimalist approach, of the acceptance tests
> > infrastructure for QEMU, based on the Avocado Testing Framework.
>=20
> What do you think of this series?
>=20
> Are you OK to take it via your tree, or should it goes via Fam's "Build
> and test automation"?

I can take it via my tree, I just couldn't reserve the time to
check the existing review comments and finish reviewing it.

But if Fam or other maintainer already thinks the series look
good and can be merged, please don't delay this because of me.

Acked-by: Eduardo Habkost <ehabkost@redhat.com>

--=20
Eduardo
