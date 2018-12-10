Received: from eggs.gnu.org ([2001:4830:134:3::10]:53731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gWMZa-0003hU-6T
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 09:30:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gWMZT-0002XQ-Ss
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 09:30:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:62206)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gWMZT-0002XI-NB
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 09:30:07 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F2A7F3001C2D
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 14:30:06 +0000 (UTC)
Date: Mon, 10 Dec 2018 15:29:56 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181210142956.wucn33osm7fxa27d@sirius.home.kraxel.org>
References: <20181126124250.29985-1-marcandre.lureau@redhat.com>
	<20181126124250.29985-2-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181126124250.29985-2-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 01/11] vhost-user: define
 conventions for vhost-user backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Mon, Nov 26, 2018 at 04:42:40PM +0400, Marc-Andr=E9 Lureau wrote:
> As discussed during "[PATCH v4 00/29] vhost-user for input & GPU"
> review, let's define a common set of backend conventions to help with
> management layer implementation, and interoperability.
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>

Acked-by: Gerd Hoffmann <kraxel@redhat.com>

btw: have you seen the idea to use a vfio-style interface for
communication between qemu and external device emulation processes?

cheers,
  Gerd
