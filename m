Received: from eggs.gnu.org ([2001:4830:134:3::10]:44501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ilg@livius.net>) id 1fSe7X-0000Hq-J1
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 03:53:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ilg@livius.net>) id 1fSe7W-0005tw-Mg
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 03:53:39 -0400
Received: from mail-yw0-x235.google.com ([2607:f8b0:4002:c05::235]:32988)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ilg@livius.net>) id 1fSe7W-0005tg-Fd
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 03:53:38 -0400
Received: by mail-yw0-x235.google.com with SMTP id u124-v6so7204183ywg.0
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 00:53:38 -0700 (PDT)
From: Liviu Ionescu <ilg@livius.net>
In-Reply-To: <20180612074157.GC15344@xz-mi>
References: <20180612062430.GA15344@xz-mi>
	<20180612064119.GC29380@lemon.usersys.redhat.com>
	<20180612065229.GB15344@xz-mi>
	<20180612070152.GD29380@lemon.usersys.redhat.com>
	<20180612074157.GC15344@xz-mi>
MIME-Version: 1.0
Date: Tue, 12 Jun 2018 00:53:36 -0700
Message-ID: <CAG7hfcJOGj6eEsDV3D6FMD2UJZNOw_7WxV=9qR5c=VHy4Bcp9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Is there a way to package QEMU binaries?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: QEMU Devel Mailing List <qemu-devel@nongnu.org>

On 12 June 2018 at 10:44:09, Peter Xu (peterx@redhat.com) wrote:

> But it'll still be good if we can have a single package to play around
> with. If there is no known way to do, we can try to figure a way out.

you can take a look at:

https://github.com/gnu-mcu-eclipse/qemu-build

the scripts can create the binary distributions for windows, linux and
macos in one run, with all required libraries and everything.

the result looks like this:

https://github.com/gnu-mcu-eclipse/qemu/releases


regards,

Liviu
