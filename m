Received: from eggs.gnu.org ([2001:4830:134:3::10]:45863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dVhBm-0003XG-Cx
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:42:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dVhBj-0004c5-7s
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:42:06 -0400
Date: Thu, 13 Jul 2017 13:41:53 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170713164153.GZ6020@localhost.localdomain>
References: <20170713163219.9024-1-marcandre.lureau@redhat.com>
	<20170713163219.9024-28-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170713163219.9024-28-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 27/29] i386: replace g_malloc()+memcpy()
 with g_memdup()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, peter.maydell@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, Jul 13, 2017 at 06:32:17PM +0200, Marc-Andr=E9 Lureau wrote:
> I found these pattern via grepping the source tree. I don't have a
> coccinelle script for it!
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

--=20
Eduardo
