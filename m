Received: from eggs.gnu.org ([2001:4830:134:3::10]:38381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1csO4A-0000GI-N3
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 02:23:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1csO46-0006LW-Mz
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 02:23:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1csO46-0006L4-Hc
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 02:23:42 -0400
Message-ID: <1490595820.31035.7.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 27 Mar 2017 08:23:40 +0200
In-Reply-To: <CAFEAcA-RH5zqJKAkzRaB-BJBMreLPDUiDtSE639dE_1K-FfBOw@mail.gmail.com>
References: <20170316120110.11677-1-iwona260909@gmail.com>
	<20170316120110.11677-2-iwona260909@gmail.com>
	<CAFEAcA8ZBAAqYNbh_3J69W5SMXRsbW4S367Xe8ceF1C0M-RNnA@mail.gmail.com>
	<1489673540.15659.93.camel@redhat.com>
	<CAJSP0QX3z_Zn-jdi7=2qw795Ep2nG5xvWR9DqyWajnKjkCGd3g@mail.gmail.com>
	<CAFEAcA-RH5zqJKAkzRaB-BJBMreLPDUiDtSE639dE_1K-FfBOw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] Dead code removal: removing code for
 unsupported DEPTH.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, iwona260909@gmail.com, QEMU Developers <qemu-devel@nongnu.org>

  Hi,

> Also worth pointing at an example of a patchset that does
> this for some other device, eg Gerd's recent pl110 set,
> as a guide to what's getting removed.

that was sm501 ;)

https://patchwork.ozlabs.org/patch/735753/
https://patchwork.ozlabs.org/patch/735764/

cheers,
  Gerd
