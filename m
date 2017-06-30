Received: from eggs.gnu.org ([2001:4830:134:3::10]:53370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dQwMs-00067d-Nv
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:53:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dQwMs-0003Ur-0V
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:53:54 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:38632)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dQwMr-0003To-Qa
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:53:53 -0400
Received: by mail-wm0-x236.google.com with SMTP id b184so46790454wme.1
	for <qemu-devel@nongnu.org>; Fri, 30 Jun 2017 06:53:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAGKXQyct2Y0DTbSRxCjyDJpR0eSZg3L245mce6QvmtPNJexcrw@mail.gmail.com>
References: <CAGKXQyct2Y0DTbSRxCjyDJpR0eSZg3L245mce6QvmtPNJexcrw@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 30 Jun 2017 14:53:52 +0100
Message-ID: <CAJSP0QUKJdeTcupGBkdj_kLS-J-LW24ym9Z-dcWf1rxWZyk6cw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] BIT_WORD(start >> TARGET_PAGE_BITS)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ali saeedi <ali.saeedi56@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Fri, Jun 30, 2017 at 2:02 PM, ali saeedi <ali.saeedi56@gmail.com> wrote:
> Hello
> what does the following code do?
> 'unsigned long page = BIT_WORD(start >> TARGET_PAGE_BITS)' ?
> thanks a lot

Aside from Eric's response, I want to mention that I've noticed your
frequent questions too.

A volunteer project like QEMU can only make progress if people "give"
more than they "take".

Each question you ask takes someone's time.  Often the person
responding searches the code base for you and then replies with the
answer.

If you keep demanding time and attention without giving back to QEMU
then people notice this and they will stop responding.

I'm not trying to attack you, just letting you know what I've often
seen happen when someone wants more support than the volunteers are
willing to give.

This is an opportunity to do two things:

1. Learn to answer your own questions by reading the code, adding
printfs, using a debugger, and other techniques.  This will make you
more independent and you'll be more productive.

2. Start contributing to QEMU by reviewing patches on the mailing
list, helping users on #qemu IRC, etc.

I'd be happy to discuss how to do these things in more detail.

Stefan
