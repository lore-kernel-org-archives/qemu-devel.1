Received: from eggs.gnu.org ([2001:4830:134:3::10]:51336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fl3l6-0001or-Id
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 22:54:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fl3l2-0008Ln-Hk
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 22:54:36 -0400
Received: from mail-it0-x229.google.com ([2607:f8b0:4001:c0b::229]:55150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1fl3l2-0008Kp-Ax
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 22:54:32 -0400
Received: by mail-it0-x229.google.com with SMTP id s7-v6so1181255itb.4
	for <qemu-devel@nongnu.org>; Wed, 01 Aug 2018 19:54:32 -0700 (PDT)
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Message-Id: <D96C38EF-891A-464A-B15F-31B4235147BD@gmail.com>
Date: Wed, 1 Aug 2018 22:54:29 -0400
Subject: [Qemu-devel] QEMU 3.0 RC3 mouse problem with Windows 3.1 and NT 4.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

The mouse cursor stops working properly under Windows 3.1 and Windows NT =
4.0 after a few minutes of use. The cursor will want to stay at the very =
edges of the QEMU window.=20=
