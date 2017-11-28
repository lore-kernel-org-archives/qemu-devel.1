Received: from eggs.gnu.org ([2001:4830:134:3::10]:46504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eJh9t-0000vv-MI
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 09:46:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eJh9q-0000CH-JQ
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 09:46:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eJh9q-0000Ba-DY
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 09:46:46 -0500
Date: Tue, 28 Nov 2017 16:46:38 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171128164510-mutt-send-email-mst@kernel.org>
References: <20171127130518.26703-1-rkagan@virtuozzo.com>
	<20171127130518.26703-3-rkagan@virtuozzo.com>
	<A9252286-892F-40F4-9BE5-A9F92CC75DF9@skyportsystems.com>
	<20171128080213.GA12787@rkaganb.sw.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20171128080213.GA12787@rkaganb.sw.ru>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/2] vmgenid: use UUID property type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, Ben Warren <ben@skyportsystems.com>, QEMU Developers <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, "Denis V. Lunev" <den@openvz.org>, minyard@acm.org, "Daniel P. Berrange" <berrange@redhat.com>

On Tue, Nov 28, 2017 at 11:02:13AM +0300, Roman Kagan wrote:
> On Mon, Nov 27, 2017 at 08:38:41AM -0800, Ben Warren wrote:
> > It looks like you dropped Marc-Andr=E9 and my Reviewed-by lines.  Ple=
ase put them back.
>=20
> Oops.  I thought that the amount of changes in the first patch was too
> big to keep the R-b; however, the second patch was basically the same s=
o
> I should have put the R-b and save you extra work re-reviewing it.
> Sorry about that; hope the maintainer who will pick the patches will
> take care of R-b (unless I get more feedback that will make me respin t=
he
> set).
>=20
> Roman.

Nope, I don't have the time to mangle patches manually, but people can
ack series, or you can reply to patch youself with some else's ack.

--=20
MST
