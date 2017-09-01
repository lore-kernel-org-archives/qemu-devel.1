Received: from eggs.gnu.org ([2001:4830:134:3::10]:39156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dnuVj-0003vs-2l
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 18:34:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dnuVe-0002gG-GT
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 18:33:59 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:37988)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dnuVe-0002fJ-B2
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 18:33:54 -0400
Received: by mail-wm0-x243.google.com with SMTP id u26so1333158wma.5
	for <qemu-devel@nongnu.org>; Fri, 01 Sep 2017 15:33:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2c31126f-81fb-7cd2-9575-8071e3623ab9@redhat.com>
References: <20170901105023.11108-1-kraxel@redhat.com>
	<CAKmqyKMUVEb13Ffv5YsovOTRAaQ8g=Q2C=U4FzWWZuygAdMwdA@mail.gmail.com>
	<2c31126f-81fb-7cd2-9575-8071e3623ab9@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 1 Sep 2017 15:33:22 -0700
Message-ID: <CAKmqyKOm22hYjwfiA0PgYDcThA-5U4eT4bNjELXjqWW-kvKocg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] pixman: drop submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Fri, Sep 1, 2017 at 3:17 PM, Eric Blake <eblake@redhat.com> wrote:
> On 09/01/2017 05:13 PM, Alistair Francis wrote:
>> 'On Fri, Sep 1, 2017 at 3:50 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
>>> Drop pixman submodule and support for the "internal" pixman build.
>>> pixman should be reasonable well established meanwhile that we don't
>>
>>
>> Is there any use case for '--with-system-pixman now?
>>
>> Overall I think this is fine, Pixman does seem to be pretty common. I
>> verified that RHEL7 has a new enough version, not sure about RHEL6
>> though.
>
> pixman-devel-0.32.8-1.el6.x86_64

Great! In which case having a version of pixman available seems reasonable.

Thanks,
Alistair

>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>
