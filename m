Received: from eggs.gnu.org ([2001:4830:134:3::10]:32866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1er0gV-0008Ru-H8
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 07:18:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1er0gR-0002bK-T4
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 07:18:11 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34640 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1er0gR-0002bG-Nm
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 07:18:07 -0500
Date: Wed, 28 Feb 2018 13:18:06 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180228121806.wbp4lyqwrt62mgpq@sirius.home.kraxel.org>
References: <20180227080724.13585-1-kraxel@redhat.com>
	<CAFEAcA_k9pXrfkLQSSG5UTYOteMZEZXErMCh6-3Wgj42mGqrfw@mail.gmail.com>
	<20180228062634.eh3xknbo7oosi5fo@sirius.home.kraxel.org>
	<CAFEAcA-uvP2U_83bsiBE7ujEyZVBUiHDmQVzk3f872HRLq5A9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-uvP2U_83bsiBE7ujEyZVBUiHDmQVzk3f872HRLq5A9Q@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/12] Ui 20180227 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

> > I think modularizing SDL isn't that easy then.
> > Can you just drop the "sdl: build as ui module" patch?
> 
> I can't drop patches from signed pull requests -- you need
> to respin it.

Ah, right, that would invalidate the signature.  Pull resent.

cheers,
  Gerd
