Received: from eggs.gnu.org ([2001:4830:134:3::10]:55451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dxdjD-0007rL-Cq
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 14:40:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dxdj7-0005tA-JW
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 14:40:07 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:54171)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dxdj7-0005lw-CG
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 14:40:01 -0400
Received: by mail-wm0-x22e.google.com with SMTP id q132so4026408wmd.2
	for <qemu-devel@nongnu.org>; Thu, 28 Sep 2017 11:39:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6f84eb7d-6c81-f543-155c-659fd0eb5a5c@redhat.com>
References: <6f84eb7d-6c81-f543-155c-659fd0eb5a5c@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Sep 2017 11:39:38 -0700
Message-ID: <CAFEAcA9CoA+qw6kVTVLfz3pV4vfQOmPNBwofWANcYdEa4qnXuA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] List-Id change
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu devel list <qemu-devel@nongnu.org>, Jeffrey Cody <jcody@redhat.com>
List-ID: <qemu-devel.nongnu.org>

On 28 September 2017 at 11:29, Laszlo Ersek <lersek@redhat.com> wrote:
> Hi,
>
> the List-Id field of recent messages reflected by qemu-devel is no longer
>
>   <qemu-devel.nongnu.org>
>               ^^^^^^
>
> like it used to be, but
>
>   <qemu-devel.gnu.org>
>               ^^^
>
> This broke my qemu-devel filter (albeit easy enough to fix).
>
> Has this been an intentional change in the list software config?

I haven't changed anything in the mailing list config. Our mailing lists
are hosted by the gnu.org folks, and I'm pretty sure that nongnu.org
and gnu.org are the same system under the hood. It's quite possible
that a minor change there has resulted in the list-id header changing.
(You can get at the qemu-devel archives via either hostname, for
instance.)

thanks
-- PMM
