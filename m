Received: from eggs.gnu.org ([209.51.188.92]:40017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1hBwaX-0006lb-En
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 03:15:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1hBwaV-0002ut-LA
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 03:15:05 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135]:39780)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <randrianasulu@gmail.com>)
	id 1hBwaV-0002o1-3a
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 03:15:03 -0400
Received: by mail-lf1-x135.google.com with SMTP id m13so975272lfb.6
	for <qemu-devel@nongnu.org>; Thu, 04 Apr 2019 00:15:02 -0700 (PDT)
From: Andrew Randrianasulu <randrianasulu@gmail.com>
Date: Thu, 4 Apr 2019 10:10:09 +0300
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201904041010.10367.randrianasulu@gmail.com>
Subject: Re: [Qemu-devel] Proof of concept for GPU forwarding for Linux
 guest on Linux host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: lepton@google.com, qemu-devel@nongnu.org

Hi!

I recall I saw something like this some time ago (but in connection with qemu-user + ALSA sycallls)
So far I found this:

https://marc.info/?l=qemu-devel&m=154349285205915

List:       qemu-devel
Subject:    [Qemu-devel] Support for Intel GPU
From:       Allan Sandfeld Jensen <kde () carewolf ! com>
Date:       2018-11-29 11:54:19

Ah, found alsa bits too:
https://lists.gnu.org/archive/html/qemu-devel/2016-06/msg05334.html

None of this was merged, as far as I understand.
