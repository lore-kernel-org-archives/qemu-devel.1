Received: from eggs.gnu.org ([209.51.188.92]:54696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gs3Ru-000367-04
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 05:31:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gs3Ro-0005xE-6D
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 05:31:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gs3Rj-0005t3-60
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 05:31:50 -0500
Date: Fri, 8 Feb 2019 11:31:31 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190208103131.g57h35pxw4vofnd2@sirius.home.kraxel.org>
References: <87d0o24u0s.fsf@dusky.pond.sub.org>
	<2b9153c1-2a2d-f55a-3c00-121752bf3036@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b9153c1-2a2d-f55a-3c00-121752bf3036@redhat.com>
Subject: Re: [Qemu-devel] Maintainers, please git-am -m
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Palmer Dabbelt <palmer@sifive.com>, Richard Henderson <richard.henderson@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Anthony PERARD <anthony.perard@citrix.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

  Hi,

> >    with without
> >      65       2 Gerd Hoffmann <kraxel@redhat.com>

Oops.  Two slipped through:(

> I'd like to, but I can't. I'm still using git 1.8 and the -m parameter
> is not supported there yet.

rhel-7 software collection has newer git (2.9) available.

HTH,
  Gerd
