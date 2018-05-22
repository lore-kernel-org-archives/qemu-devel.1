Received: from eggs.gnu.org ([2001:4830:134:3::10]:50166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fL3Wz-0001WQ-E2
	for qemu-devel@nongnu.org; Tue, 22 May 2018 05:24:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fL3Wu-00009n-FA
	for qemu-devel@nongnu.org; Tue, 22 May 2018 05:24:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42830 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fL3Wu-00009M-Ap
	for qemu-devel@nongnu.org; Tue, 22 May 2018 05:24:28 -0400
Date: Tue, 22 May 2018 11:24:26 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180522092425.va3aobj53adkv3i5@sirius.home.kraxel.org>
References: <20180517092513.735-1-kraxel@redhat.com>
	<20180517092513.735-2-kraxel@redhat.com>
	<CAJ+F1C+Gq9QDBLQiuFDJ3c8gdV3kLhk_mGD8DOfkdhB2+3ic=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+F1C+Gq9QDBLQiuFDJ3c8gdV3kLhk_mGD8DOfkdhB2+3ic=Q@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 1/4] vga: move bochs vbe defines to header
 file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>

> > --- /dev/null
> > +++ b/include/hw/display/bochs-vbe.h
> > @@ -0,0 +1,64 @@
> 
> No header guards & copyright notice?

Header guards ok.

Copyright?
I don't think interface #defines like this are copyrightable ...

cheers,
  Gerd
