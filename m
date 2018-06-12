Received: from eggs.gnu.org ([2001:4830:134:3::10]:45794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fSeCv-00035H-CM
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 03:59:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fSeCr-00089j-IC
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 03:59:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42880 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fSeCr-00089Z-Bv
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 03:59:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CC1B668817
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 07:59:08 +0000 (UTC)
Date: Tue, 12 Jun 2018 08:59:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180612075904.GC23739@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180611180152.2681-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180611180152.2681-1-ehabkost@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Remove COPYING.PYTHON
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>

On Mon, Jun 11, 2018 at 03:01:52PM -0300, Eduardo Habkost wrote:
> The COPYING.PYTHON file was added when we added the compatibility
> argparse.py module, which was licensed under the Python Software
> Foundation License Version 2.
>=20
> Now the compatibility argparse.py module was removed, and we are
> not carrying any code under that license anymore.  Remove
> COPYING.PYTHON.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  COPYING.PYTHON | 270 -------------------------------------------------
>  1 file changed, 270 deletions(-)
>  delete mode 100644 COPYING.PYTHON

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
