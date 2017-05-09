Received: from eggs.gnu.org ([2001:4830:134:3::10]:43243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1d85xB-0002JI-Rg
	for qemu-devel@nongnu.org; Tue, 09 May 2017 10:17:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1d85x7-0003aS-PX
	for qemu-devel@nongnu.org; Tue, 09 May 2017 10:17:29 -0400
Received: from mail-ua0-f170.google.com ([209.85.217.170]:33277)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1d85x7-0003Zm-MH
	for qemu-devel@nongnu.org; Tue, 09 May 2017 10:17:25 -0400
Received: by mail-ua0-f170.google.com with SMTP id e28so1066692uah.0
	for <qemu-devel@nongnu.org>; Tue, 09 May 2017 07:17:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1494338531.22189.10.camel@redhat.com>
References: <20170421091632.30900-1-kraxel@redhat.com>
	<20170421091632.30900-5-kraxel@redhat.com>
	<CABdb736fuqG1LhZYmxaZ_GMXXjTwKrQGs4M2h1Juwo=ObdyWNA@mail.gmail.com>
	<1494338531.22189.10.camel@redhat.com>
From: Ladi Prosek <lprosek@redhat.com>
Date: Tue, 9 May 2017 16:17:24 +0200
Message-ID: <CABdb734jmrsDAC1fN7KRoWzBbbU9C37jTQWnSEY7_uKm582QeA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 4/9] vga: make display updates thread safe.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Tue, May 9, 2017 at 4:02 PM, Gerd Hoffmann <kraxel@redhat.com> wrote:
>   Hi,
>
>> #4 cpu_physical_memory_snapshot_get_dirty (snap=0x555556a3b3d0,
>> start=2148532224, length=511)
>
> https://patchwork.ozlabs.org/patch/760013/

Awesome, thanks!

> cheers,
>   Gerd
