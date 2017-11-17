Received: from eggs.gnu.org ([2001:4830:134:3::10]:40035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <makovick@gmail.com>) id 1eFek9-0000mg-8h
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 06:23:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <makovick@gmail.com>) id 1eFek4-0006o1-BH
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 06:23:33 -0500
Received: from mail-lf0-x22c.google.com ([2a00:1450:4010:c07::22c]:41077)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <makovick@gmail.com>) id 1eFek4-0006mY-2V
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 06:23:28 -0500
Received: by mail-lf0-x22c.google.com with SMTP id f134so2296305lfg.8
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 03:23:27 -0800 (PST)
From: Jindrich Makovicka <makovick@gmail.com>
Date: Fri, 17 Nov 2017 12:22:55 +0100
Message-Id: <20171117112258.5888-1-makovick@gmail.com>
Subject: [Qemu-devel] [PATCH v4] SDL2 various fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

Hi,

here is a respin of the three remaining patches, with checkpatch errors
corrected.

Also added the Fixes: line for "sdl2 uses surface relative coordinates",
and an explaining comment to "sdl2: Ignore UI hotkeys".

Regards, Jindrich
