Received: from eggs.gnu.org ([209.51.188.92]:54749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hCDIw-0001pp-Fo
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 21:06:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hCDIt-0003Av-Q8
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 21:06:02 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:38929)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hCDIm-0002uM-6w
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 21:05:54 -0400
Received: by mail-ot1-x331.google.com with SMTP id f10so4153383otb.6
	for <qemu-devel@nongnu.org>; Thu, 04 Apr 2019 18:05:51 -0700 (PDT)
MIME-Version: 1.0
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 5 Apr 2019 03:05:49 +0200
Message-ID: <CAL1e-=i3-uUNfQhrgxtty2EzgmPOiU9YNAEw+TDjXCwgmkmi0Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] QUESTION: How to measure performance of the emulation
 of a single target instruction?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello, folks.

There is some optimization activity in MIPS target, and we have some simple
micro-benchmarks for measuring speed of emulation of a single target
instruction, but I am not particulary happy with them. They are just a
single instruction assembly within a =E2=80=9Cfor=E2=80=9C loop. I tried so=
me other
approaches, but couldnt get results that made sense.

Do you have some suggestion or idea what would be a good way for such
measurements?

Grateful,

Aleksandar
