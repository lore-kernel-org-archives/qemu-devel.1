Received: from eggs.gnu.org ([2001:4830:134:3::10]:38078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a175818323@gmail.com>) id 1f8gRA-0004OA-5E
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 02:19:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a175818323@gmail.com>) id 1f8gR9-0005Ag-H9
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 02:19:24 -0400
Received: from mail-io0-x234.google.com ([2607:f8b0:4001:c06::234]:38728)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a175818323@gmail.com>)
	id 1f8gR9-0005AP-BH
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 02:19:23 -0400
Received: by mail-io0-x234.google.com with SMTP id h9-v6so1083536iob.5
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 23:19:22 -0700 (PDT)
MIME-Version: 1.0
From: Bob Chen <a175818323@gmail.com>
Date: Wed, 18 Apr 2018 14:19:20 +0800
Message-ID: <CAMxP3BSFEuknshd05kSn8EjNuv8F8aPGuNFG3qUd0Ap6GbZFrQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Latest v2.12.0-rc4 has compiling error, rc3 is OK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

fatal error: ui/input-keymap-atset1-to-qcode.c: No such file or directory

Build on my CentOS 7.
