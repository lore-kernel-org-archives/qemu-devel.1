Received: from eggs.gnu.org ([2001:4830:134:3::10]:42047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dxLpp-0006S4-Hg
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 19:33:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dxLpo-0004PR-CZ
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 19:33:45 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:55832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dxLpo-0004Ot-7E
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 19:33:44 -0400
Received: by mail-wr0-x235.google.com with SMTP id l39so19090758wrl.12
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 16:33:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <455D51CC-104C-494B-B08E-7A1FCD0CDB8E@gmail.com>
References: <455D51CC-104C-494B-B08E-7A1FCD0CDB8E@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 27 Sep 2017 16:33:22 -0700
Message-ID: <CAFEAcA86iQ_KWLocw88dyBuKCUBVP-PxDr8nZqvHJ8Bm1ZmtEQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Ping: [PATCH 0/2] ui/cocoa.m: enable guest to see
 control-alt key combinations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

On 27 September 2017 at 15:55, Programmingkid <programmingkidx@gmail.com> w=
rote:
> Currently if the user needs to send a control-alt key combination, he or =
she was either out of luck or had to rely on the monitor's sendkey command =
to do so. With this patch the user can now directly send control-alt key co=
mbinations. This is great for Windows guest that may need the control-alt-d=
elete key combination.
>

Thanks for the ping. This is on my to-review list, but I had
a quick scan of it, noticed that you didn't make the code
in patch 2 work the way I'd asked in my review of v1, thought
about just fixing it myself and then ran out of time to
look at it. I'm currently several thousand miles away from
my OSX machine...

-- PMM
