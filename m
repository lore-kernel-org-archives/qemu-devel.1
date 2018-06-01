Received: from eggs.gnu.org ([2001:4830:134:3::10]:46926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fOlJ9-0002u5-Rq
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 10:45:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fOlJ5-0007Or-89
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 10:45:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:1631)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fOlJ5-0007O8-1F
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 10:45:31 -0400
References: <20180601135610.16149-1-samuel.thibault@ens-lyon.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a1f89a39-dfb8-deb6-565a-49bb14d83036@redhat.com>
Date: Fri, 1 Jun 2018 09:45:25 -0500
MIME-Version: 1.0
In-Reply-To: <20180601135610.16149-1-samuel.thibault@ens-lyon.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 0/9 v2] slirp updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: stefanha@redhat.com, jan.kiszka@siemens.com

On 06/01/2018 08:56 AM, Samuel Thibault wrote:
> The following changes since commit c181ddaa176856b3cd2dfd12bbcf25fa9c884a97:
> 
>    Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20180531-1' into staging (2018-05-31 17:00:55 +0100)
> 
> are available in the Git repository at:
> 
>    https://people.debian.org/~sthibault/qemu.git tags/samuel-thibault
> 
> for you to fetch changes up to 47335eeea8f1d14b7c6a1dd585a25a9166721168:
> 
>    slirp/ncsi: add checksum support (2018-05-31 21:19:24 +0200)

As long as you're respinning a v2, do you want a v3 that fixes the issue 
I pointed out on 1/9 (s/2.12/3.0/)?


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
