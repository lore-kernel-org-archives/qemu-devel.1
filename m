Received: from eggs.gnu.org ([209.51.188.92]:46573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carpeddiem@gmail.com>) id 1h1yhQ-0004Zq-4M
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 14:29:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carpeddiem@gmail.com>) id 1h1yhL-0000FV-5q
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 14:28:57 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:35773)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carpeddiem@gmail.com>)
	id 1h1yhJ-0000AB-7G
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 14:28:54 -0500
Received: by mail-io1-f65.google.com with SMTP id x4so14611610ion.2
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 11:28:45 -0800 (PST)
MIME-Version: 1.0
References: <1551695576-13205-1-git-send-email-thuth@redhat.com>
	<a0b53ff0-1ded-2a6e-aa4d-b1f4fcc407c1@redhat.com>
	<73da2fd2-dca4-495f-6824-8abb62c3e045@redhat.com>
In-Reply-To: <73da2fd2-dca4-495f-6824-8abb62c3e045@redhat.com>
From: Ed Maste <emaste@freebsd.org>
Date: Thu, 7 Mar 2019 14:28:32 -0500
Message-ID: <CAPyFy2Bp3m3twUddvFrnUSnJyJsb=BfKHP3gxXhFch3k0ZrVMQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] cirrus.yml: Add macOS continuous
 integration task
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Li-Wen Hsu <lwhsu@freebsd.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On Mon, 4 Mar 2019 at 06:39, Thomas Huth <thuth@redhat.com> wrote:
> >
> > Can we get report of failures? (IRC, mail to ML, patchew icon)
>
> Honestly, I've got no clue ... this is the only help text that I've
> found so far:
>
>  https://cirrus-ci.org/guide/notifications/

I asked on twitter and was pointed at that same link, which in turn
leads to https://github.com/cirrus-actions/email but I'm not quite
sure what to do with it.
