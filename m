Received: from eggs.gnu.org ([2001:4830:134:3::10]:56018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1ee1r1-0004Nt-U8
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 11:55:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1ee1qx-0000K0-Q8
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 11:55:23 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:45283)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1ee1qx-0000JR-HS
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 11:55:19 -0500
Received: by mail-pg0-x243.google.com with SMTP id m136so668149pga.12
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 08:55:19 -0800 (PST)
Reply-To: minyard@acm.org
References: <1516064279-14816-1-git-send-email-minyard@acm.org>
From: Corey Minyard <tcminyard@gmail.com>
Message-ID: <09678455-2c70-ff07-7f2a-f4135e28e75f@gmail.com>
Date: Tue, 23 Jan 2018 10:55:15 -0600
MIME-Version: 1.0
In-Reply-To: <1516064279-14816-1-git-send-email-minyard@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Subject: Re: [Qemu-devel] [PATCH v2] Small IPMI fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: minyard@acm.org, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Eric Blake <eblake@redhat.com>

Michael?  Anyone?  Can we get these in?

Thanks

-corey

On 01/15/2018 06:57 PM, minyard@acm.org wrote:
> These are some fixes I've had for a while (mostly).  They are small
> fixes and additions for various things.  It would be nice to be able
> to get these into the upcoming release.
>
> I also add myself as the maintainer for the IPMI code, since that
> seemed appropriate.
>
> Changes in v2:
>
> I removed the "other" fixes (the one to vl.c) from the previous patch
> set, these are all IPMI-related changes.  I also moved adding myself
> as the IPMI maintainer to the first patch, per Marc-André.
>
