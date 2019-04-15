Received: from eggs.gnu.org ([209.51.188.92]:44522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hGA54-0005rL-LL
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 18:28:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hGA50-0007ES-Hj
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 18:28:02 -0400
Received: from mail-yw1-xc33.google.com ([2607:f8b0:4864:20::c33]:41331)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1hGA4z-0007Dr-KD
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 18:27:58 -0400
Received: by mail-yw1-xc33.google.com with SMTP id l15so6613569ywe.8
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 15:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAMo8BfLCON2wbQ36dkVQ92tcVPWoPdje12CqySFnJyoYDDOdDg@mail.gmail.com>
In-Reply-To: <CAMo8BfLCON2wbQ36dkVQ92tcVPWoPdje12CqySFnJyoYDDOdDg@mail.gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 15 Apr 2019 15:27:45 -0700
Message-ID: <CAMo8BfKNNpDmRqLOnJ9CGzOXhir+R1vsgoFgtOBiEpHU853rMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] recent QEMU-w64 does not load multiboot kernels by
 default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>, Stefan Weil <sw@weilnetz.de>

On Mon, Apr 15, 2019 at 3:20 PM Max Filippov <jcmvbkbc@gmail.com> wrote:
> recent qemu-system-i386 for w64 (e.g. one installed from
> https://qemu.weilnetz.de/w64/qemu-w64-setup-20190218.exe )
> refuses to load multiboot kernel by default:
>
>   "C:\Program Files\qemu\qemu-system-i386.exe" -kernel p:\tmp\kernel
>   C:\Program Files\qemu\qemu-system-i386.exe: Error loading
> uncompressed kernel without PVH ELF Note

Example kernel is available here:
http://jcmvbkbc.spb.ru/~dumb/tmp/201904151526/kernel

-- 
Thanks.
-- Max
