Received: from eggs.gnu.org ([2001:4830:134:3::10]:46726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gRdd0-0002c3-BJ
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:42:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gRdcz-00083F-PI
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:42:14 -0500
Date: Tue, 27 Nov 2018 11:41:54 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181127134154.GM18284@habkost.net>
References: <20181127092801.21777-1-marcandre.lureau@redhat.com>
	<20181127092801.21777-11-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181127092801.21777-11-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 v4 10/28] qom: make interface types
 abstract
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Corey Minyard <minyard@acm.org>, "Michael S. Tsirkin" <mst@redhat.com>, "open list:PReP" <qemu-ppc@nongnu.org>, "open list:ARM" <qemu-arm@nongnu.org>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, imammedo@redhat.com, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Stefan Berger <stefanb@linux.ibm.com>

On Tue, Nov 27, 2018 at 01:27:43PM +0400, Marc-Andr=E9 Lureau wrote:
> Interfaces don't have instance, let's make the interface type really
> abstract to avoid confusion.
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

What about updating the documentation at qom/object.h with
examples?

--=20
Eduardo
