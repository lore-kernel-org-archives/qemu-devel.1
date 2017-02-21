Received: from eggs.gnu.org ([2001:4830:134:3::10]:34356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cg6x3-0004Bi-C4
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 04:41:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cg6x2-0007aS-KM
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 04:41:41 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <CABHMSTVDnAxAvpp81+z_2fkAFO7tazLJs3cFXpuDuuGQj-Ek-A@mail.gmail.com>
	<1933406e-2576-e687-3545-a72f3b999310@redhat.com>
	<bf1410bc-bc6d-bb29-5591-55634f25d487@redhat.com>
	<CABHMSTUsZy0u4b1b84YC5CgafKvD-Zms5dCQ=31+XnQphUQxLA@mail.gmail.com>
	<20170217064327.GB21716@lemon.lan>
	<CAFEAcA8_f8SVX+rirAFBJ76ZiXaKUwh9uO0AeBFoR7G_q8pGDg@mail.gmail.com>
	<6ab86cf8-4780-ca76-f648-ac0ce211e27b@redhat.com>
	<CABHMSTWN2KdAXDjEEbyWio6rNM2FuDk_NUj40mFW0HdyZFu68g@mail.gmail.com>
	<fc3b6729-6739-5daf-5e78-85fbd7d3260d@redhat.com>
	<CABHMSTUS4Oi5WZt0NcYaOnX9_u8zQeu=CupLVX2LjvD+mTYATg@mail.gmail.com>
	<ac569867-6629-7b56-0bf1-85f15b52f143@redhat.com>
Date: Tue, 21 Feb 2017 10:41:37 +0100
In-Reply-To: <ac569867-6629-7b56-0bf1-85f15b52f143@redhat.com> (Eric Blake's
	message of "Mon, 20 Feb 2017 21:02:13 -0600")
Message-ID: <87wpcjlw32.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Fix build break during configuration on musl-libc
 based Linux systems.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Chad Joan <chadjoan@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>

Eric Blake <eblake@redhat.com> writes:

[...]
> 'git send-email -s' can also add Signed-off-by: lines, if you didn't add
> them earlier (but only if you use send-email, rather than attachments) :)

That's fine, as you *should* use git send-email.

If it looks unattractive to you because it needs some setup, then that's
because you haven't wasted your time failing at all the alternatives.

Hiding patches in attachments counts as failure.

We should be nice about new contributors failures, of course.  Still,
you might want to spend your new contributor goodwill budget on more
interesting mistakes ;)
