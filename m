Received: from eggs.gnu.org ([209.51.188.92]:39656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gyI9A-0004T5-BN
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:26:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gyI96-00043B-AY
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:26:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gyI96-00042P-4l
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:26:20 -0500
Date: Mon, 25 Feb 2019 16:26:18 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190225152618.r3epnypkpu6fyokt@sirius.home.kraxel.org>
References: <CAKyx-3Paa6_RreGZw3sT+qmwu1=_DLnR_RDxa_gN20vwD1EnLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKyx-3Paa6_RreGZw3sT+qmwu1=_DLnR_RDxa_gN20vwD1EnLw@mail.gmail.com>
Subject: Re: [Qemu-devel] Questions about EDID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: G 3 <programmingkidx@gmail.com>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>

On Mon, Feb 25, 2019 at 09:05:30AM -0500, G 3 wrote:
> Hi Gerd, I was wondering if you have made any documentation for your EDID
> patches. If you have could you provide a link please?

No docs.

> Also could a feature be added that allows the user to specify resolutions
> to be made available to the guest?
> 
> Maybe it could work like this: -device VGA,edid=on,res=1366x768,7680x4320

A single resolution works (via xres + yres properties).

cheers,
  Gerd
