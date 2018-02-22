Received: from eggs.gnu.org ([2001:4830:134:3::10]:44593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eot3J-0007Ul-47
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:44:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eot3I-0006ZL-0P
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:44:57 -0500
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:39913)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eot3H-0006Z2-R6
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:44:55 -0500
Received: by mail-oi0-x244.google.com with SMTP id t185so3992151oif.6
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 07:44:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CACRpkdYMTojtHnafK+kMnm1G7j+9Nj=p65WLZGbrN8MJv+4psQ@mail.gmail.com>
References: <CACRpkda9B=frmS0QF429p-q+KoCKG=5NON-kQ0Rt-nba2powRA@mail.gmail.com>
	<1519053606-9817-1-git-send-email-minyard@acm.org>
	<1519053606-9817-3-git-send-email-minyard@acm.org>
	<CAFEAcA-jTZMDNTF2rPn20DjSxu=z7n9M+2xo-pNfAYoha_LuzQ@mail.gmail.com>
	<03f96a6b-3a52-0d72-e634-8b8f167f2992@acm.org>
	<CACRpkdYMTojtHnafK+kMnm1G7j+9Nj=p65WLZGbrN8MJv+4psQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 15:44:34 +0000
Message-ID: <CAFEAcA82fEnt6oGz7O+zPZ2+zoZmhm0J6rAioX6SmJwoSykuGw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/2] i2c: Move the bus class to i2c.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Corey Minyard <minyard@acm.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Corey Minyard <cminyard@mvista.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 22 February 2018 at 15:39, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Feb 20, 2018 at 2:06 PM, Corey Minyard <minyard@acm.org> wrote:
>> Linus, Philippe, do you want me to submit this, or do you want
>> to take it?  You can pull it from:
>>
>> https://github.com/cminyard/qemu.git tags/i2c-bus-move
>
> I don't have any commit rights, if you can push this to the
> QEMU master I will happily rebase my stuff and resubmit :)

I suggest you take Corey's 2 patches, add them to the front
of your patchset and add your signed-off-by line to them.
That way you don't have to wait for them to go into git master.

thanks
-- PMM
