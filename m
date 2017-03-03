Received: from eggs.gnu.org ([2001:4830:134:3::10]:45907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjmaH-0001uy-S5
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 07:45:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjmaH-0004Z7-94
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 07:45:21 -0500
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:36057)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjmaH-0004Yq-2O
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 07:45:21 -0500
Received: by mail-wm0-x232.google.com with SMTP id n11so14441743wma.1
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 04:45:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1488435591-17882-1-git-send-email-mst@redhat.com>
References: <1488435591-17882-1-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Mar 2017 12:44:59 +0000
Message-ID: <CAFEAcA9CBuoswsNT5DX=rhJTRj-NKJpO5yyvEDpiuMwSRymyYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/15] virtio, pc: fixes, features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 2 March 2017 at 06:20, Michael S. Tsirkin <mst@redhat.com> wrote:
>  dtc                                  |   2 +-

I just noticed this erroneous submodule update in here, unfortunately
after I pushed it to master :-(

I'll fix up the tree...

thanks
-- PMM
