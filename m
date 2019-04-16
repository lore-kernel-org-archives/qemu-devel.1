Received: from eggs.gnu.org ([209.51.188.92]:39956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hGTyJ-00081p-G1
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 15:42:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hGTyI-0000mV-JJ
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 15:42:23 -0400
Received: from mail-yw1-xc29.google.com ([2607:f8b0:4864:20::c29]:46565)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1hGTyI-0000m7-Cq
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 15:42:22 -0400
Received: by mail-yw1-xc29.google.com with SMTP id v127so7744939ywe.13
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 12:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAMo8BfLCON2wbQ36dkVQ92tcVPWoPdje12CqySFnJyoYDDOdDg@mail.gmail.com>
	<20190416074135.qo4l3vra2g6n2rts@steredhat.homenet.telecomitalia.it>
	<06b923b2-8406-b599-f3b8-a300bb6a22a5@weilnetz.de>
In-Reply-To: <06b923b2-8406-b599-f3b8-a300bb6a22a5@weilnetz.de>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 16 Apr 2019 12:42:09 -0700
Message-ID: <CAMo8BfLjo0HJM5KhLX6rgyC-7m266DMte8bqk=tWFVZQOH+91Q@mail.gmail.com>
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
To: Stefan Weil <sw@weilnetz.de>
Cc: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On Tue, Apr 16, 2019 at 9:13 AM Stefan Weil <sw@weilnetz.de> wrote:
> On 16.04.19 09:41, Stefano Garzarella wrote:
> > there was an issue when we introduced PVH support and we fixed it. [1]
> > Maybe the build that you used (20190218) was compiled before the merge of
> > that fix (20190311).
>
> The build of qemu-w64-setup-20190218.exe only contains patches merged up
> to that date, so the fix is missing.
>
> The next release of the installer will include the fix.

Thank you both, that explains what I see. I'll wait for the next windows build,
am not a fan of building for that platform.

-- 
Thanks.
-- Max
