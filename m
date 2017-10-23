Received: from eggs.gnu.org ([2001:4830:134:3::10]:38180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stou4r@gmail.com>) id 1e6gvb-00020R-CP
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 13:54:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stou4r@gmail.com>) id 1e6gva-0003VA-ME
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 13:54:19 -0400
Received: from mail-pf0-x22a.google.com ([2607:f8b0:400e:c00::22a]:52295)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stou4r@gmail.com>) id 1e6gva-0003UF-Ga
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 13:54:18 -0400
Received: by mail-pf0-x22a.google.com with SMTP id e64so17644509pfk.9
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 10:54:18 -0700 (PDT)
MIME-Version: 1.0
From: Deema B <stou4r@gmail.com>
Date: Mon, 23 Oct 2017 10:54:15 -0700
Message-ID: <CACw_XP-db29mRwBoQSLUXuUWKExVM1voxbhWDe+a5oXOGXXm=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Command line option "-option-rom" doesn't take the ROM
 file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi,

I'm trying to use the -option-rom option to supply my own virtio OpROM.

I am not able to see the ROM being launch (the built-in version comes up
instead).
The only way I am able to make it work is to rebuild the Qemu and iPXE
together.

I'm assuming this is working feature, and I'm simply doing something wrong.
Appreciate any suggestions, pointers, and to hear your experience with this
particular option.

 - Deema.
