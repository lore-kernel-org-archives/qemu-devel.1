Received: from eggs.gnu.org ([2001:4830:134:3::10]:53690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carpeddiem@gmail.com>) id 1gUfBf-0008Ku-U3
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 16:58:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carpeddiem@gmail.com>) id 1gUfBb-0000Wj-Ev
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 16:58:31 -0500
Received: from mail-io1-f54.google.com ([209.85.166.54]:43766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carpeddiem@gmail.com>)
	id 1gUfBb-0000VI-5Z
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 16:58:27 -0500
Received: by mail-io1-f54.google.com with SMTP id f10so12190322iop.10
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 13:58:27 -0800 (PST)
MIME-Version: 1.0
References: <CAPyFy2CWKEmYoYrDY=pHQVxXjMZnPts5qKVHL94yx0smTjx9bA@mail.gmail.com>
	<9b63140e-1d06-27d0-7686-226b7045931e@gmx.com>
In-Reply-To: <9b63140e-1d06-27d0-7686-226b7045931e@gmx.com>
From: Ed Maste <emaste@freebsd.org>
Date: Wed, 5 Dec 2018 16:58:14 -0500
Message-ID: <CAPyFy2BzUE-OA0PqYQtG2=QFO4n1KWEq-8PrpkxhTxYvYJVcGw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Hosted CI for FreeBSD - Cirrus CI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Wed, 5 Dec 2018 at 15:59, Kamil Rytarowski <n54@gmx.com> wrote:
>
> There are already FreeBSD, OpenBSD and NetBSD test scripts in the qemu
> project.

I see scripts under tests/vm/ for FreeBSD, NetBSD, and OpenBSD, but
they're for testing BSD guests on QEMU, while I'm interested in
building and testing QEMU on a FreeBSD host. Is there something else
that I've missed?
