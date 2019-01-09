Received: from eggs.gnu.org ([209.51.188.92]:59746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghEOT-0000DR-Dy
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 08:59:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghEOQ-00006D-FA
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 08:59:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ghEOQ-0008Q2-7f
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 08:59:38 -0500
Date: Wed, 9 Jan 2019 13:59:17 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190109135917.GP3998@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181031025712.18602-1-famz@redhat.com>
	<4f6eb24d-fe13-cbf3-907e-6b3e566e33f4@comstyle.com>
	<20181114095807.GB22784@magic> <20190109135504.GA12179@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190109135504.GA12179@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4] tests: vm: auto_install OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, Brad Smith <brad@comstyle.com>

On Wed, Jan 09, 2019 at 01:55:04PM +0000, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Nov 14, 2018 at 05:58:07PM +0800, Fam Zheng wrote:
> > On Sun, 11/11 18:20, Brad Smith wrote:
> > > ping.
> >=20
> > Queued. Will send a pull request soon.
>=20
> ping, this seems to have got lost, and is blocking us deleting SDL 1.2
> support from QEMU.

Sigh, never mind, I found the PR is here:

https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg00732.html

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
