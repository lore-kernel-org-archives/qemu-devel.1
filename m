Received: from eggs.gnu.org ([2001:4830:134:3::10]:58890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ilg@livius.net>) id 1cGLI6-0004Zc-6k
	for Qemu-devel@nongnu.org; Mon, 12 Dec 2016 02:44:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ilg@livius.net>) id 1cGLI2-0003YZ-T8
	for Qemu-devel@nongnu.org; Mon, 12 Dec 2016 02:44:54 -0500
Received: from mail-wj0-f195.google.com ([209.85.210.195]:36284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ilg@livius.net>) id 1cGLI2-0003Xn-N3
	for Qemu-devel@nongnu.org; Mon, 12 Dec 2016 02:44:50 -0500
Received: by mail-wj0-f195.google.com with SMTP id j10so10085711wjb.3
	for <Qemu-devel@nongnu.org>; Sun, 11 Dec 2016 23:44:50 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
From: Liviu Ionescu <ilg@livius.net>
In-Reply-To: <20161212073915.GC3725@lemon>
Date: Mon, 12 Dec 2016 09:43:47 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <96DEA2D0-3822-4A8C-9950-973B84AF4182@livius.net>
References: <6BBB3038-0389-4221-9A41-63800F3FF514@livius.net>
	<20161212033512.GA3725@lemon>
	<908F0328-771A-4269-8301-9A7D08BD585F@livius.net>
	<20161212073915.GC3725@lemon>
Subject: Re: [Qemu-devel] experience with SDL2, event loop & main thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: QEMU Developer <Qemu-devel@nongnu.org>


> On 12 Dec 2016, at 09:39, Fam Zheng <famz@redhat.com> wrote:
>=20
>> any idea how difficult would be to push any changes to SDL?
>=20
> Not sure I understand this question, could you be more specific?

I guess making SDL run asynchronously will need some major changes to =
the SDL source code, not simple patches that can be added to the QEMU =
build.

do you know someone who can not only implement the patches, but also =
push them to the mainstream SDL repository, to have them available to =
everyone?


regards,

Liviu
