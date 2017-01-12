Received: from eggs.gnu.org ([2001:4830:134:3::10]:40688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgh8183@gmail.com>) id 1cRWxF-0008DX-TD
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 23:25:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgh8183@gmail.com>) id 1cRWxF-00022R-0W
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 23:25:37 -0500
Received: from mail-io0-x22b.google.com ([2607:f8b0:4001:c06::22b]:34416)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgh8183@gmail.com>) id 1cRWxE-0001zq-Rg
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 23:25:36 -0500
Received: by mail-io0-x22b.google.com with SMTP id l66so9924090ioi.1
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 20:25:36 -0800 (PST)
MIME-Version: 1.0
From: morgenlette madeBy <sgh8183@gmail.com>
Date: Thu, 12 Jan 2017 13:25:35 +0900
Message-ID: <CAE519-k8poR3Qi99rg__9hYWS2ACw8a=3S+cx4s1xJW6QDFSjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] Question about io mode & cache mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello.

I sent mail for question about io mode and cache mode.

When I set VM to I/O mode = native and cache mode = none,

Vm cannot boot and vm is turn off automatically.

Why cannot VM boot?
