Received: from eggs.gnu.org ([209.51.188.92]:47746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1gyGtQ-0004zY-TS
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 09:06:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1gyGtF-0008CV-ST
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 09:05:59 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:37444)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1gyGtB-000885-Iw
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 09:05:51 -0500
Received: by mail-wm1-x332.google.com with SMTP id x10so8134799wmg.2
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 06:05:43 -0800 (PST)
MIME-Version: 1.0
From: G 3 <programmingkidx@gmail.com>
Date: Mon, 25 Feb 2019 09:05:30 -0500
Message-ID: <CAKyx-3Paa6_RreGZw3sT+qmwu1=_DLnR_RDxa_gN20vwD1EnLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Questions about EDID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel qemu-devel <qemu-devel@nongnu.org>

Hi Gerd, I was wondering if you have made any documentation for your EDID
patches. If you have could you provide a link please?

Also could a feature be added that allows the user to specify resolutions
to be made available to the guest?

Maybe it could work like this: -device VGA,edid=on,res=1366x768,7680x4320

Thank you.
