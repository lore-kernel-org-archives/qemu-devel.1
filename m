Received: from eggs.gnu.org ([209.51.188.92]:46997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carpeddiem@gmail.com>) id 1gjToh-0004I0-BP
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:52:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carpeddiem@gmail.com>) id 1gjTof-0003yn-8N
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:52:03 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:35774)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carpeddiem@gmail.com>)
	id 1gjTod-0003y5-H4
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:51:59 -0500
Received: by mail-it1-f194.google.com with SMTP id p197so5896745itp.0
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 10:51:58 -0800 (PST)
MIME-Version: 1.0
References: <20190115184229.73688-1-emaste@freefall.freebsd.org>
In-Reply-To: <20190115184229.73688-1-emaste@freefall.freebsd.org>
From: Ed Maste <emaste@freebsd.org>
Date: Tue, 15 Jan 2019 13:51:44 -0500
Message-ID: <CAPyFy2Dw2F3ks_5f8cvWjrsOTS0_Ybr5kELUpyHQmOQWUaeuFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] .cirrus.yml: basic compile and test for
 FreeBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>

On Tue, 15 Jan 2019 at 13:42, Ed Maste <emaste@freebsd.org> wrote:
>
> From: Ed Maste <emaste@freebsd.org>

I'm not sure what part of the path between `git send-email` and the
list moved this From: into the message body, but it's not intentional.
If someone's going to pick up this patch please edit the commit
message.

> Cirrus-CI (https://cirrus-ci.org) is a hosted CI service which supports
> several platforms, including FreeBSD.  Later on we could build for other
...
