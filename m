Received: from eggs.gnu.org ([2001:4830:134:3::10]:57560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1egivp-00075F-Iq
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 22:19:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1egivk-0008Ca-M4
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 22:19:29 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35138)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fzheng@redhat.com>) id 1egivk-0008Bp-Ez
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 22:19:24 -0500
Received: by mail-wm0-f53.google.com with SMTP id r78so5118593wme.0
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 19:19:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180129110426.GA20446@stefanha-x1.localdomain>
References: <20180129033133.31288-1-famz@redhat.com>
	<20180129110426.GA20446@stefanha-x1.localdomain>
From: Fam Zheng <famz@redhat.com>
Date: Wed, 31 Jan 2018 11:18:52 +0800
Message-ID: <CAK1Eb9m9D=BKpDchKBPkzRL1uwwi+Xoa3us+ggDgVLBC4fQpuQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] docs: Add docs/devel/testing.rst
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>

On Mon, Jan 29, 2018 at 7:04 PM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Mon, Jan 29, 2018 at 11:31:33AM +0800, Fam Zheng wrote:
>
> Thanks for writing this!
>
> I have only reviewed some parts in detail.

Thanks for the review! I've made all the fixes (except for the buses
spelling. :).

Fam
