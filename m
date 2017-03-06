Received: from eggs.gnu.org ([2001:4830:134:3::10]:36032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1ckvsQ-00068d-Ha
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:52:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1ckvsM-0002iI-MH
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:52:50 -0500
Received: from mail-io0-x22b.google.com ([2607:f8b0:4001:c06::22b]:36133)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1ckvsM-0002i6-Hy
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:52:46 -0500
Received: by mail-io0-x22b.google.com with SMTP id l7so117405074ioe.3
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 08:52:46 -0800 (PST)
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Date: Mon, 6 Mar 2017 11:52:44 -0500
Message-Id: <1BBA5600-3710-471F-89A5-7C332A24EBF9@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Subject: [Qemu-devel] USB mouse no longer working with Windows guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>

The USB mouse does not move when using a Windows 2000 and Windows XP =
guest. I will try to bisect the problem soon.=
