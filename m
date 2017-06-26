Received: from eggs.gnu.org ([2001:4830:134:3::10]:41024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dPPOC-0007iK-7o
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:28:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dPPO9-0001KO-3j
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:28:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49708)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dPPO8-0001K2-Tw
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:28:53 -0400
Date: Mon, 26 Jun 2017 09:28:44 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170626082844.GA4181@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1496975122-16999-1-git-send-email-cota@braap.org>
	<1496975122-16999-8-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1496975122-16999-8-git-send-email-cota@braap.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 7/7] trace: [trivial] Statically enable
 all guest events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, =?utf-8?B?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>, Stefan Hajnoczi <stefanha@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, Jun 08, 2017 at 10:25:22PM -0400, Emilio G. Cota wrote:
> From: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
>=20
> The optimizations of this series makes it feasible to have them
> available on all builds.

I'm not saying you're wrong, but where is the data to backup this
assertion ?

IMHO, this commit message should be describing how performance was
tested and what the results were.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
