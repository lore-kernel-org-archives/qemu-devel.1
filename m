Received: from eggs.gnu.org ([2001:4830:134:3::10]:44744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ricardo.ribalda@gmail.com>) id 1dXEmL-0000wU-Ot
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 18:46:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ricardo.ribalda@gmail.com>) id 1dXEmL-0005jf-1l
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 18:46:13 -0400
Received: from mail-it0-x233.google.com ([2607:f8b0:4001:c0b::233]:36589)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ricardo.ribalda@gmail.com>)
	id 1dXEmK-0005i5-Qs
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 18:46:12 -0400
Received: by mail-it0-x233.google.com with SMTP id a62so11733214itd.1
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 15:46:11 -0700 (PDT)
MIME-Version: 1.0
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Tue, 18 Jul 2017 00:45:49 +0200
Message-ID: <CAPybu_2GjvyCJHzgbA1_oeiHU=enbK5U0kz+J6dQGr1m1V9vtA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Different feature status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

Hi

I am missing the following functionality to fully emulate an AMD bulldozer v4:

-mno-avx
-mno-avx2
-mno-f16c
-mno-fma
-mno-fma4
-mno-prfchw
-mno-rdrnd
-mno-xop

I was wondering if there is any documentation with the features that
are planned to be implemented, and who is implementing them. (Google
is not my friend today)

I might work on implementing some of those and I do not want to step
into anyones foot, or redo work.

Thanks!

-- 
Ricardo Ribalda
