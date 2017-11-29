Received: from eggs.gnu.org ([2001:4830:134:3::10]:54072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wlsaidhi@gmail.com>) id 1eJxqA-0007QL-9X
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 03:35:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wlsaidhi@gmail.com>) id 1eJxq9-0006H4-0F
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 03:35:34 -0500
Received: from mail-lf0-x22d.google.com ([2a00:1450:4010:c07::22d]:43880)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <wlsaidhi@gmail.com>) id 1eJxq8-0006GX-Oc
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 03:35:32 -0500
Received: by mail-lf0-x22d.google.com with SMTP id 94so2885161lfy.10
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 00:35:32 -0800 (PST)
MIME-Version: 1.0
From: william lin <wlsaidhi@gmail.com>
Date: Wed, 29 Nov 2017 02:34:50 -0600
Message-ID: <CAGC02hTe8SijuwrM0ZGg04=To0GBnPUrC23iKuc-pao65vAAUQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] [Bug 645662] x87 fpu emulation not accurate enough
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello,

I have been looking into this bug
<https://bugs.launchpad.net/qemu/+bug/645662> for a school project, and
after reproducing the bug and tracing through the code, I have run into a
wall trying to figure out the best way to approach this. If there is anyone
who is familiar with qemu's fpu and is willing, any tips or suggestions
will be fantastic.

Thanks,

Will & Wes
