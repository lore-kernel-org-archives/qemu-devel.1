Received: from eggs.gnu.org ([2001:4830:134:3::10]:60309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eS9ll-0002gr-Bv
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 17:56:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eS9lg-0005e5-Eq
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 17:56:53 -0500
Received: from mail-pl0-x22f.google.com ([2607:f8b0:400e:c01::22f]:46264)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1eS9lg-0005d0-9H
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 17:56:48 -0500
Received: by mail-pl0-x22f.google.com with SMTP id i6so11853914plt.13
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 14:56:47 -0800 (PST)
Received: from [192.168.27.3] ([47.184.168.85])
	by smtp.gmail.com with ESMTPSA id
	a23sm39143157pfa.177.2017.12.21.14.56.44 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 21 Dec 2017 14:56:45 -0800 (PST)
Reply-To: minyard@acm.org
References: <1512682213-4354-1-git-send-email-minyard@acm.org>
From: Corey Minyard <tcminyard@gmail.com>
Message-ID: <5eec8bd7-ca2f-e953-6cb5-2e40f7718c4a@gmail.com>
Date: Thu, 21 Dec 2017 16:56:44 -0600
MIME-Version: 1.0
In-Reply-To: <1512682213-4354-1-git-send-email-minyard@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Subject: Re: [Qemu-devel] [PATCH 0/8] Small IPMI (and other) fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 12/07/2017 03:30 PM, minyard@acm.org wrote:
> These are some fixes I've had for a while (mostly).  They are small
> fixes and additions for various things.  It would be nice to be able
> to get at least some of these into the upcoming release, but it's
> probably too late.
>
> I also add myself as the maintainer for the IPMI code, since that
> seemed appropriate.
>
Can someone pick this up?

-corey
