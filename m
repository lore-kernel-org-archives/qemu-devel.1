Received: from eggs.gnu.org ([2001:4830:134:3::10]:55550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gRcqv-0002Re-Ly
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:52:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gRcqt-00017G-3S
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:52:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43905)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gRcqs-000172-Up
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:52:31 -0500
Date: Tue, 27 Nov 2018 10:52:25 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181127125225.GA18284@habkost.net>
References: <20181127092801.21777-1-marcandre.lureau@redhat.com>
	<20181127092801.21777-15-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181127092801.21777-15-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 v4 14/28] qom: remove unimplemented
 class_finalize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>

On Tue, Nov 27, 2018 at 01:27:47PM +0400, Marc-Andr=E9 Lureau wrote:
> Instead of trying to implement something that isn't well specified,
> remove it. (it would be tricky to implement, since a class struct is
> memcpy on children types...)
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

--=20
Eduardo
