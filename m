Received: from eggs.gnu.org ([2001:4830:134:3::10]:44605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ewtcY-0002PW-At
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 13:58:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ewtcU-0003ez-EB
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 13:58:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49412 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ewtcU-0003ei-9I
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 13:58:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CCB458182D24
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 17:58:21 +0000 (UTC)
Date: Fri, 16 Mar 2018 17:58:18 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180316175817.GG3066@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180316115403.4148-1-quintela@redhat.com>
	<20180316115403.4148-11-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180316115403.4148-11-quintela@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v11 10/15] migration: Create multifd
 channels
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On Fri, Mar 16, 2018 at 12:53:58PM +0100, Juan Quintela wrote:
> In both sides.  We still don't transmit anything through them.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/ram.c | 50 ++++++++++++++++++++++++++++++++++++++++---------=
-
>  1 file changed, 40 insertions(+), 10 deletions(-)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
