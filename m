Received: from eggs.gnu.org ([2001:4830:134:3::10]:58529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gauravs.2010@gmail.com>) id 1cacKR-0004Jx-99
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 00:59:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gauravs.2010@gmail.com>) id 1cacKQ-00051x-O8
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 00:59:07 -0500
Received: from mail-ua0-x22c.google.com ([2607:f8b0:400c:c08::22c]:35397)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <gauravs.2010@gmail.com>)
	id 1cacKQ-00051j-Im
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 00:59:06 -0500
Received: by mail-ua0-x22c.google.com with SMTP id y9so53810703uae.2
	for <qemu-devel@nongnu.org>; Sun, 05 Feb 2017 21:59:06 -0800 (PST)
MIME-Version: 1.0
From: Gaurav Sharma <gauravs.2010@gmail.com>
Date: Mon, 6 Feb 2017 11:28:24 +0530
Message-ID: <CABiB5K4pvPnNmi7q=e=PXaanMNq7QYrqZgdWLX4VRhqyR_k+LQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] Query for PCI burst support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Is it possible to generate a PCIe burst of greater than 2dw for any MMIO.
I see we have limit of max 2dw operation for any MemoryRegion defined by
the max access size.

--Thanks
