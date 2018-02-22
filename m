Received: from eggs.gnu.org ([2001:4830:134:3::10]:48631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linus.walleij@linaro.org>) id 1eotDm-0008U0-AC
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:55:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linus.walleij@linaro.org>) id 1eotDl-0008F1-FE
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:55:46 -0500
Received: from mail-it0-x22a.google.com ([2607:f8b0:4001:c0b::22a]:55165)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <linus.walleij@linaro.org>)
	id 1eotDl-0008E9-9N
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:55:45 -0500
Received: by mail-it0-x22a.google.com with SMTP id p204so6741108itc.4
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 07:55:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA82fEnt6oGz7O+zPZ2+zoZmhm0J6rAioX6SmJwoSykuGw@mail.gmail.com>
References: <CACRpkda9B=frmS0QF429p-q+KoCKG=5NON-kQ0Rt-nba2powRA@mail.gmail.com>
	<1519053606-9817-1-git-send-email-minyard@acm.org>
	<1519053606-9817-3-git-send-email-minyard@acm.org>
	<CAFEAcA-jTZMDNTF2rPn20DjSxu=z7n9M+2xo-pNfAYoha_LuzQ@mail.gmail.com>
	<03f96a6b-3a52-0d72-e634-8b8f167f2992@acm.org>
	<CACRpkdYMTojtHnafK+kMnm1G7j+9Nj=p65WLZGbrN8MJv+4psQ@mail.gmail.com>
	<CAFEAcA82fEnt6oGz7O+zPZ2+zoZmhm0J6rAioX6SmJwoSykuGw@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 22 Feb 2018 16:55:44 +0100
Message-ID: <CACRpkdaYKzQHHxCOZEydL2pa3iX60oCsXvX7FvBZkXbByo6Z5A@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Corey Minyard <minyard@acm.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Corey Minyard <cminyard@mvista.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, Feb 22, 2018 at 4:44 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 22 February 2018 at 15:39, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Tue, Feb 20, 2018 at 2:06 PM, Corey Minyard <minyard@acm.org> wrote:
>>> Linus, Philippe, do you want me to submit this, or do you want
>>> to take it?  You can pull it from:
>>>
>>> https://github.com/cminyard/qemu.git tags/i2c-bus-move
>>
>> I don't have any commit rights, if you can push this to the
>> QEMU master I will happily rebase my stuff and resubmit :)
>
> I suggest you take Corey's 2 patches, add them to the front
> of your patchset and add your signed-off-by line to them.
> That way you don't have to wait for them to go into git master.

OK no problem!

Yours,
Linus Walleij
