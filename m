Received: from eggs.gnu.org ([2001:4830:134:3::10]:42129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dgyKf-0004vq-Rp
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 15:13:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dgyKc-00038T-OF
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 15:13:53 -0400
Received: from mail-io0-x229.google.com ([2607:f8b0:4001:c06::229]:36129)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dgyKc-00038B-J9
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 15:13:50 -0400
Received: by mail-io0-x229.google.com with SMTP id g35so33350402ioi.3
	for <qemu-devel@nongnu.org>; Sun, 13 Aug 2017 12:13:50 -0700 (PDT)
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Message-Id: <C2D23A89-6DB7-445C-BC25-71E9E49C288D@gmail.com>
Date: Sun, 13 Aug 2017 15:13:48 -0400
Subject: [Qemu-devel] Help with Windows NT 4.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

Lately I found out that Windows NT 4.0 seems to work well with the 486 =
and pentium processors. Using "-cpu 486" made installing it actually =
work. Now I am seeing another issue. When I boot Windows NT 4.0 I see =
this error message:

*** STOP: 0x0000007B (0x807A8610,0x00000000,0x00000000,0x00000000)
INACESSIBLE_BOOT_DEVICE

Would anyone know a way to solve this issue?=20=
