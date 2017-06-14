Received: from eggs.gnu.org ([2001:4830:134:3::10]:54138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1dL1hx-0005Vc-3c
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 02:23:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1dL1hw-0006xR-9d
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 02:23:13 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:36788)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1dL1hw-0006x8-2w
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 02:23:12 -0400
Received: by mail-wr0-x243.google.com with SMTP id 77so5979897wrb.3
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 23:23:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <9ac47825-aeb0-3dc8-3e47-7bbcad19f730@tuxfamily.org>
References: <20170608184944.19406-1-mrolnik@gmail.com>
	<20170608184944.19406-10-mrolnik@gmail.com>
	<2dba69fb-2894-5f8b-bc61-abfa97873dcf@tuxfamily.org>
	<CAK4993hf9TSqzNAs6-c-TvD2zX7rQDh4X39AyRofehfN_nsRYQ@mail.gmail.com>
	<9ac47825-aeb0-3dc8-3e47-7bbcad19f730@tuxfamily.org>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Wed, 14 Jun 2017 09:22:30 +0300
Message-ID: <CAK4993hwPzmSdXp8BXV+OH9UU8UdZWq5L3kS5QxUAmcPAPJKFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH RFC v19 09/13] target-avr: adding
 instruction decoder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <huth@tuxfamily.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Anichang <anichang@protonmail.ch>

we had this discussion previously.
1. I am not sure my generator will run on every machine as it requires some
tools e.g. xsltproc
2. once AVR finds its way into master, I will try to generate files during
the build.

On Wed, Jun 14, 2017 at 8:14 AM, Thomas Huth <huth@tuxfamily.org> wrote:

> On 13.06.2017 22:29, Michael Rolnik wrote:
> > this is generated code.
>
> Hmm, then it should likely not be included in a patch, but generated
> during built-time instead, I guess?
>
>  Thomas
>



-- 
Best Regards,
Michael Rolnik
