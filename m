Received: from eggs.gnu.org ([2001:4830:134:3::10]:37490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wlfightup@gmail.com>) id 1e44Mt-0004Eh-Em
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 08:19:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wlfightup@gmail.com>) id 1e44Ms-0003VJ-NL
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 08:19:39 -0400
Received: from mail-oi0-x232.google.com ([2607:f8b0:4003:c06::232]:45899)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <wlfightup@gmail.com>) id 1e44Ms-0003UT-JC
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 08:19:38 -0400
Received: by mail-oi0-x232.google.com with SMTP id f66so24767052oib.2
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 05:19:37 -0700 (PDT)
MIME-Version: 1.0
From: Paul Schlacter <wlfightup@gmail.com>
Date: Mon, 16 Oct 2017 20:19:36 +0800
Message-ID: <CADak6y6tAEZoO544xK3A5EnJ_mL4hQNJOZA6-_WOYrio9_Krgg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] use qemu dataplane report '.x-data-plane' not found
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

qemu-kvm: -device
virtio-blk-pci,scsi=off,bus=pci.0,addr=0x5,drive=drive-virtio-disk0,id=virtio-disk0,bootindex=1:
Property '.x-data-plane' not found

What is wrong with this report? is Compiler qemu lost parameters?
