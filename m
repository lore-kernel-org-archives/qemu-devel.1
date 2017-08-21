Received: from eggs.gnu.org ([2001:4830:134:3::10]:40548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1djmgB-0001dF-Ap
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 09:23:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1djmg7-0004eK-Bu
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 09:23:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1djmg7-0004dD-5N
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 09:23:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0E2B97F7AB
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 13:23:38 +0000 (UTC)
Message-ID: <1503321812.26016.19.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 21 Aug 2017 15:23:32 +0200
In-Reply-To: <20170808224750.23904-1-marcandre.lureau@redhat.com>
References: <20170808224750.23904-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio-input: send rel-wheel events for
 wheel buttons
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>

On Wed, 2017-08-09 at 00:47 +0200, Marc-Andr=C3=A9 Lureau wrote:
> qemu uses wheel-up/down button events for mouse wheel input, however
> linux applications typically want REL_WHEEL events.

--verbose please.

Both should work just fine.

cheers,
  Gerd
